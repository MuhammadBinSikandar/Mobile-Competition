# schemas/flashcard.py
from pydantic import BaseModel

class FlashcardCreate(BaseModel):
    question: str
    answer: str

class FlashcardOut(BaseModel):
    id: int
    question: str
    answer: str

    class Config:
        orm_mode = True
