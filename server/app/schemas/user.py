# schemas/user.py
from pydantic import BaseModel

class UserCreate(BaseModel):
    first_name: str
    last_name: str
    username: str
    email: str
    password: str
    role: str = 'student'  # 'tutor' or 'student', default to 'student'

class UserLogin(BaseModel):
    email: str
    password: str

class UserOut(BaseModel):
    email: str
    role: str  # Include the role in the response

    class Config:
        from_attributes = True
