# routers/flashcards.py
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.models.flashcard import Flashcard
from app.models.lesson import Lesson
from app.schemas.flashcard import FlashcardCreate, FlashcardOut
from app.database import get_db
from app.services.auth import get_current_user
from app.models.user import User

router = APIRouter(prefix="/flashcards", tags=["Flashcards"])

@router.post("/", response_model=FlashcardOut)
def create_flashcard(
    flashcard_data: FlashcardCreate,
    lesson_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    # Check if the lesson exists
    lesson = db.query(Lesson).filter(Lesson.id == lesson_id).first()
    if not lesson:
        raise HTTPException(status_code=404, detail="Lesson not found")
    
    flashcard = Flashcard(
        question=flashcard_data.question,
        answer=flashcard_data.answer,
        lesson_id=lesson_id
    )

    db.add(flashcard)
    db.commit()
    db.refresh(flashcard)

    return flashcard
