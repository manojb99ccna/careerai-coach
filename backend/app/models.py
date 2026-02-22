from sqlalchemy import Boolean, Column, DateTime, ForeignKey, Integer, String, Text, func

from .database import Base


class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(255), nullable=False)
    email = Column(String(255), unique=True, index=True, nullable=False)
    phone = Column(String(50), nullable=False)
    face_encoding = Column(Text, nullable=False)
    created_at = Column(DateTime(timezone=True), server_default=func.now(), nullable=False)


class Role(Base):
    __tablename__ = "roles"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(255), unique=True, nullable=False)
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
