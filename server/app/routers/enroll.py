# routers/enroll.py
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.models.course import Course
from app.models.user import User
from app.models.enrollments import Enrollment
from app.database import get_db
from app.services.auth import get_current_user
from server.app.schemas.course import CourseOut

router = APIRouter(prefix="/enroll", tags=["Enroll"])

@router.post("/enroll/{course_id}", status_code=201)
def enroll_in_course(
    course_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    # ✅ Ensure user is a student
    if current_user.role != "student":
        raise HTTPException(status_code=403, detail="Only students can enroll in courses")

    # Check if course exists
    course = db.query(Course).filter(Course.id == course_id).first()
    if not course:
        raise HTTPException(status_code=404, detail="Course not found")

    # Check if already enrolled
    existing = db.query(Enrollment).filter_by(course_id=course_id, student_id=current_user.id).first()
    if existing:
        raise HTTPException(status_code=400, detail="Already enrolled")

    # Create new enrollment
    enrollment = Enrollment(course_id=course_id, student_id=current_user.id)
    db.add(enrollment)
    db.commit()
    db.refresh(enrollment)
    return {"msg": "Enrollment successful", "course_id": course_id}

@router.get("/", response_model=list[CourseOut])
def get_enrolled_courses(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    # Fetch all courses the user is enrolled in
    enrollments = db.query(Enrollment).filter(Enrollment.user_id == current_user.id).all()
    
    if not enrollments:
        raise HTTPException(status_code=404, detail="No enrolled courses found")
    
    course_ids = [enrollment.course_id for enrollment in enrollments]
    courses = db.query(Course).filter(Course.id.in_(course_ids)).all()
    
    return courses