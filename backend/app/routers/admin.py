from datetime import date, datetime, timedelta
import json
from typing import List, Optional

from fastapi import APIRouter, Depends, Header, HTTPException, Query, status
from sqlalchemy import func
from sqlalchemy.orm import Session

from .. import auth, models, schemas
from ..deps import get_current_user, get_db, require_admin


router = APIRouter()


def _iso(dt: Optional[datetime]) -> Optional[str]:
    if dt is None:
        return None
    return dt.isoformat()


@router.get("/auth/me", response_model=schemas.UserRead)
def admin_me(
    admin_user: models.User = Depends(require_admin),
) -> schemas.UserRead:
    return schemas.UserRead.model_validate(admin_user)


@router.post("/auth/login", response_model=schemas.AdminLoginResponse)
def admin_login(
    payload: schemas.AdminEmailPasswordLoginRequest,
    db: Session = Depends(get_db),
) -> schemas.AdminLoginResponse:
    user = (
        db.query(models.User)
        .filter(func.lower(models.User.email) == payload.email.strip().lower())
        .first()
    )
    if user is None or not bool(user.is_admin):
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid credentials")

    if not user.admin_password_salt or not user.admin_password_hash or not user.admin_password_iterations:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Admin password not set")

    ok = auth.verify_password(
        payload.password,
        user.admin_password_salt,
        user.admin_password_hash,
        int(user.admin_password_iterations),
    )
    if not ok:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid credentials")

    token = auth.create_access_token({"sub": str(user.id)})
    return schemas.AdminLoginResponse(token=token, user=schemas.UserRead.model_validate(user))


@router.post("/bootstrap/make-me-admin")
def admin_bootstrap_make_me_admin(
    x_system_key: str = Header(..., alias="X-System-Key"),
    db: Session = Depends(get_db),
    user: models.User = Depends(get_current_user),
) -> dict:
    if x_system_key != "careerai-internal-cron":
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Invalid system key")

    user.is_admin = True
    db.commit()
    return {"status": "ok", "user_id": user.id}


@router.post("/bootstrap/set-my-admin-password")
def admin_bootstrap_set_my_admin_password(
    payload: schemas.AdminSetPasswordRequest,
    x_system_key: str = Header(..., alias="X-System-Key"),
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(require_admin),
) -> dict:
    if x_system_key != "careerai-internal-cron":
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Invalid system key")

    if not payload.password or len(payload.password) < 6:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Password too short")

    salt, hashed, iterations = auth.hash_password(payload.password)
    admin_user.admin_password_salt = salt
    admin_user.admin_password_hash = hashed
    admin_user.admin_password_iterations = iterations
    db.commit()
    return {"status": "ok"}


@router.get("/dashboard/summary", response_model=schemas.AdminDashboardSummary)
def admin_dashboard_summary(
    days: int = Query(14, ge=7, le=90),
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(require_admin),
) -> schemas.AdminDashboardSummary:
    start_day = date.today() - timedelta(days=days - 1)
    start_dt = datetime.combine(start_day, datetime.min.time())

    total_users = db.query(models.User).count()
    total_training_plans = db.query(models.TrainingPlan).count()
    active_user_plans = db.query(models.UserTrainingPlan).filter(models.UserTrainingPlan.status == "active").count()
    total_milestones = db.query(models.MasterMilestone).count()
    completed_milestones = (
        db.query(models.UserMilestoneProgress)
        .filter(models.UserMilestoneProgress.status == "completed")
        .count()
    )

    registrations_rows = (
        db.query(func.date(models.User.created_at).label("d"), func.count(models.User.id).label("c"))
        .filter(models.User.created_at >= start_dt)
        .group_by(func.date(models.User.created_at))
        .order_by(func.date(models.User.created_at).asc())
        .all()
    )
    registrations_by_day = [{"date": str(row.d), "count": int(row.c)} for row in registrations_rows]

    logins_rows = (
        db.query(func.date(models.FaceLoginAttempt.created_at).label("d"), func.count(models.FaceLoginAttempt.id).label("c"))
        .filter(models.FaceLoginAttempt.created_at >= start_dt)
        .filter(models.FaceLoginAttempt.login_status == "success")
        .group_by(func.date(models.FaceLoginAttempt.created_at))
        .order_by(func.date(models.FaceLoginAttempt.created_at).asc())
        .all()
    )
    logins_by_day = [{"date": str(row.d), "count": int(row.c)} for row in logins_rows]

    return schemas.AdminDashboardSummary(
        total_users=total_users,
        total_training_plans=total_training_plans,
        active_user_plans=active_user_plans,
        total_milestones=total_milestones,
        completed_milestones=completed_milestones,
        registrations_by_day=registrations_by_day,
        logins_by_day=logins_by_day,
    )


@router.get("/users", response_model=schemas.AdminUserListResponse)
def admin_list_users(
    q: Optional[str] = Query(None, min_length=1, max_length=100),
    skip: int = Query(0, ge=0),
    limit: int = Query(25, ge=1, le=200),
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(require_admin),
) -> schemas.AdminUserListResponse:
    base_query = db.query(models.User)
    if q:
        like = f"%{q.strip()}%"
        base_query = base_query.filter(
            (models.User.name.ilike(like))
            | (models.User.email.ilike(like))
            | (models.User.phone.ilike(like))
        )

    total = base_query.count()
    users = base_query.order_by(models.User.created_at.desc()).offset(skip).limit(limit).all()

    items: List[schemas.AdminUserListItem] = []
    for user in users:
        onboarding = (
            db.query(models.UserOnboarding)
            .filter(models.UserOnboarding.user_id == user.id)
            .first()
        )

        role_name = None
        experience_name = None
        if onboarding and onboarding.role_id:
            role = db.query(models.Role).filter(models.Role.id == onboarding.role_id).first()
            role_name = role.name if role else None
        if onboarding and onboarding.experience_level_id:
            level = (
                db.query(models.ExperienceLevel)
                .filter(models.ExperienceLevel.id == onboarding.experience_level_id)
                .first()
            )
            experience_name = level.name if level else None

        user_plan = (
            db.query(models.UserTrainingPlan)
            .filter(models.UserTrainingPlan.user_id == user.id)
            .first()
        )

        has_plan = user_plan is not None
        total_milestones = 0
        completed_milestones = 0
        current_milestone_number = None
        if user_plan:
            current_milestone_number = user_plan.current_milestone_number
            total_milestones = (
                db.query(models.UserMilestoneProgress)
                .filter(models.UserMilestoneProgress.user_training_plan_id == user_plan.id)
                .count()
            )
            completed_milestones = (
                db.query(models.UserMilestoneProgress)
                .filter(models.UserMilestoneProgress.user_training_plan_id == user_plan.id)
                .filter(models.UserMilestoneProgress.status == "completed")
                .count()
            )

        last_login = (
            db.query(models.FaceLoginAttempt)
            .filter(models.FaceLoginAttempt.matched_user_id == user.id)
            .filter(models.FaceLoginAttempt.login_status == "success")
            .order_by(models.FaceLoginAttempt.created_at.desc())
            .first()
        )

        items.append(
            schemas.AdminUserListItem(
                id=user.id,
                name=user.name,
                email=user.email,
                phone=user.phone,
                profile_image=user.profile_image,
                created_at=_iso(user.created_at),
                role_name=role_name,
                experience_level_name=experience_name,
                has_plan=has_plan,
                current_milestone_number=current_milestone_number,
                total_milestones=total_milestones,
                completed_milestones=completed_milestones,
                last_login_at=_iso(last_login.created_at) if last_login else None,
            )
        )

    return schemas.AdminUserListResponse(total=total, users=items)


@router.get("/users/{user_id}/login-attempts", response_model=List[schemas.AdminFaceLoginAttemptRead])
def admin_user_login_attempts(
    user_id: int,
    limit: int = Query(50, ge=1, le=200),
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(require_admin),
) -> List[schemas.AdminFaceLoginAttemptRead]:
    rows = (
        db.query(models.FaceLoginAttempt)
        .filter(models.FaceLoginAttempt.matched_user_id == user_id)
        .order_by(models.FaceLoginAttempt.created_at.desc())
        .limit(limit)
        .all()
    )

    return [
        schemas.AdminFaceLoginAttemptRead(
            id=row.id,
            matched_user_id=row.matched_user_id,
            match_type=row.match_type,
            face_image_path=row.face_image_path,
            confidence_score=row.confidence_score,
            ip_address=row.ip_address,
            device_info=row.device_info,
            browser_info=row.browser_info,
            os_info=row.os_info,
            login_status=row.login_status,
            failure_reason=row.failure_reason,
            created_at=_iso(row.created_at) or "",
        )
        for row in rows
    ]


@router.get("/users/{user_id}/progress", response_model=schemas.AdminUserProgressResponse)
def admin_user_progress(
    user_id: int,
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(require_admin),
) -> schemas.AdminUserProgressResponse:
    user_plan = (
        db.query(models.UserTrainingPlan)
        .filter(models.UserTrainingPlan.user_id == user_id)
        .first()
    )
    if not user_plan:
        return schemas.AdminUserProgressResponse(user_id=user_id, milestones=[])

    training_plan = (
        db.query(models.TrainingPlan)
        .filter(models.TrainingPlan.id == user_plan.training_plan_id)
        .first()
    )

    rows = (
        db.query(models.UserMilestoneProgress, models.MasterMilestone)
        .join(
            models.MasterMilestone,
            models.UserMilestoneProgress.master_milestone_id == models.MasterMilestone.id,
        )
        .filter(models.UserMilestoneProgress.user_training_plan_id == user_plan.id)
        .order_by(models.MasterMilestone.milestone_number.asc())
        .all()
    )

    milestones: List[schemas.AdminMilestoneProgressItem] = []
    for progress, milestone in rows:
        study_total = (
            db.query(models.MasterStudyMaterial)
            .filter(models.MasterStudyMaterial.master_milestone_id == milestone.id)
            .count()
        )
        study_completed = (
            db.query(models.UserStudyMaterialProgress)
            .filter(models.UserStudyMaterialProgress.user_milestone_progress_id == progress.id)
            .filter(models.UserStudyMaterialProgress.is_completed.is_(True))
            .count()
        )
        # Build study materials detail
        sm_list = (
            db.query(models.MasterStudyMaterial)
            .filter(models.MasterStudyMaterial.master_milestone_id == milestone.id)
            .order_by(models.MasterStudyMaterial.sort_order.asc())
            .all()
        )
        progress_map = {
            p.master_study_material_id: p
            for p in db.query(models.UserStudyMaterialProgress)
            .filter(models.UserStudyMaterialProgress.user_milestone_progress_id == progress.id)
            .all()
        }
        study_detail: list[schemas.AdminStudyMaterialItem] = []
        for sm in sm_list:
            p = progress_map.get(sm.id)
            study_detail.append(
                schemas.AdminStudyMaterialItem(
                    id=sm.id,
                    title=sm.title,
                    is_completed=bool(p.is_completed) if p else False,
                    completed_at=_iso(p.completed_at) if p and p.completed_at else None,
                )
            )
        last_attempt = (
            db.query(models.UserQuizAttempt)
            .filter(models.UserQuizAttempt.user_milestone_progress_id == progress.id)
            .order_by(models.UserQuizAttempt.attempted_at.desc())
            .first()
        )
        last_quiz_detail = None
        if last_attempt:
            answer_rows = (
                db.query(models.UserQuizAnswer)
                .filter(models.UserQuizAnswer.user_quiz_attempt_id == last_attempt.id)
                .order_by(models.UserQuizAnswer.id.asc())
                .all()
            )
            answers: list[schemas.AdminQuizAnswerItem] = []
            for a in answer_rows:
                opts = None
                if a.options_snapshot:
                    try:
                        opts = json.loads(a.options_snapshot)
                    except Exception:
                        opts = None
                answers.append(
                    schemas.AdminQuizAnswerItem(
                        question_id=a.question_id,
                        question_text=a.question_text_snapshot,
                        options=opts,
                        selected_answer=a.selected_answer,
                        correct_answer=a.correct_answer,
                        is_correct=bool(a.is_correct),
                    )
                )
            last_quiz_detail = schemas.AdminQuizAttemptDetail(
                attempted_at=_iso(last_attempt.attempted_at),
                score=last_attempt.score,
                total_questions=last_attempt.total_questions,
                passed=bool(last_attempt.passed),
                answers=answers,
            )

        milestones.append(
            schemas.AdminMilestoneProgressItem(
                master_milestone_id=milestone.id,
                milestone_number=milestone.milestone_number,
                title=milestone.title,
                status=progress.status,
                started_at=_iso(progress.started_at),
                completed_at=_iso(progress.completed_at),
                progress_percentage=progress.progress_percentage,
                practice_completed=bool(progress.practice_completed),
                practice_completed_at=_iso(progress.practice_completed_at),
                study_materials_total=study_total,
                study_materials_completed=study_completed,
                last_quiz_score=last_attempt.score if last_attempt else None,
                last_quiz_total=last_attempt.total_questions if last_attempt else None,
                last_quiz_passed=bool(last_attempt.passed) if last_attempt else None,
                last_quiz_at=_iso(last_attempt.attempted_at) if last_attempt else None,
                study_materials_detail=study_detail,
                last_quiz_detail=last_quiz_detail,
            )
        )

    return schemas.AdminUserProgressResponse(
        user_id=user_id,
        user_training_plan_id=user_plan.id,
        training_plan_id=user_plan.training_plan_id,
        plan_title=training_plan.title if training_plan else None,
        plan_description=training_plan.description if training_plan else None,
        current_milestone_number=user_plan.current_milestone_number,
        milestones=milestones,
    )


@router.get("/master-data/roles", response_model=List[schemas.RoleRead])
def admin_list_roles(
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(require_admin),
) -> List[schemas.RoleRead]:
    roles = db.query(models.Role).order_by(models.Role.sort_order.asc(), models.Role.name.asc()).all()
    return [schemas.RoleRead.model_validate(role) for role in roles]


@router.post("/master-data/roles", response_model=schemas.RoleRead, status_code=status.HTTP_201_CREATED)
def admin_create_role(
    payload: schemas.AdminRoleWrite,
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(require_admin),
) -> schemas.RoleRead:
    existing = db.query(models.Role).filter(func.lower(models.Role.name) == payload.name.strip().lower()).first()
    if existing:
        raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail="Role already exists")

    role = models.Role(name=payload.name.strip(), sort_order=payload.sort_order, is_active=payload.is_active)
    db.add(role)
    db.commit()
    db.refresh(role)
    return schemas.RoleRead.model_validate(role)


@router.put("/master-data/roles/{role_id}", response_model=schemas.RoleRead)
def admin_update_role(
    role_id: int,
    payload: schemas.AdminRoleWrite,
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(require_admin),
) -> schemas.RoleRead:
    role = db.query(models.Role).filter(models.Role.id == role_id).first()
    if not role:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Role not found")

    existing = (
        db.query(models.Role)
        .filter(func.lower(models.Role.name) == payload.name.strip().lower())
        .filter(models.Role.id != role_id)
        .first()
    )
    if existing:
        raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail="Role name already exists")

    role.name = payload.name.strip()
    role.sort_order = payload.sort_order
    role.is_active = payload.is_active
    db.commit()
    db.refresh(role)
    return schemas.RoleRead.model_validate(role)


@router.get("/master-data/experience-levels", response_model=List[schemas.ExperienceLevelRead])
def admin_list_experience_levels(
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(require_admin),
) -> List[schemas.ExperienceLevelRead]:
    levels = (
        db.query(models.ExperienceLevel)
        .order_by(models.ExperienceLevel.sort_order.asc(), models.ExperienceLevel.name.asc())
        .all()
    )
    return [schemas.ExperienceLevelRead.model_validate(level) for level in levels]


@router.post("/master-data/experience-levels", response_model=schemas.ExperienceLevelRead, status_code=status.HTTP_201_CREATED)
def admin_create_experience_level(
    payload: schemas.AdminExperienceLevelWrite,
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(require_admin),
) -> schemas.ExperienceLevelRead:
    existing = (
        db.query(models.ExperienceLevel)
        .filter(func.lower(models.ExperienceLevel.name) == payload.name.strip().lower())
        .first()
    )
    if existing:
        raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail="Experience level already exists")

    level = models.ExperienceLevel(
        name=payload.name.strip(),
        sort_order=payload.sort_order,
        is_active=payload.is_active,
    )
    db.add(level)
    db.commit()
    db.refresh(level)
    return schemas.ExperienceLevelRead.model_validate(level)


@router.put("/master-data/experience-levels/{level_id}", response_model=schemas.ExperienceLevelRead)
def admin_update_experience_level(
    level_id: int,
    payload: schemas.AdminExperienceLevelWrite,
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(require_admin),
) -> schemas.ExperienceLevelRead:
    level = db.query(models.ExperienceLevel).filter(models.ExperienceLevel.id == level_id).first()
    if not level:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Experience level not found")

    existing = (
        db.query(models.ExperienceLevel)
        .filter(func.lower(models.ExperienceLevel.name) == payload.name.strip().lower())
        .filter(models.ExperienceLevel.id != level_id)
        .first()
    )
    if existing:
        raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail="Experience level name already exists")

    level.name = payload.name.strip()
    level.sort_order = payload.sort_order
    level.is_active = payload.is_active
    db.commit()
    db.refresh(level)
    return schemas.ExperienceLevelRead.model_validate(level)


@router.delete("/master-data/roles/{role_id}")
def admin_delete_role(
    role_id: int,
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(require_admin),
) -> dict:
    role = db.query(models.Role).filter(models.Role.id == role_id).first()
    if not role:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Role not found")

    in_training = db.query(models.TrainingPlan).filter(models.TrainingPlan.role_id == role_id).count()
    in_onboarding = db.query(models.UserOnboarding).filter(models.UserOnboarding.role_id == role_id).count()
    if in_training > 0 or in_onboarding > 0:
        raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail="Role is in use and cannot be deleted")

    db.delete(role)
    db.commit()
    return {"status": "deleted"}


@router.delete("/master-data/experience-levels/{level_id}")
def admin_delete_experience_level(
    level_id: int,
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(require_admin),
) -> dict:
    level = db.query(models.ExperienceLevel).filter(models.ExperienceLevel.id == level_id).first()
    if not level:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Experience level not found")

    in_training = db.query(models.TrainingPlan).filter(models.TrainingPlan.experience_level_id == level_id).count()
    in_onboarding = db.query(models.UserOnboarding).filter(models.UserOnboarding.experience_level_id == level_id).count()
    if in_training > 0 or in_onboarding > 0:
        raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail="Experience level is in use and cannot be deleted")

    db.delete(level)
    db.commit()
    return {"status": "deleted"}


@router.get("/settings/milestone", response_model=schemas.AdminMilestoneSettingsRead)
def admin_get_milestone_settings(
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(require_admin),
) -> schemas.AdminMilestoneSettingsRead:
    settings = db.query(models.MilestoneSettings).order_by(models.MilestoneSettings.id.asc()).first()
    if settings is None:
        settings = models.MilestoneSettings(quiz_questions_total=40, practice_questions_total=10, is_active=True)
        db.add(settings)
        db.commit()
        db.refresh(settings)

    return schemas.AdminMilestoneSettingsRead(
        id=settings.id,
        quiz_questions_total=settings.quiz_questions_total,
        practice_questions_total=settings.practice_questions_total,
        is_active=bool(settings.is_active),
        created_at=_iso(settings.created_at),
        updated_at=_iso(settings.updated_at),
    )


@router.put("/settings/milestone/{settings_id}", response_model=schemas.AdminMilestoneSettingsRead)
def admin_update_milestone_settings(
    settings_id: int,
    payload: schemas.AdminMilestoneSettingsUpdate,
    db: Session = Depends(get_db),
    admin_user: models.User = Depends(require_admin),
) -> schemas.AdminMilestoneSettingsRead:
    settings = db.query(models.MilestoneSettings).filter(models.MilestoneSettings.id == settings_id).first()
    if settings is None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Settings not found")

    if payload.quiz_questions_total is not None:
        settings.quiz_questions_total = payload.quiz_questions_total
    if payload.practice_questions_total is not None:
        settings.practice_questions_total = payload.practice_questions_total
    if payload.is_active is not None:
        settings.is_active = payload.is_active

    db.commit()
    db.refresh(settings)
    return schemas.AdminMilestoneSettingsRead(
        id=settings.id,
        quiz_questions_total=settings.quiz_questions_total,
        practice_questions_total=settings.practice_questions_total,
        is_active=bool(settings.is_active),
        created_at=_iso(settings.created_at),
        updated_at=_iso(settings.updated_at),
    )
