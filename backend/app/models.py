from sqlalchemy import Boolean, Column, DateTime, Float, ForeignKey, Integer, String, Text, func

from .database import Base


class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(255), nullable=False)
    email = Column(String(255), unique=True, index=True, nullable=False)
    phone = Column(String(50), nullable=False)
    face_encoding = Column(Text, nullable=False)
    profile_image = Column(Text, nullable=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now(), nullable=False)


class Role(Base):
    __tablename__ = "roles"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(255), unique=True, nullable=False)
    sort_order = Column(Integer, nullable=False, server_default="0")
    is_active = Column(Boolean, nullable=False, server_default="1")


class ExperienceLevel(Base):
    __tablename__ = "experience_levels"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(255), unique=True, nullable=False)
    sort_order = Column(Integer, nullable=False, server_default="0")
    is_active = Column(Boolean, nullable=False, server_default="1")


class UserOnboarding(Base):
    __tablename__ = "user_onboarding"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False, unique=True)
    role_id = Column(Integer, ForeignKey("roles.id"), nullable=True)
    experience_level_id = Column(Integer, ForeignKey("experience_levels.id"), nullable=True)
    skills = Column(Text, nullable=True)
    resume_file_name = Column(String(255), nullable=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now(), nullable=False)
    updated_at = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now(), nullable=False)


class UserLoginDetail(Base):
    __tablename__ = "user_login_details"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    login_method = Column(String(20), nullable=True)
    face_encoding = Column(Text, nullable=True)
    face_image_path = Column(String(500), nullable=True)
    confidence_score = Column(Float, nullable=True)
    ip_address = Column(String(45), nullable=True)
    device_info = Column(String(255), nullable=True)
    browser_info = Column(String(255), nullable=True)
    os_info = Column(String(100), nullable=True)
    login_status = Column(String(10), nullable=False)
    failure_reason = Column(String(255), nullable=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now(), nullable=False)


class TrainingPlan(Base):
    __tablename__ = "training_plans"

    id = Column(Integer, primary_key=True, index=True)
    role_id = Column(Integer, ForeignKey("roles.id"), nullable=False)
    experience_level_id = Column(Integer, ForeignKey("experience_levels.id"), nullable=False)
    title = Column(String(255), nullable=True)
    description = Column(Text, nullable=True)
    is_generated = Column(Boolean, nullable=False, server_default="0")
    generated_at = Column(DateTime(timezone=True), server_default=func.now(), nullable=False)


class MasterMilestone(Base):
    __tablename__ = "master_milestones"

    id = Column(Integer, primary_key=True, index=True)
    training_plan_id = Column(Integer, ForeignKey("training_plans.id"), nullable=False)
    milestone_number = Column(Integer, nullable=False)
    title = Column(String(255), nullable=False)
    description = Column(Text, nullable=True)
    estimated_days = Column(Integer, nullable=True)
    sort_order = Column(Integer, nullable=False, server_default="0")


class MasterStudyMaterial(Base):
    __tablename__ = "master_study_materials"

    id = Column(Integer, primary_key=True, index=True)
    master_milestone_id = Column(Integer, ForeignKey("master_milestones.id"), nullable=False)
    content_type = Column(String(20), nullable=False, server_default="markdown")
    title = Column(String(255), nullable=True)
    short_description = Column(Text, nullable=True)
    content = Column(Text, nullable=True)
    sort_order = Column(Integer, nullable=False, server_default="0")


class MasterQuizQuestion(Base):
    __tablename__ = "master_quiz_questions"

    id = Column(Integer, primary_key=True, index=True)
    master_milestone_id = Column(Integer, ForeignKey("master_milestones.id"), nullable=False)
    question_text = Column(Text, nullable=False)
    question_type = Column(String(50), nullable=False, server_default="multiple_choice")
    difficulty = Column(String(20), nullable=False)
    options = Column(Text, nullable=True)
    correct_answer = Column(String(100), nullable=False)
    explanation = Column(Text, nullable=True)
    tags = Column(String(255), nullable=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now(), nullable=False)


class UserTrainingPlan(Base):
    __tablename__ = "user_training_plans"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    training_plan_id = Column(Integer, ForeignKey("training_plans.id"), nullable=False)
    assigned_at = Column(DateTime(timezone=True), server_default=func.now(), nullable=False)
    status = Column(String(20), nullable=False, server_default="active")
    current_milestone_number = Column(Integer, nullable=False, server_default="1")


class UserMilestoneProgress(Base):
    __tablename__ = "user_milestone_progress"

    id = Column(Integer, primary_key=True, index=True)
    user_training_plan_id = Column(Integer, ForeignKey("user_training_plans.id"), nullable=False)
    master_milestone_id = Column(Integer, ForeignKey("master_milestones.id"), nullable=False)
    status = Column(String(20), nullable=False, server_default="locked")
    started_at = Column(DateTime(timezone=True), nullable=True)
    completed_at = Column(DateTime(timezone=True), nullable=True)
    progress_percentage = Column(Integer, nullable=False, server_default="0")
    practice_completed = Column(Boolean, nullable=False, server_default="0")


class UserStudyMaterialProgress(Base):
    __tablename__ = "user_study_material_progress"

    id = Column(Integer, primary_key=True, index=True)
    user_milestone_progress_id = Column(Integer, ForeignKey("user_milestone_progress.id"), nullable=False)
    master_study_material_id = Column(Integer, ForeignKey("master_study_materials.id"), nullable=False)
    is_completed = Column(Boolean, nullable=False, server_default="0")
    completed_at = Column(DateTime(timezone=True), nullable=True)


class UserQuizAttempt(Base):
    __tablename__ = "user_quiz_attempts"

    id = Column(Integer, primary_key=True, index=True)
    user_milestone_progress_id = Column(Integer, ForeignKey("user_milestone_progress.id"), nullable=False)
    score = Column(Integer, nullable=False)
    total_questions = Column(Integer, nullable=False)
    passed = Column(Boolean, nullable=False, server_default="0")
    attempted_at = Column(DateTime(timezone=True), server_default=func.now(), nullable=False)
