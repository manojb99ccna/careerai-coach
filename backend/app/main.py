from typing import Generator, List, Optional

import base64
import json
from pathlib import Path
from uuid import uuid4
from urllib import error as urllib_error
from urllib import request as urllib_request

from fastapi import Depends, FastAPI, File, Header, HTTPException, UploadFile, status
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import FileResponse
from fastapi.staticfiles import StaticFiles
from jose import JWTError, jwt
from sqlalchemy.orm import Session

from . import auth, face_utils, models, schemas
from .database import Base, SessionLocal, engine


Base.metadata.create_all(bind=engine)


BASE_DIR = Path(__file__).resolve().parent.parent
MEDIA_ROOT = BASE_DIR / "media"
PROFILE_DIR = MEDIA_ROOT / "profile"
RESUME_DIR = MEDIA_ROOT / "resume"
PROFILE_DIR.mkdir(parents=True, exist_ok=True)
RESUME_DIR.mkdir(parents=True, exist_ok=True)


OLLAMA_BASE_URL = "http://localhost:11434"


def _save_profile_image_bytes(data: bytes, suggested_ext: str = "jpg") -> str:
    ext = suggested_ext or "jpg"
    filename = f"profile_{uuid4().hex}.{ext}"
    file_path = PROFILE_DIR / filename
    with open(file_path, "wb") as f:
        f.write(data)
    return filename


def _save_resume_file_bytes(data: bytes, suggested_ext: str = "pdf") -> str:
    ext = suggested_ext or "pdf"
    filename = f"resume_{uuid4().hex}.{ext}"
    file_path = RESUME_DIR / filename
    with open(file_path, "wb") as f:
        f.write(data)
    return filename


def save_profile_image_from_data_url(data_url: str) -> Optional[str]:
    if not data_url:
        return None

    header, _, data = data_url.partition(",")
    if not data:
        data = header

    try:
        binary = base64.b64decode(data)
    except Exception:
        return None

    ext = "jpg"
    if "png" in header:
        ext = "png"
    elif "jpeg" in header:
        ext = "jpg"

    return _save_profile_image_bytes(binary, ext)


def get_db() -> Generator[Session, None, None]:
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


def get_current_user_id(authorization: str = Header(..., alias="Authorization")) -> int:
    if not authorization:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Not authenticated")

    scheme, _, token = authorization.partition(" ")
    if scheme.lower() != "bearer" or not token:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid authorization header")

    try:
        payload = jwt.decode(token, auth.JWT_SECRET_KEY, algorithms=[auth.JWT_ALGORITHM])
    except JWTError:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid token")

    sub = payload.get("sub")
    if sub is None:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid token payload")

    try:
        return int(sub)
    except ValueError:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid user id in token")


app = FastAPI(title="CareerAI Coach Backend")


app.mount("/media", StaticFiles(directory=str(MEDIA_ROOT)), name="media")


origins = [
    "http://localhost:5173",
    "http://127.0.0.1:5173",
    "http://localhost:3000",
    "http://127.0.0.1:3000",
]


app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


FACE_MATCH_THRESHOLD = 0.6


@app.get("/health")
def health_check() -> dict:
    return {"status": "ok"}


def _call_ollama_for_training_plan(role_name: str, experience_level_name: str, skills: Optional[str]) -> dict:
    skills_text = skills or ""
    prompt = (
        "You are an expert AI career coach creating a structured training plan.\n"
        "Use the user's target role, experience level, and skills to tailor the plan.\n\n"
        f"Target role: {role_name}\n"
        f"Experience level: {experience_level_name}\n"
        f"Current skills: {skills_text}\n\n"
        "Strict rules for the JSON you must output:\n"
        "- Generate EXACTLY 6 to 8 milestones (no more, no less).\n"
        "- The first milestone must focus on foundations / absolute basics.\n"
        "- The last milestone must focus on production, deployment, portfolio, and real-world projects.\n"
        "- Each milestone MUST have these fields:\n"
        "  - title: short, professional (3–6 words).\n"
        "  - description: 1–2 sentences explaining career importance.\n"
        "  - estimated_days: integer between 5 and 21.\n"
        "  - study_materials: an array with EXACTLY 5 to 10 items.\n"
        "    Each study material item must have:\n"
        "      - title: short descriptive text.\n"
        "      - type: one of markdown, text, link, video_embed, pdf.\n"
        "      - content: short text, URL, or embed code/description.\n"
        "  - practice_guidelines: 2–4 sentences describing how to practice.\n"
        "  - quiz_questions: EXACTLY 60 questions.\n"
        "    Difficulty distribution per milestone:\n"
        "      - 20 with difficulty \"easy\".\n"
        "      - 25 with difficulty \"medium\".\n"
        "      - 15 with difficulty \"hard\".\n"
        "    Each quiz question must have:\n"
        "      - text: the question text.\n"
        "      - options: array of four options formatted as\n"
        "        [\"A. ...\", \"B. ...\", \"C. ...\", \"D. ...\"].\n"
        "      - correct: one of \"A\", \"B\", \"C\", or \"D\".\n"
        "      - explanation: 2–4 sentences explaining the answer.\n"
        "      - difficulty: \"easy\", \"medium\", or \"hard\".\n\n"
        "Output ONLY valid JSON with this exact structure:\n"
        "{\n"
        '  \"milestones\": [\n'
        "    {\n"
        '      \"title\": \"...\",\n'
        '      \"description\": \"...\",\n'
        '      \"estimated_days\": 10,\n'
        '      \"study_materials\": [\n'
        "        {\n"
        '          \"title\": \"...\",\n'
        '          \"type\": \"markdown\",\n'
        '          \"content\": \"...\"\n'
        "        }\n"
        "      ],\n"
        '      \"practice_guidelines\": \"...\",\n'
        '      \"quiz_questions\": [\n'
        "        {\n"
        '          \"text\": \"...\",\n'
        '          \"options\": [\"A. ...\", \"B. ...\", \"C. ...\", \"D. ...\"],\n'
        '          \"correct\": \"A\",\n'
        '          \"explanation\": \"...\",\n'
        '          \"difficulty\": \"easy\"\n'
        "        }\n"
        "      ]\n"
        "    }\n"
        "  ]\n"
        "}\n"
        "Do NOT include any markdown formatting or code blocks. Output ONLY the raw JSON string.\n"
        "IMPORTANT: The array 'milestones' must contain AT LEAST 6 items and AT MOST 8 items."
    )

    payload = {"model": "llama3", "prompt": prompt, "stream": False, "format": "json"}
    data = json.dumps(payload).encode("utf-8")
    request_obj = urllib_request.Request(
        f"{OLLAMA_BASE_URL}/api/generate",
        data=data,
        headers={"Content-Type": "application/json"},
        method="POST",
    )
    try:
        with urllib_request.urlopen(request_obj, timeout=600) as response:
            body = response.read().decode("utf-8")
    except urllib_error.URLError:
        raise HTTPException(
            status_code=status.HTTP_502_BAD_GATEWAY,
            detail="AI generation service is not available. Make sure Ollama is running on localhost:11434.",
        )

    try:
        raw = json.loads(body)
    except json.JSONDecodeError:
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail="Invalid response from AI service")

    text = raw.get("response") or raw.get("text") or ""
    if not text:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail="Empty response from AI service"
        )

    start_index = text.find("{")
    end_index = text.rfind("}")
    if start_index != -1 and end_index != -1:
        text = text[start_index : end_index + 1]

    try:
        return json.loads(text)
    except json.JSONDecodeError:
        print(f"Failed to parse JSON. Raw text: {text[:500]}...")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="AI did not return valid JSON for training plan",
        )


def _generate_filler_question(milestone_title: str, difficulty: str, index: int) -> dict:
    label = difficulty.capitalize()
    text = f"{label} practice question {index} for {milestone_title}"
    options = [
        "A. Concept is correct",
        "B. Concept is partially correct",
        "C. Concept is incorrect",
        "D. It depends on context",
    ]
    explanation = (
        f"This is a synthetic {difficulty} question to reinforce {milestone_title}. "
        "Option A reflects the correct core idea."
    )
    return {
        "text": text,
        "options": options,
        "correct": "A",
        "explanation": explanation,
        "difficulty": difficulty,
    }


def _generate_filler_study_material(milestone_title: str, index: int) -> dict:
    return {
        "title": f"Recommended Reading {index} for {milestone_title}",
        "type": "text",
        "content": f"Please research core concepts of {milestone_title} to build a strong foundation. Focus on official documentation and community best practices.",
    }


def _validate_training_plan_payload(data: dict) -> List[dict]:
    milestones = data.get("milestones")
    if not isinstance(milestones, list):
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail="AI plan missing milestones list")

    count = len(milestones)
    if count < 6 or count > 8:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="AI plan must contain between 6 and 8 milestones",
        )

    validated: List[dict] = []

    for index, milestone in enumerate(milestones, start=1):
        if not isinstance(milestone, dict):
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail="Milestone entry is not an object"
            )

        title = str(milestone.get("title") or "").strip()
        description = str(milestone.get("description") or "").strip()
        estimated_days_raw = milestone.get("estimated_days")

        if not title:
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail="Milestone title is required"
            )

        try:
            estimated_days = int(estimated_days_raw)
        except (TypeError, ValueError):
            estimated_days = 7

        if estimated_days < 5:
            estimated_days = 5
        if estimated_days > 21:
            estimated_days = 21

        study_materials = milestone.get("study_materials") or []
        if not isinstance(study_materials, list):
            study_materials = []
        
        # Ensure at most 10 items
        if len(study_materials) > 10:
            study_materials = study_materials[:10]
            
        # Ensure at least 5 items
        while len(study_materials) < 5:
            index = len(study_materials) + 1
            study_materials.append(_generate_filler_study_material(title, index))

        normalized_materials = []
        for idx, item in enumerate(study_materials, start=1):
            if not isinstance(item, dict):
                raise HTTPException(
                    status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                    detail="Study material entry is not an object",
                )
            material_title = str(item.get("title") or "").strip()
            material_type = str(item.get("type") or "markdown").strip()
            material_content = str(item.get("content") or "").strip()
            
            # If content is empty for non-markdown types, provide a default
            if not material_content:
                material_content = f"Review official documentation for {material_title}"

            if material_type not in {"markdown", "text", "link", "video_embed", "pdf"}:
                material_type = "markdown"

            normalized_materials.append(
                {
                    "title": material_title,
                    "type": material_type,
                    "content": material_content,
                    "sort_order": idx,
                }
            )

        practice_guidelines = str(milestone.get("practice_guidelines") or "").strip()

        quiz_questions_raw = milestone.get("quiz_questions") or []
        if not isinstance(quiz_questions_raw, list):
            quiz_questions_raw = []

        base_questions = []
        for question in quiz_questions_raw:
            if not isinstance(question, dict):
                continue

            text = str(question.get("text") or "").strip()
            options = question.get("options") or []
            if not isinstance(options, list):
                options = []
            normalized_options = [str(opt) for opt in options]
            while len(normalized_options) < 4:
                normalized_options.append(f"Option {len(normalized_options) + 1}")
            if len(normalized_options) > 4:
                normalized_options = normalized_options[:4]

            correct = str(question.get("correct") or "").strip().upper()
            if correct not in {"A", "B", "C", "D"}:
                correct = "A"
            explanation = str(question.get("explanation") or "").strip()
            difficulty = str(question.get("difficulty") or "").strip().lower()
            if difficulty not in {"easy", "medium", "hard"}:
                difficulty = "medium"

            base_questions.append(
                {
                    "text": text,
                    "options": normalized_options,
                    "correct": correct,
                    "explanation": explanation,
                    "difficulty": difficulty,
                }
            )

        easy_questions = []
        medium_questions = []
        hard_questions = []
        for q in base_questions:
            if q["difficulty"] == "easy":
                easy_questions.append(q)
            elif q["difficulty"] == "hard":
                hard_questions.append(q)
            else:
                medium_questions.append(q)

        final_questions: List[dict] = []

        def take_questions(source_lists, remaining: int, target_difficulty: str) -> int:
            while remaining > 0:
                non_empty = [(name, lst) for name, lst in source_lists if lst]
                if not non_empty:
                    break
                non_empty.sort(key=lambda item: len(item[1]), reverse=True)
                name, lst = non_empty[0]
                q = lst.pop(0)
                q["difficulty"] = target_difficulty
                final_questions.append(q)
                remaining -= 1
            return remaining

        sources = [("easy", easy_questions), ("medium", medium_questions), ("hard", hard_questions)]

        remaining_easy = 20
        remaining_medium = 25
        remaining_hard = 15

        remaining_easy = take_questions(sources, remaining_easy, "easy")
        remaining_medium = take_questions(sources, remaining_medium, "medium")
        remaining_hard = take_questions(sources, remaining_hard, "hard")

        for _ in range(remaining_easy):
            index = len(final_questions) + 1
            final_questions.append(_generate_filler_question(title, "easy", index))
        for _ in range(remaining_medium):
            index = len(final_questions) + 1
            final_questions.append(_generate_filler_question(title, "medium", index))
        for _ in range(remaining_hard):
            index = len(final_questions) + 1
            final_questions.append(_generate_filler_question(title, "hard", index))

        if len(final_questions) > 60:
            final_questions = final_questions[:60]

        validated.append(
            {
                "title": title,
                "description": description,
                "estimated_days": estimated_days,
                "study_materials": normalized_materials,
                "practice_guidelines": practice_guidelines,
                "quiz_questions": final_questions,
            }
        )

    return validated


@app.get("/meta/roles", response_model=List[schemas.RoleRead])
def list_roles(db: Session = Depends(get_db)) -> List[schemas.RoleRead]:
    roles = (
        db.query(models.Role)
        .filter(models.Role.is_active.is_(True))
        .order_by(models.Role.sort_order.asc(), models.Role.name.asc())
        .all()
    )
    return roles


@app.get("/meta/experience-levels", response_model=List[schemas.ExperienceLevelRead])
def list_experience_levels(db: Session = Depends(get_db)) -> List[schemas.ExperienceLevelRead]:
    levels = (
        db.query(models.ExperienceLevel)
        .filter(models.ExperienceLevel.is_active.is_(True))
        .order_by(models.ExperienceLevel.sort_order.asc(), models.ExperienceLevel.name.asc())
        .all()
    )
    return levels


@app.get("/users/{user_id}/onboarding", response_model=schemas.OnboardingRead)
def get_user_onboarding(user_id: int, db: Session = Depends(get_db)) -> schemas.OnboardingRead:
    record = db.query(models.UserOnboarding).filter(models.UserOnboarding.user_id == user_id).first()
    if record is None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Onboarding not found")
    return record


@app.post("/users/{user_id}/onboarding", response_model=schemas.OnboardingRead, status_code=status.HTTP_201_CREATED)
def upsert_user_onboarding(
    user_id: int,
    payload: schemas.OnboardingCreate,
    db: Session = Depends(get_db),
) -> schemas.OnboardingRead:
    if payload.user_id != user_id:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="User id mismatch")

    existing = db.query(models.UserOnboarding).filter(models.UserOnboarding.user_id == user_id).first()
    if existing is None:
        record = models.UserOnboarding(
            user_id=user_id,
            role_id=payload.role_id,
            experience_level_id=payload.experience_level_id,
            skills=payload.skills,
            resume_file_name=payload.resume_file_name,
        )
        db.add(record)
        db.commit()
        db.refresh(record)
        return record

    existing.role_id = payload.role_id
    existing.experience_level_id = payload.experience_level_id
    existing.skills = payload.skills
    existing.resume_file_name = payload.resume_file_name
    db.commit()
    db.refresh(existing)
    return existing


@app.put("/users/{user_id}/profile-image", response_model=schemas.UserRead)
async def update_profile_image(
    user_id: int,
    file: UploadFile = File(...),
    db: Session = Depends(get_db),
) -> schemas.UserRead:
    user = db.query(models.User).filter(models.User.id == user_id).first()
    if user is None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="User not found")

    contents = await file.read()
    ext = Path(file.filename).suffix.lstrip(".") or "jpg"
    filename = _save_profile_image_bytes(contents, ext)

    user.profile_image = filename
    db.commit()
    db.refresh(user)
    return schemas.UserRead.model_validate(user)


@app.put("/users/{user_id}/resume", response_model=schemas.OnboardingRead)
async def upload_resume(
    user_id: int,
    file: UploadFile = File(...),
    db: Session = Depends(get_db),
) -> schemas.OnboardingRead:
    user = db.query(models.User).filter(models.User.id == user_id).first()
    if user is None:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="User not found")

    contents = await file.read()
    ext = Path(file.filename).suffix.lstrip(".") or "pdf"
    filename = _save_resume_file_bytes(contents, ext)

    record = db.query(models.UserOnboarding).filter(models.UserOnboarding.user_id == user_id).first()
    if record is None:
        record = models.UserOnboarding(
            user_id=user_id,
            resume_file_name=filename,
        )
        db.add(record)
        db.commit()
        db.refresh(record)
        return record

    record.resume_file_name = filename
    db.commit()
    db.refresh(record)
    return record


@app.get("/users/{user_id}/resume/download")
def download_resume(
    user_id: int,
    db: Session = Depends(get_db),
) -> FileResponse:
    record = db.query(models.UserOnboarding).filter(models.UserOnboarding.user_id == user_id).first()
    if record is None or not record.resume_file_name:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Resume not found")

    file_path = RESUME_DIR / record.resume_file_name
    if not file_path.exists():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Resume not found")

    return FileResponse(
        path=str(file_path),
        media_type="application/octet-stream",
        filename=record.resume_file_name,
    )


def _build_training_plan_response(
    user_plan: models.UserTrainingPlan,
    db: Session,
) -> schemas.TrainingPlanResponse:
    training_plan = (
        db.query(models.TrainingPlan)
        .filter(models.TrainingPlan.id == user_plan.training_plan_id)
        .first()
    )
    if training_plan is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Training plan not found",
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

    milestones: List[schemas.MilestoneStatusRead] = []
    for progress, milestone in rows:
        milestones.append(
            schemas.MilestoneStatusRead(
                id=milestone.id,
                milestone_number=milestone.milestone_number,
                title=milestone.title,
                description=milestone.description,
                estimated_days=milestone.estimated_days or 7,
                status=progress.status,
            )
        )

    plan_data = schemas.TrainingPlanRead(
        id=training_plan.id,
        title=training_plan.title,
        description=training_plan.description,
        current_milestone_number=user_plan.current_milestone_number,
        milestones=milestones,
    )
    return schemas.TrainingPlanResponse(has_plan=True, plan=plan_data)


@app.get("/training/plan", response_model=schemas.TrainingPlanResponse)
def get_training_plan(
    current_user_id: int = Depends(get_current_user_id),
    db: Session = Depends(get_db),
) -> schemas.TrainingPlanResponse:
    user_plan = (
        db.query(models.UserTrainingPlan)
        .filter(models.UserTrainingPlan.user_id == current_user_id)
        .first()
    )
    if user_plan is None:
        return schemas.TrainingPlanResponse(has_plan=False, plan=None)

    return _build_training_plan_response(user_plan, db)


@app.post(
    "/training/plan/generate",
    response_model=schemas.TrainingPlanResponse,
    status_code=status.HTTP_201_CREATED,
)
def generate_training_plan(
    payload: schemas.TrainingPlanGenerateRequest,
    current_user_id: int = Depends(get_current_user_id),
    db: Session = Depends(get_db),
) -> schemas.TrainingPlanResponse:
    existing_user_plan = (
        db.query(models.UserTrainingPlan)
        .filter(models.UserTrainingPlan.user_id == current_user_id)
        .first()
    )
    if existing_user_plan is not None:
        return _build_training_plan_response(existing_user_plan, db)

    role = db.query(models.Role).filter(models.Role.id == payload.role_id).first()
    if role is None:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Invalid role_id")

    experience_level = (
        db.query(models.ExperienceLevel)
        .filter(models.ExperienceLevel.id == payload.experience_level_id)
        .first()
    )
    if experience_level is None:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Invalid experience_level_id")

    training_plan = (
        db.query(models.TrainingPlan)
        .filter(
            models.TrainingPlan.role_id == payload.role_id,
            models.TrainingPlan.experience_level_id == payload.experience_level_id,
        )
        .first()
    )

    if training_plan is None:
        raw_plan = _call_ollama_for_training_plan(role.name, experience_level.name, payload.skills)
        milestones = _validate_training_plan_payload(raw_plan)

        training_plan = models.TrainingPlan(
            role_id=role.id,
            experience_level_id=experience_level.id,
            title=f"{role.name} - {experience_level.name} Training Plan",
            description="AI-generated training plan based on your role, experience level, and skills.",
            is_generated=True,
        )
        db.add(training_plan)
        db.commit()
        db.refresh(training_plan)

        for index, milestone in enumerate(milestones, start=1):
            master_milestone = models.MasterMilestone(
                training_plan_id=training_plan.id,
                milestone_number=index,
                title=milestone["title"],
                description=milestone["description"],
                estimated_days=milestone["estimated_days"],
                sort_order=index,
            )
            db.add(master_milestone)
            db.flush()

            for material in milestone["study_materials"]:
                db.add(
                    models.MasterStudyMaterial(
                        master_milestone_id=master_milestone.id,
                        content_type=material["type"],
                        title=material["title"],
                        content=material["content"],
                        sort_order=material["sort_order"],
                    )
                )

            for question in milestone["quiz_questions"]:
                db.add(
                    models.MasterQuizQuestion(
                        master_milestone_id=master_milestone.id,
                        question_text=question["text"],
                        question_type="multiple_choice",
                        difficulty=question["difficulty"],
                        options=json.dumps(question["options"]),
                        correct_answer=question["correct"],
                        explanation=question["explanation"],
                    )
                )

        db.commit()

    user_plan = models.UserTrainingPlan(
        user_id=current_user_id,
        training_plan_id=training_plan.id,
        status="active",
        current_milestone_number=1,
    )
    db.add(user_plan)
    db.flush()

    milestones_rows = (
        db.query(models.MasterMilestone)
        .filter(models.MasterMilestone.training_plan_id == training_plan.id)
        .order_by(models.MasterMilestone.milestone_number.asc())
        .all()
    )

    for milestone in milestones_rows:
        status_value = "in_progress" if milestone.milestone_number == 1 else "locked"
        db.add(
            models.UserMilestoneProgress(
                user_training_plan_id=user_plan.id,
                master_milestone_id=milestone.id,
                status=status_value,
                progress_percentage=0,
            )
        )

    db.commit()
    db.refresh(user_plan)

    return _build_training_plan_response(user_plan, db)


@app.post("/auth/face/login", response_model=schemas.FaceLoginResponse)
def face_login(payload: schemas.FaceScanRequest, db: Session = Depends(get_db)) -> schemas.FaceLoginResponse:
    users: List[models.User] = db.query(models.User).all()
    best_user: Optional[models.User] = None
    best_distance: Optional[float] = None

    for user in users:
        distance = face_utils.calculate_distance(payload.encoding, user.face_encoding)
        if best_distance is None or distance < best_distance:
            best_distance = distance
            best_user = user

    if best_user is None or best_distance is None or best_distance > FACE_MATCH_THRESHOLD:
        return schemas.FaceLoginResponse(status="register_required")

    from json import dumps as json_dumps

    login_detail = models.UserLoginDetail(
        user_id=best_user.id,
        login_method="face",
        face_encoding=json_dumps(payload.encoding),
        confidence_score=float(best_distance),
        login_status="success",
    )
    db.add(login_detail)
    db.commit()

    token = auth.create_access_token({"sub": str(best_user.id)})
    return schemas.FaceLoginResponse(status="login_success", token=token, user=schemas.UserRead.model_validate(best_user))


@app.post("/auth/face/register", response_model=schemas.RegisterResponse, status_code=status.HTTP_201_CREATED)
def face_register(payload: schemas.RegisterRequest, db: Session = Depends(get_db)) -> schemas.RegisterResponse:
    existing = db.query(models.User).filter(models.User.email == payload.email).first()
    if existing is not None:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="User with this email already exists")

    serialized_encoding = face_utils.serialize_encoding(payload.encoding)

    profile_filename: Optional[str] = None
    if payload.profile_image:
        profile_filename = save_profile_image_from_data_url(payload.profile_image)

    user = models.User(
        name=payload.name,
        email=payload.email,
        phone=payload.phone,
        face_encoding=serialized_encoding,
        profile_image=profile_filename,
    )
    db.add(user)
    db.commit()
    db.refresh(user)

    token = auth.create_access_token({"sub": str(user.id)})
    return schemas.RegisterResponse(token=token, user=schemas.UserRead.model_validate(user))
