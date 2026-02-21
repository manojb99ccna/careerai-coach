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

    class Config:
        from_attributes = True


class FaceLoginResponse(BaseModel):
    status: str
    token: Optional[str] = None
    user: Optional[UserRead] = None


class RegisterRequest(UserBase):
    encoding: List[float]


class RegisterResponse(BaseModel):
    token: str
    user: UserRead

