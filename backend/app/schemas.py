from typing import List, Optional

from pydantic import BaseModel, EmailStr


class FaceScanRequest(BaseModel):
    encoding: List[float]


class UserBase(BaseModel):
    name: str
    email: EmailStr
    phone: str


class UserRead(UserBase):
    id: int
    profile_image: Optional[str] = None

    class Config:
        from_attributes = True


class FaceLoginResponse(BaseModel):
    status: str
    token: Optional[str] = None
    user: Optional[UserRead] = None


class RegisterRequest(UserBase):
    encoding: List[float]
    profile_image: Optional[str] = None


class RegisterResponse(BaseModel):
    token: str
    user: UserRead


class ProfileImageUpdate(BaseModel):
    profile_image: Optional[str] = None


class RoleRead(BaseModel):
    id: int
    name: str

    class Config:
        from_attributes = True


class ExperienceLevelRead(BaseModel):
    id: int
    name: str

    class Config:
        from_attributes = True


class OnboardingBase(BaseModel):
    user_id: int
    role_id: Optional[int] = None
    experience_level_id: Optional[int] = None
    skills: Optional[str] = None
    resume_file_name: Optional[str] = None


class OnboardingCreate(OnboardingBase):
    pass


class OnboardingRead(OnboardingBase):
    id: int

    class Config:
        from_attributes = True


class TrainingPlanGenerateRequest(BaseModel):
    role_id: int
    experience_level_id: int
    skills: Optional[str] = None


class StudyMaterialRead(BaseModel):
    id: int
    content_type: str
    title: Optional[str] = None
    short_description: Optional[str] = None
    content: Optional[str] = None
    sort_order: int
    is_completed: bool = False

    class Config:
        from_attributes = True


class QuizQuestionRead(BaseModel):
    id: int
    question_text: str
    question_type: str
    difficulty: str
    options: dict  # Parsed JSON
    correct_answer: Optional[str] = None
    explanation: Optional[str] = None

    class Config:
        from_attributes = True


class MilestoneDetailRead(BaseModel):
    id: int
    milestone_number: int
    title: str
    description: Optional[str] = None
    estimated_days: int
    status: str
    progress_percentage: int
    practice_completed: bool = False
    study_materials: List[StudyMaterialRead]
    practice_guidelines: Optional[str] = None
    quiz_passed: bool = False
    quiz_score: Optional[int] = None


class QuizSubmission(BaseModel):
    answers: dict  # question_id -> answer_string


class QuizResult(BaseModel):
    score: int
    total_questions: int
    passed: bool
    correct_count: int
    incorrect_count: int
    details: dict  # question_id -> {correct: bool, correct_answer: str, explanation: str}


class MilestoneStatusRead(BaseModel):
    id: int
    milestone_number: int
    title: str
    description: Optional[str] = None
    estimated_days: int
    status: str

    class Config:
        from_attributes = True


class TrainingPlanRead(BaseModel):
    id: int
    title: Optional[str] = None
    description: Optional[str] = None
    current_milestone_number: int
    milestones: List[MilestoneStatusRead]


class TrainingPlanResponse(BaseModel):
    has_plan: bool
    plan: Optional[TrainingPlanRead] = None
