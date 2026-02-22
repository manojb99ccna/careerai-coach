from typing import Generator, List, Optional

from fastapi import Depends, FastAPI, HTTPException, status
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session

from . import auth, face_utils, models, schemas
from .database import Base, SessionLocal, engine


Base.metadata.create_all(bind=engine)


def get_db() -> Generator[Session, None, None]:
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


app = FastAPI(title="CareerAI Coach Backend")


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


@app.get("/meta/roles", response_model=List[schemas.RoleRead])
def list_roles(db: Session = Depends(get_db)) -> List[schemas.RoleRead]:
    roles = (
        db.query(models.Role)
        .filter(models.Role.is_active.is_(True))
        .order_by(models.Role.name.asc())
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

    token = auth.create_access_token({"sub": str(best_user.id)})
    return schemas.FaceLoginResponse(status="login_success", token=token, user=schemas.UserRead.model_validate(best_user))


@app.post("/auth/face/register", response_model=schemas.RegisterResponse, status_code=status.HTTP_201_CREATED)
def face_register(payload: schemas.RegisterRequest, db: Session = Depends(get_db)) -> schemas.RegisterResponse:
    existing = db.query(models.User).filter(models.User.email == payload.email).first()
    if existing is not None:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="User with this email already exists")

    serialized_encoding = face_utils.serialize_encoding(payload.encoding)

    user = models.User(
        name=payload.name,
        email=payload.email,
        phone=payload.phone,
        face_encoding=serialized_encoding,
    )
    db.add(user)
    db.commit()
    db.refresh(user)

    token = auth.create_access_token({"sub": str(user.id)})
    return schemas.RegisterResponse(token=token, user=schemas.UserRead.model_validate(user))
