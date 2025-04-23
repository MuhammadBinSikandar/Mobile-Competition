# routers/lessons.py
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.models.lesson import Lesson
from app.models.course import Course
from app.schemas.lesson import LessonCreate, LessonOut
from app.services.auth import get_current_user
from app.database import get_db
from app.models.user import User
from app.routers import flashcards
from app.models.flashcard import Flashcard  # Import the Flashcard model

router = APIRouter(prefix="/lessons", tags=["Lessons"])

@router.post("/", response_model=LessonOut)
async def create_lesson(
    lesson_data: LessonCreate,  # Accept lesson data in the body
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    # Check if the course exists
    course = db.query(Course).filter(Course.id == lesson_data.course_id).first()
    if not course:
        raise HTTPException(status_code=404, detail="Course not found")

    # Ensure the user is the tutor of this course
    if course.tutor_id != current_user.id:
        raise HTTPException(status_code=403, detail="Unauthorized")

    # Create the lesson
    lesson = Lesson(
        title=lesson_data.title,
        content=lesson_data.content,
        course_id=lesson_data.course_id  # Link the course_id from the body
    )

    db.add(lesson)
    db.commit()
    db.refresh(lesson)

    return lesson


@router.get("/{course_id}", response_model=list[LessonOut])
def get_lessons_for_course(
    course_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    # Check if the course exists
    course = db.query(Course).filter(Course.id == course_id).first()
    if not course:
        raise HTTPException(status_code=404, detail="Course not found")
    
    # Fetch lessons for the course
    lessons = db.query(Lesson).filter(Lesson.course_id == course_id).all()
    
    if not lessons:
        raise HTTPException(status_code=404, detail="No lessons found for this course")
    
    # Assume AI summaries and flashcards are stored in a related model
    for lesson in lessons:
        lesson.ai_summary = "AI-generated summary for lesson"  # Placeholder for AI summary
        lesson.flashcards = db.query(flashcards).filter(Flashcard.lesson_id == lesson.id).all()  # Placeholder for flashcards
    
    return lessons