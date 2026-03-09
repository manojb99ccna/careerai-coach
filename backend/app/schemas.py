from typing import List, Optional

from pydantic import BaseModel, EmailStr


class FaceScanRequest(BaseModel):
    encoding: List[float]
    image_data_url: Optional[str] = None


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
    sort_order: int = 0
    is_active: bool = True

    class Config:
        from_attributes = True


class ExperienceLevelRead(BaseModel):
    id: int
    name: str
    sort_order: int = 0
    is_active: bool = True

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


class AdminUserListItem(BaseModel):
    id: int
    name: str
    email: EmailStr
    phone: str
    profile_image: Optional[str] = None
    created_at: Optional[str] = None
    role_name: Optional[str] = None
    experience_level_name: Optional[str] = None
    has_plan: bool = False
    current_milestone_number: Optional[int] = None
    total_milestones: int = 0
    completed_milestones: int = 0
    last_login_at: Optional[str] = None


class AdminUserListResponse(BaseModel):
    total: int
    users: List[AdminUserListItem]


class AdminFaceLoginAttemptRead(BaseModel):
    id: int
    matched_user_id: Optional[int] = None
    match_type: str
    face_image_path: Optional[str] = None
    confidence_score: Optional[float] = None
    ip_address: Optional[str] = None
    device_info: Optional[str] = None
    browser_info: Optional[str] = None
    os_info: Optional[str] = None
    login_status: str
    failure_reason: Optional[str] = None
    created_at: str


class AdminDashboardSummary(BaseModel):
    total_users: int
    total_training_plans: int
    active_user_plans: int
    total_milestones: int
    completed_milestones: int
    registrations_by_day: List[dict]
    logins_by_day: List[dict]


class AdminRoleWrite(BaseModel):
    name: str
    sort_order: int = 0
    is_active: bool = True


class AdminExperienceLevelWrite(BaseModel):
    name: str
    sort_order: int = 0
    is_active: bool = True


class AdminMilestoneSettingsRead(BaseModel):
    id: int
    quiz_questions_total: int
    practice_questions_total: int
    is_active: bool
    created_at: Optional[str] = None
    updated_at: Optional[str] = None


class AdminMilestoneSettingsUpdate(BaseModel):
    quiz_questions_total: Optional[int] = None
    practice_questions_total: Optional[int] = None
    is_active: Optional[bool] = None


class AdminMilestoneProgressItem(BaseModel):
    master_milestone_id: int
    milestone_number: int
    title: str
    status: str
    started_at: Optional[str] = None
    completed_at: Optional[str] = None
    progress_percentage: int
    practice_completed: bool
    practice_completed_at: Optional[str] = None
    study_materials_total: int
    study_materials_completed: int
    last_quiz_score: Optional[int] = None
    last_quiz_total: Optional[int] = None
    last_quiz_passed: Optional[bool] = None
    last_quiz_at: Optional[str] = None
    # Detailed breakdowns
    study_materials_detail: Optional[List["AdminStudyMaterialItem"]] = None
    last_quiz_detail: Optional["AdminQuizAttemptDetail"] = None


class AdminUserProgressResponse(BaseModel):
    user_id: int
    user_training_plan_id: Optional[int] = None
    training_plan_id: Optional[int] = None
    plan_title: Optional[str] = None
    plan_description: Optional[str] = None
    current_milestone_number: Optional[int] = None
    milestones: List[AdminMilestoneProgressItem]


class AdminEmailPasswordLoginRequest(BaseModel):
    email: EmailStr
    password: str


class AdminLoginResponse(BaseModel):
    token: str
    user: UserRead


class AdminSetPasswordRequest(BaseModel):
    password: str


class AdminStudyMaterialItem(BaseModel):
    id: int
    title: Optional[str] = None
    is_completed: bool = False
    completed_at: Optional[str] = None


class AdminQuizAnswerItem(BaseModel):
    question_id: int
    question_text: Optional[str] = None
    options: Optional[list] = None
    selected_answer: Optional[str] = None
    correct_answer: Optional[str] = None
    is_correct: bool = False


class AdminQuizAttemptDetail(BaseModel):
    attempted_at: Optional[str] = None
    score: int
    total_questions: int
    passed: bool
    answers: List[AdminQuizAnswerItem]
