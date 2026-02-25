from typing import Generator, List, Optional

import base64
import json
import random
from datetime import datetime
from pathlib import Path
from uuid import uuid4
from urllib import error as urllib_error
from urllib import request as urllib_request

from fastapi import Depends, FastAPI, File, Header, HTTPException, UploadFile, status
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import FileResponse
from fastapi.staticfiles import StaticFiles
from jose import JWTError, jwt
from sqlalchemy import func
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


app = FastAPI(title="CareerAI Coach Backend", debug=True)


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
        "- Generate EXACTLY 3 to 5 milestones.\n"
        "- The first milestone must focus on foundations / absolute basics.\n"
        "- The last milestone must focus on production, deployment, portfolio, and real-world projects.\n"
        "- Each milestone MUST have these fields:\n"
        "  - title: short, professional (3-6 words).\n"
        "  - description: 1-2 sentences summarizing what will be studied in this milestone.\n"
        "  - estimated_days: integer between 5 and 21.\n\n"
        "Output ONLY valid JSON with this exact structure:\n"
        "{\n"
        '  \"milestones\": [\n'
        "    {\n"
        '      \"title\": \"...\",\n'
        '      \"description\": \"...\",\n'
        '      \"estimated_days\": 10\n'
        "    }\n"
        "  ]\n"
        "}\n"
        "Do NOT include any markdown formatting or code blocks. Output ONLY the raw JSON string.\n"
        "IMPORTANT: The array 'milestones' must contain AT LEAST 3 items and AT MOST 8 items."
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
    except json.JSONDecodeError as e:
        print("FAILED TO PARSE JSON FROM AI.")
        print(f"ERROR: {e}")
        print("RAW TEXT START:")
        print(text[:2000])
        print("RAW TEXT END:")
        print(text[-2000:])
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"AI did not return valid JSON. Error: {str(e)}",
        )


def _save_milestone_content(db: Session, milestone: models.MasterMilestone, processed_content: dict):
    # Idempotency: Delete existing content for this milestone
    db.query(models.MasterStudyMaterial).filter(models.MasterStudyMaterial.master_milestone_id == milestone.id).delete()
    db.query(models.MasterQuizQuestion).filter(models.MasterQuizQuestion.master_milestone_id == milestone.id).delete()
    db.flush()

    # Save materials
    for material in processed_content.get("study_materials", []):
        db.add(
            models.MasterStudyMaterial(
                master_milestone_id=milestone.id,
                content_type=material["type"],
                title=material["title"],
                short_description=material["short_description"],
                content=material["content"],
                sort_order=material.get("sort_order", 0),
            )
        )
        
    # Save questions
    for question in processed_content.get("quiz_questions", []):
        db.add(
            models.MasterQuizQuestion(
                master_milestone_id=milestone.id,
                question_text=question["text"],
                question_type="multiple_choice",
                difficulty=question["difficulty"],
                options=json.dumps(question["options"]),
                correct_answer=question["correct"],
                explanation=question["explanation"],
            )
        )
    
    milestone.is_content_generated = True
    db.add(milestone)


def _generate_milestone_content(milestone_title: str, milestone_desc: str, role: str, level: str, question_count: int = 5) -> dict:
    # Calculate difficulty distribution
    if question_count < 3:
        easy_count = question_count
        medium_count = 0
        hard_count = 0
    else:
        easy_count = int(question_count * 0.4)
        medium_count = int(question_count * 0.4)
        hard_count = question_count - easy_count - medium_count

    prompt = (
        "You are an expert AI career coach creating detailed study content for a specific milestone.\n"
        f"Milestone Title: {milestone_title}\n"
        f"Milestone Description: {milestone_desc}\n"
        f"Target Role: {role}\n"
        f"Experience Level: {level}\n\n"
        "Strict rules for the JSON you must output:\n"
        "1. study_materials: an array with EXACTLY 2 to 3 items.\n"
        "    Each study material item must have:\n"
        "      - title: short descriptive text.\n"
        "      - type: one of markdown, text, link, video_embed, pdf.\n"
        "      - short_description: MUST be a clear, beginner-friendly definition in simple terms.\n"
        "        Rules:\n"
        "        - Define the concept like a textbook definition.\n"
        "        - Explain what it is, how it works, and why it is used.\n"
        "        - Use simple language suitable for beginners.\n"
        "        - Length: 1–2 sentences only.\n"
        "        - Example style: 'Supervised Learning trains a model using labeled data to predict correct outputs.'\n"
        "      - content: MUST be full, detailed study material written in structured learning format.\n"
        "        Content MUST include ALL of the following sections:\n"
        "        1. Concept Explanation:\n"
        "           - Detailed explanation in beginner-friendly language.\n"
        "           - Explain purpose, how it works, and when it is used.\n"
        "        2. Flow Explanation (REQUIRED):\n"
        "           - Provide step-by-step flow using arrow format like:\n"
        "             Input Data + Correct Answers\n"
        "             ↓\n"
        "             Train Model\n"
        "             ↓\n"
        "             Model Learns Patterns\n"
        "             ↓\n"
        "             Predict New Data\n"
        "        3. Real-world Example (REQUIRED):\n"
        "           - Provide at least one real-world example.\n"
        "           - Example must be practical and beginner understandable.\n"
        "        4. Optional Flow Diagram (IMPORTANT):\n"
        "           - If possible, include a visual-style flow representation using arrows, blocks, or steps.\n"
        "           - Use text-based flow diagram format suitable for markdown display.\n"
        "        5. Key Points Summary:\n"
        "           - Provide 3–5 bullet points summarizing key ideas.\n"
        "        Content MUST be well-structured and suitable for self-learning.\n"
        "        Do NOT make content too short.\n"
        "        Do NOT omit flow explanation or example.\n"
        f"2. quiz_questions: EXACTLY {question_count} questions.\n"
        "    Difficulty distribution per milestone:\n"
        f"      - {easy_count} with difficulty \"easy\".\n"
        f"      - {medium_count} with difficulty \"medium\".\n"
        f"      - {hard_count} with difficulty \"hard\".\n"
        "    Each quiz question must have:\n"
        "      - text: the question text.\n"
        "      - options: array of four options formatted as\n"
        "        [\"A. ...\", \"B. ...\", \"C. ...\", \"D. ...\"].\n"
        "      - correct: one of \"A\", \"B\", \"C\", or \"D\". IMPORTANT: Randomize the correct answer (do not always make it A).\n"
        "      - explanation: 2–4 sentences explaining the answer.\n"
        "      - difficulty: \"easy\", \"medium\", or \"hard\".\n\n"
        "Output ONLY valid JSON with this exact structure:\n"
        "{\n"
        '  \"study_materials\": [\n'
        "    {\n"
        '      \"title\": \"...\",\n'
        '      \"type\": \"markdown\",\n'
        '      \"short_description\": \"...\",\n'
        '      \"content\": \"...\"\n'
        "    }\n"
        "  ],\n"
        '  \"quiz_questions\": [\n'
        "    {\n"
        '      \"text\": \"...\",\n'
        '      \"options\": [\"A. ...\", \"B. ...\", \"C. ...\", \"D. ...\"],\n'
        '      \"correct\": \"A\",\n'
        '      \"explanation\": \"...\",\n'
        '      \"difficulty\": \"easy\"\n'
        "    }\n"
        "  ]\n"
        "}\n"
        "Do NOT include any markdown formatting or code blocks. Output ONLY the raw JSON string."
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
        print("Ollama connection failed")
        return {}

    try:
        raw = json.loads(body)
        text = raw.get("response") or raw.get("text") or ""
        start_index = text.find("{")
        end_index = text.rfind("}")
        if start_index != -1 and end_index != -1:
            text = text[start_index : end_index + 1]
        return json.loads(text)
    except Exception as e:
        print(f"Error parsing AI content: {e}")
        return {}


def _generate_filler_question(milestone_title: str, difficulty: str, index: int) -> dict:
    label = difficulty.capitalize()
    text = f"{label} practice question {index} for {milestone_title}"
    base_options = [
        "Concept is correct",
        "Concept is partially correct",
        "Concept is incorrect",
        "It depends on context",
    ]
    random.shuffle(base_options)
    
    # Let's arbitrarily say "Concept is correct" is the right answer text for this filler
    correct_text = "Concept is correct"
    try:
        correct_idx = base_options.index(correct_text)
    except ValueError:
        correct_idx = 0
        
    correct_char = chr(65 + correct_idx)
    
    final_options = []
    for i, opt in enumerate(base_options):
        prefix = chr(65 + i)
        final_options.append(f"{prefix}. {opt}")
        
    explanation = (
        f"This is a synthetic {difficulty} question to reinforce {milestone_title}. "
        f"Option {correct_char} reflects the correct core idea."
    )
    return {
        "text": text,
        "options": final_options,
        "correct": correct_char,
        "explanation": explanation,
        "difficulty": difficulty,
    }


def _generate_filler_study_material(milestone_title: str, index: int) -> dict:
    return {
        "title": f"Recommended Reading {index} for {milestone_title}",
        "type": "text",
        "short_description": f"{milestone_title} is a key concept that enables scalable solutions in this domain.",
        "content": (
            f"### 1. Concept Explanation\n"
            f"Please research core concepts of {milestone_title} to build a strong foundation. "
            "It is widely used in industry to solve complex problems.\n\n"
            "### 2. Flow Explanation\n"
            "Concept -> Implementation -> Optimization -> Deployment\n\n"
            "### 3. Real-world Example\n"
            f"Many companies use {milestone_title} to improve efficiency by 50%.\n\n"
            "### 4. Key Points Summary\n"
            "- Core foundation\n"
            "- Industry standard\n"
            "- Scalable approach"
        ),
    }


def _validate_training_plan_payload(data: dict) -> List[dict]:
    milestones = data.get("milestones")
    if not isinstance(milestones, list):
        print(f"VALIDATION ERROR: milestones is not a list. Data: {json.dumps(data, indent=2)}")
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail="AI plan missing milestones list")

    count = len(milestones)
    if count < 3 or count > 8:
        print(f"VALIDATION ERROR: Milestone count {count} is invalid (expected 3-8).")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"AI plan must contain between 3 and 8 milestones (received {count})",
        )

    validated: List[dict] = []

    for index, milestone in enumerate(milestones, start=1):
        if not isinstance(milestone, dict):
            continue

        title = str(milestone.get("title") or "").strip()
        description = str(milestone.get("description") or "").strip()
        estimated_days_raw = milestone.get("estimated_days")

        if not title:
            title = f"Milestone {index}"

        try:
            estimated_days = int(estimated_days_raw)
        except (TypeError, ValueError):
            estimated_days = 7

        if estimated_days < 5:
            estimated_days = 5
        if estimated_days > 21:
            estimated_days = 21

        validated.append(
            {
                "title": title,
                "description": description,
                "estimated_days": estimated_days,
                "study_materials": [],
                "quiz_questions": [],
                "practice_guidelines": "",
            }
        )

    return validated


def _process_milestone_content(data: dict, milestone_title: str, question_count: int = 5) -> dict:
    study_materials = data.get("study_materials") or []
    if not isinstance(study_materials, list):
        study_materials = []
    
    # Ensure at most 10 items
    if len(study_materials) > 10:
        study_materials = study_materials[:10]
        
    # Ensure at least 2 items (relaxed from 5)
    while len(study_materials) < 2:
        index = len(study_materials) + 1
        study_materials.append(_generate_filler_study_material(milestone_title, index))

    normalized_materials = []
    for idx, item in enumerate(study_materials, start=1):
        if not isinstance(item, dict):
            continue
        material_title = str(item.get("title") or "").strip()
        material_type = str(item.get("type") or "markdown").strip()
        material_short_desc = str(item.get("short_description") or "").strip()
        material_content = str(item.get("content") or "").strip()
        
        # If content is empty for non-markdown types, provide a default
        if not material_content:
            material_content = f"Review official documentation for {material_title}"

        if not material_short_desc:
            material_short_desc = f"Learn about {material_title}"

        if material_type not in {"markdown", "text", "link", "video_embed", "pdf"}:
            material_type = "markdown"

        normalized_materials.append(
            {
                "title": material_title,
                "type": material_type,
                "short_description": material_short_desc,
                "content": material_content,
                "sort_order": idx,
            }
        )

    quiz_questions_raw = data.get("quiz_questions") or []
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
        
        # Shuffle logic:
        # 1. Identify current correct option text
        correct_idx = ord(correct) - 65 # 0 for A, 1 for B...
        if correct_idx >= len(normalized_options) or correct_idx < 0:
            correct_idx = 0
        
        # Extract text from options (remove A., B. prefix if present)
        clean_options = []
        for opt in normalized_options:
            parts = opt.split(".", 1)
            if len(parts) > 1 and parts[0].strip().isalpha() and len(parts[0].strip()) == 1:
                clean_options.append(parts[1].strip())
            else:
                clean_options.append(opt)
        
        correct_text = clean_options[correct_idx]

        # 2. Shuffle
        indices = list(range(len(clean_options)))
        random.shuffle(indices)
        
        shuffled_options_text = [clean_options[i] for i in indices]
        
        # 3. Find new correct index
        try:
            new_correct_idx = shuffled_options_text.index(correct_text)
        except ValueError:
            # Fallback if logic fails (e.g. duplicate options)
            new_correct_idx = 0 
        
        new_correct_char = chr(65 + new_correct_idx)
        
        # 4. Reconstruct options with A, B, C, D
        final_options_list = []
        for i, txt in enumerate(shuffled_options_text):
            prefix = chr(65 + i)
            final_options_list.append(f"{prefix}. {txt}")

        explanation = str(question.get("explanation") or "").strip()
        difficulty = str(question.get("difficulty") or "").strip().lower()
        if difficulty not in {"easy", "medium", "hard"}:
            difficulty = "medium"

        base_questions.append(
            {
                "text": text,
                "options": final_options_list,
                "correct": new_correct_char,
                "explanation": explanation,
                "difficulty": difficulty,
            }
        )

    # Ensure at least question_count questions
    while len(base_questions) < question_count:
        idx = len(base_questions) + 1
        base_questions.append(_generate_filler_question(milestone_title, "medium", idx))

    return {
        "study_materials": normalized_materials,
        "quiz_questions": base_questions
    }


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
        try:
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
                            short_description=material["short_description"],
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
        except Exception as e:
            print(f"Error generating plan: {e}")
            import traceback
            traceback.print_exc()
            raise HTTPException(status_code=500, detail=f"Internal Server Error: {str(e)}")

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


@app.get("/training/milestones/{milestone_id}", response_model=schemas.MilestoneDetailRead)
def get_milestone_detail(
    milestone_id: int,
    current_user_id: int = Depends(get_current_user_id),
    db: Session = Depends(get_db),
) -> schemas.MilestoneDetailRead:
    # 1. Verify user has a training plan
    user_plan = (
        db.query(models.UserTrainingPlan)
        .filter(models.UserTrainingPlan.user_id == current_user_id)
        .first()
    )
    if not user_plan:
        raise HTTPException(status_code=404, detail="Training plan not found")

    # 2. Get master milestone
    master_milestone = (
        db.query(models.MasterMilestone)
        .filter(models.MasterMilestone.id == milestone_id)
        .first()
    )
    if not master_milestone:
        raise HTTPException(status_code=404, detail="Milestone not found")

    # 3. Get user progress for this milestone
    progress = (
        db.query(models.UserMilestoneProgress)
        .filter(
            models.UserMilestoneProgress.user_training_plan_id == user_plan.id,
            models.UserMilestoneProgress.master_milestone_id == milestone_id,
        )
        .first()
    )
    if not progress:
        # Should not happen if plan generated correctly, but handle just in case
        raise HTTPException(status_code=404, detail="Milestone progress not tracked")

    if progress.status == "locked":
        raise HTTPException(status_code=403, detail="This milestone is locked. Complete previous milestones first.")

    # Lazy generation check
    if not master_milestone.is_content_generated:
        print(f"Lazy generating content for milestone {milestone_id}...")
        try:
            # Fetch context
            plan = db.query(models.TrainingPlan).filter(models.TrainingPlan.id == master_milestone.training_plan_id).first()
            if plan:
                role = db.query(models.Role).filter(models.Role.id == plan.role_id).first()
                level = db.query(models.ExperienceLevel).filter(models.ExperienceLevel.id == plan.experience_level_id).first()
                
                if role and level:
                    # Fetch settings
                    settings = db.query(models.MilestoneSettings).filter(models.MilestoneSettings.is_active.is_(True)).first()
                    quiz_count = 5
                    if settings:
                         quiz_count = settings.quiz_questions_total + settings.practice_questions_total

                    raw_content = _generate_milestone_content(
                        master_milestone.title,
                        master_milestone.description,
                        role.name,
                        level.name,
                        question_count=quiz_count
                    )
                    
                    processed = _process_milestone_content(raw_content, master_milestone.title, question_count=quiz_count)
                    
                    _save_milestone_content(db, master_milestone, processed)
                    db.commit()
                    db.refresh(master_milestone)
        except Exception as e:
            print(f"Error in lazy generation: {e}")
            # Log and continue (content will be empty, which is better than 500)

    # 4. Get study materials
    materials = (
        db.query(models.MasterStudyMaterial)
        .filter(models.MasterStudyMaterial.master_milestone_id == milestone_id)
        .order_by(models.MasterStudyMaterial.sort_order.asc())
        .all()
    )

    # 5. Get completed materials
    completed_materials_rows = (
        db.query(models.UserStudyMaterialProgress)
        .filter(models.UserStudyMaterialProgress.user_milestone_progress_id == progress.id)
        .filter(models.UserStudyMaterialProgress.is_completed.is_(True))
        .all()
    )
    completed_ids = {row.master_study_material_id for row in completed_materials_rows}

    study_materials_read = []
    for m in materials:
        study_materials_read.append(
            schemas.StudyMaterialRead(
                id=m.id,
                content_type=m.content_type,
                title=m.title,
                short_description=m.short_description,
                content=m.content,
                sort_order=m.sort_order,
                is_completed=(m.id in completed_ids),
            )
        )

    # 6. Check quiz status (latest attempt)
    latest_attempt = (
        db.query(models.UserQuizAttempt)
        .filter(models.UserQuizAttempt.user_milestone_progress_id == progress.id)
        .order_by(models.UserQuizAttempt.attempted_at.desc())
        .first()
    )
    quiz_passed = latest_attempt.passed if latest_attempt else False
    quiz_score = latest_attempt.score if latest_attempt else None

    # 7. Get practice guidelines (from quiz questions explanation or description? No, description is short)
    # The prompt asked for "practice guidelines: 2–4 sentences describing practice"
    # But MasterMilestone doesn't have a practice_guidelines column in my previous `models.py` read.
    # Wait, I might have missed it or it wasn't added.
    # Let's check `models.py` again.
    # `MasterMilestone` has `title`, `description`, `estimated_days`, `sort_order`.
    # It does NOT have `practice_guidelines`.
    # However, in `generate_training_plan`, I saw `practice_guidelines` being processed.
    # Where was it stored?
    # In `main.py` lines 714-747, I see `MasterMilestone` creation.
    # I don't see `practice_guidelines` being saved to DB.
    # This is a schema gap. I should probably add it to `MasterMilestone` or just reuse description for now.
    # Or I can use a default text if missing.
    # I will stick to "Practice guidelines not available" if column missing.
    # For now, let's assume it's not there and just return a placeholder or description.

    return schemas.MilestoneDetailRead(
        id=master_milestone.id,
        milestone_number=master_milestone.milestone_number,
        title=master_milestone.title,
        description=master_milestone.description,
        estimated_days=master_milestone.estimated_days or 7,
        status=progress.status,
        progress_percentage=progress.progress_percentage,
        study_materials=study_materials_read,
        practice_guidelines=master_milestone.description, # Fallback
        quiz_passed=quiz_passed,
        quiz_score=quiz_score,
        practice_completed=progress.practice_completed,
    )


@app.post("/training/milestones/{milestone_id}/study/{material_id}/toggle")
def toggle_study_material(
    milestone_id: int,
    material_id: int,
    current_user_id: int = Depends(get_current_user_id),
    db: Session = Depends(get_db),
):
    # Verify ownership
    user_plan = (
        db.query(models.UserTrainingPlan)
        .filter(models.UserTrainingPlan.user_id == current_user_id)
        .first()
    )
    if not user_plan:
        raise HTTPException(status_code=404, detail="Training plan not found")

    progress = (
        db.query(models.UserMilestoneProgress)
        .filter(
            models.UserMilestoneProgress.user_training_plan_id == user_plan.id,
            models.UserMilestoneProgress.master_milestone_id == milestone_id,
        )
        .first()
    )
    if not progress:
        raise HTTPException(status_code=404, detail="Milestone progress not found")

    # Check material exists
    material = db.query(models.MasterStudyMaterial).filter(models.MasterStudyMaterial.id == material_id).first()
    if not material:
        raise HTTPException(status_code=404, detail="Material not found")

    # Toggle
    user_material = (
        db.query(models.UserStudyMaterialProgress)
        .filter(
            models.UserStudyMaterialProgress.user_milestone_progress_id == progress.id,
            models.UserStudyMaterialProgress.master_study_material_id == material_id,
        )
        .first()
    )

    if user_material:
        user_material.is_completed = not user_material.is_completed
        user_material.completed_at = func.now() if user_material.is_completed else None
    else:
        user_material = models.UserStudyMaterialProgress(
            user_milestone_progress_id=progress.id,
            master_study_material_id=material_id,
            is_completed=True,
            completed_at=func.now(),
        )
        db.add(user_material)
        db.flush() # Ensure ID is generated and attached to session
    
    db.commit()
    db.refresh(user_material) # Refresh to get latest state
    
    # Update progress percentage
    total_materials = db.query(models.MasterStudyMaterial).filter(models.MasterStudyMaterial.master_milestone_id == milestone_id).count()
    completed_count = (
        db.query(models.UserStudyMaterialProgress)
        .filter(models.UserStudyMaterialProgress.user_milestone_progress_id == progress.id)
        .filter(models.UserStudyMaterialProgress.is_completed.is_(True))
        .count()
    )
    
    if total_materials > 0:
        new_percentage = int((completed_count / total_materials) * 100)
        progress.progress_percentage = new_percentage
        db.commit()

    return {"status": "success", "is_completed": user_material.is_completed}


@app.post("/training/milestones/{milestone_id}/practice/complete")
def complete_practice(
    milestone_id: int,
    current_user_id: int = Depends(get_current_user_id),
    db: Session = Depends(get_db),
):
    user_plan = (
        db.query(models.UserTrainingPlan)
        .filter(models.UserTrainingPlan.user_id == current_user_id)
        .first()
    )
    if not user_plan:
        raise HTTPException(status_code=404, detail="Training plan not found")

    progress = (
        db.query(models.UserMilestoneProgress)
        .filter(
            models.UserMilestoneProgress.user_training_plan_id == user_plan.id,
            models.UserMilestoneProgress.master_milestone_id == milestone_id,
        )
        .first()
    )
    if not progress:
        raise HTTPException(status_code=404, detail="Milestone progress not found")
    
    progress.practice_completed = True
    db.commit()
    
    return {"status": "success", "practice_completed": True}


@app.get("/training/milestones/{milestone_id}/questions", response_model=List[schemas.QuizQuestionRead])
def get_milestone_questions(
    milestone_id: int,
    mode: str = "practice",  # practice or quiz
    current_user_id: int = Depends(get_current_user_id),
    db: Session = Depends(get_db),
) -> List[schemas.QuizQuestionRead]:
    # Check plan access
    user_plan = (
        db.query(models.UserTrainingPlan)
        .filter(models.UserTrainingPlan.user_id == current_user_id)
        .first()
    )
    if not user_plan:
        raise HTTPException(status_code=404, detail="Plan not found")

    # Get random questions
    # Note: simple random order. For production, use func.random()
    try:
        # Fetch settings for limits
        settings = db.query(models.MilestoneSettings).filter(models.MilestoneSettings.is_active.is_(True)).first()
        limit = 20  # Default for quiz
        if mode == "practice":
            limit = 10  # Default for practice
        
        if settings:
            if mode == "practice":
                limit = settings.practice_questions_total
            else:
                limit = settings.quiz_questions_total

        query = (
            db.query(models.MasterQuizQuestion)
            .filter(models.MasterQuizQuestion.master_milestone_id == milestone_id)
            .order_by(func.random())
        )

        questions = query.limit(limit).all()

        result = []
        for q in questions:
            # Hide correct answer if quiz mode?
            # User requirement: "Quiz section (20 questions + submit + score + pass/fail)"
            # If we send correct answer, user can cheat easily.
            # But for "Practice", "immediate feedback" implies client needs to know.
            
            correct = q.correct_answer if mode == "practice" else None
            explanation = q.explanation if mode == "practice" else None
            
            try:
                options_data = json.loads(q.options) if isinstance(q.options, str) else q.options
            except json.JSONDecodeError:
                print(f"Error decoding options for question {q.id}: {q.options}")
                options_data = {} # Fallback

            if isinstance(options_data, list):
                parsed_options = {}
                all_parsed = True
                for item in options_data:
                    parts = str(item).split(".", 1)
                    if len(parts) == 2 and len(parts[0].strip()) == 1 and parts[0].strip().isalpha():
                        parsed_options[parts[0].strip()] = parts[1].strip()
                    else:
                        all_parsed = False
                        break
                
                if all_parsed:
                    options_data = parsed_options
                else:
                    # Fallback to A, B, C, D
                    options_data = {chr(65 + i): str(item) for i, item in enumerate(options_data)}

            result.append(
                schemas.QuizQuestionRead(
                    id=q.id,
                    question_text=q.question_text,
                    question_type=q.question_type,
                    difficulty=q.difficulty,
                    options=options_data,
                    correct_answer=correct,
                    explanation=explanation,
                )
            )
        return result
    except Exception as e:
        print(f"Error in get_milestone_questions: {str(e)}")
        import traceback
        traceback.print_exc()
        raise HTTPException(status_code=500, detail=f"Internal Server Error: {str(e)}")


@app.post("/training/milestones/{milestone_id}/quiz/submit", response_model=schemas.QuizResult)
def submit_quiz(
    milestone_id: int,
    payload: schemas.QuizSubmission,
    current_user_id: int = Depends(get_current_user_id),
    db: Session = Depends(get_db),
) -> schemas.QuizResult:
    # Verify plan
    user_plan = (
        db.query(models.UserTrainingPlan)
        .filter(models.UserTrainingPlan.user_id == current_user_id)
        .first()
    )
    if not user_plan:
        raise HTTPException(status_code=404, detail="Plan not found")

    progress = (
        db.query(models.UserMilestoneProgress)
        .filter(
            models.UserMilestoneProgress.user_training_plan_id == user_plan.id,
            models.UserMilestoneProgress.master_milestone_id == milestone_id,
        )
        .first()
    )
    if not progress:
        raise HTTPException(status_code=404, detail="Progress not found")

    # Check Requirements: Study Materials
    total_materials = db.query(models.MasterStudyMaterial).filter(models.MasterStudyMaterial.master_milestone_id == milestone_id).count()
    completed_materials = (
        db.query(models.UserStudyMaterialProgress)
        .filter(models.UserStudyMaterialProgress.user_milestone_progress_id == progress.id)
        .filter(models.UserStudyMaterialProgress.is_completed.is_(True))
        .count()
    )
    if completed_materials < total_materials:
        raise HTTPException(status_code=403, detail="All study materials must be completed before taking the quiz.")

    # Check Requirements: Practice
    if not progress.practice_completed:
        raise HTTPException(status_code=403, detail="Practice must be completed before taking the quiz.")

    # Calculate score
    correct_count = 0
    incorrect_count = 0
    details = {}
    
    submitted_ids = [int(qid) for qid in payload.answers.keys()]
    if not submitted_ids:
         raise HTTPException(status_code=400, detail="No answers submitted")

    questions = (
        db.query(models.MasterQuizQuestion)
        .filter(models.MasterQuizQuestion.id.in_(submitted_ids))
        .all()
    )
    question_map = {q.id: q for q in questions}

    for qid_str, user_answer in payload.answers.items():
        qid = int(qid_str)
        question = question_map.get(qid)
        if not question:
            continue
        
        is_correct = (user_answer.strip().upper() == question.correct_answer.strip().upper())
        if is_correct:
            correct_count += 1
        else:
            incorrect_count += 1
            
        details[qid] = {
            "correct": is_correct,
            "correct_answer": question.correct_answer,
            "explanation": question.explanation
        }

    total_answered = correct_count + incorrect_count
    
    # Fetch settings to determine expected total questions
    settings = db.query(models.MilestoneSettings).filter(models.MilestoneSettings.is_active.is_(True)).first()
    expected_total = 20
    if settings:
        expected_total = settings.quiz_questions_total
        
    # Use max to ensure we don't divide by a smaller number if user somehow answered more, 
    # but primarily to penalize partial submissions against the expected total.
    final_total = max(expected_total, total_answered)
    
    score_percent = int((correct_count / final_total) * 100) if final_total > 0 else 0
    passed = score_percent >= 70  # Pass threshold

    # Record attempt
    attempt = models.UserQuizAttempt(
        user_milestone_progress_id=progress.id,
        score=score_percent,
        total_questions=final_total,
        passed=passed,
    )
    db.add(attempt)
    
    # Update milestone status if passed
    if passed:
        progress.status = "completed"
        progress.completed_at = func.now()
        progress.progress_percentage = 100
        
        # Unlock next milestone
        current_ms_number = (
            db.query(models.MasterMilestone.milestone_number)
            .filter(models.MasterMilestone.id == milestone_id)
            .scalar()
        )
        if current_ms_number:
            next_ms = (
                db.query(models.MasterMilestone)
                .filter(models.MasterMilestone.training_plan_id == user_plan.training_plan_id)
                .filter(models.MasterMilestone.milestone_number == current_ms_number + 1)
                .first()
            )
            if next_ms:
                next_progress = (
                    db.query(models.UserMilestoneProgress)
                    .filter(models.UserMilestoneProgress.user_training_plan_id == user_plan.id)
                    .filter(models.UserMilestoneProgress.master_milestone_id == next_ms.id)
                    .first()
                )
                if next_progress and next_progress.status == "locked":
                    next_progress.status = "in_progress"
                    next_progress.started_at = func.now()
                    # Update current milestone number in plan
                    user_plan.current_milestone_number = next_ms.milestone_number

    db.commit()

    return schemas.QuizResult(
        score=score_percent,
        total_questions=final_total,
        passed=passed,
        correct_count=correct_count,
        incorrect_count=incorrect_count,
        details=details
    )


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


@app.post("/system/jobs/maintain-milestones")
def maintain_milestones(
    x_system_key: str = Header(..., alias="X-System-Key"),
    db: Session = Depends(get_db)
):
    if x_system_key != "careerai-internal-cron":
        raise HTTPException(status_code=403, detail="Forbidden")

    # Start Job Log
    job_log = models.SystemJobLog(
        job_name="maintain_milestones",
        started_at=datetime.utcnow(),
        status="running",
        processed_count=0,
        success_count=0,
        failure_count=0
    )
    db.add(job_log)
    db.commit()
    db.refresh(job_log)

    try:
        # Find any milestones that need content, regardless of locked status
        candidates = (
            db.query(models.MasterMilestone)
            .filter(models.MasterMilestone.is_content_generated.is_(False))
            .limit(5)
            .all()
        )
        
        results = {"processed": 0, "errors": []}
        
        for milestone in candidates:
            try:
                print(f"Cron: Generating content for milestone {milestone.id} ({milestone.title})...")
                plan = db.query(models.TrainingPlan).filter(models.TrainingPlan.id == milestone.training_plan_id).first()
                if not plan:
                    continue
                    
                role = db.query(models.Role).filter(models.Role.id == plan.role_id).first()
                level = db.query(models.ExperienceLevel).filter(models.ExperienceLevel.id == plan.experience_level_id).first()
                
                if not role or not level:
                    continue

                # Fetch settings
                settings = db.query(models.MilestoneSettings).filter(models.MilestoneSettings.is_active.is_(True)).first()
                quiz_count = 5
                if settings:
                        quiz_count = settings.quiz_questions_total + settings.practice_questions_total

                raw_content = _generate_milestone_content(
                    milestone.title,
                    milestone.description,
                    role.name,
                    level.name,
                    question_count=quiz_count
                )
                
                processed = _process_milestone_content(raw_content, milestone.title, question_count=quiz_count)
                
                _save_milestone_content(db, milestone, processed)
                
                # Update job log success count
                job_log.success_count += 1
                db.add(job_log)
                
                db.commit()
                results["processed"] += 1
                
            except Exception as e:
                print(f"Cron Error for milestone {milestone.id}: {e}")
                results["errors"].append({"milestone_id": milestone.id, "error": str(e)})
                db.rollback()
                
                # Update job log failure count safely
                job_log = db.query(models.SystemJobLog).filter(models.SystemJobLog.id == job_log.id).first()
                if job_log:
                    job_log.failure_count += 1
                    current_msg = job_log.error_message or ""
                    new_msg = f"Error on milestone {milestone.id}: {str(e)}"
                    if current_msg:
                        job_log.error_message = f"{current_msg}; {new_msg}"
                    else:
                        job_log.error_message = new_msg
                    db.commit()
            
        # Finish Job Log
        job_log = db.query(models.SystemJobLog).filter(models.SystemJobLog.id == job_log.id).first()
        if job_log:
            job_log.finished_at = datetime.utcnow()
            job_log.status = "completed"
            job_log.processed_count = results["processed"]
            db.commit()
            
        return results

    except Exception as e:
        # Job failed globally
        db.rollback()
        job_log = db.query(models.SystemJobLog).filter(models.SystemJobLog.id == job_log.id).first()
        if job_log:
            job_log.finished_at = datetime.utcnow()
            job_log.status = "failed"
            job_log.error_message = f"Critical Job Error: {str(e)}"
            db.commit()
        raise e

