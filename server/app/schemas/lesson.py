# schemas/lesson.py
from pydantic import BaseModel
from typing import Optional

class LessonCreate(BaseModel):
    course_id: int  # Include course_id in the body
    title: str
    content: Optional[str] = None

class LessonOut(BaseModel):
    id: int
    title: str
    content: Optional[str] = None
    media_url: Optional[str] = None

    class Config:
        orm_mode = True
