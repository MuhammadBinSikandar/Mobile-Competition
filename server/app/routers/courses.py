# router/courses.py
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from app.models.course import Course
from app.schemas.course import CourseCreate, CourseOut
from app.models.user import User
from app.services.auth import get_current_user
from app.database import get_db

router = APIRouter(
    prefix="/courses",
    tags=["Courses"]
)

# Create a course
@router.post("/", response_model=CourseOut, status_code=status.HTTP_201_CREATED)
def create_course(
    course: CourseCreate,
    db: Session = Depends(get_db), 
    current_user: User = Depends(get_current_user)
):
    if current_user.role != "tutor":
        raise HTTPException(status_code=403, detail="Only tutors can create courses")

    new_course = Course(
        title=course.title,
        description=course.description,
        tutor_id=current_user.id
    )

    db.add(new_course)
    db.commit()
    db.refresh(new_course)
    return new_course

# List all courses (no longer requires tutor role)
@router.get("/", response_model=list[CourseOut])
def list_courses(db: Session = Depends(get_db)):
    courses = db.query(Course).all()  # Fetch all courses, not filtered by tutor
    return courses
