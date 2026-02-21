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

