from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from . import Base  # Clean import from the package


class Course(Base):
    __tablename__ = 'courses'

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String)
    description = Column(String)
    tutor_id = Column(Integer, ForeignKey("users.id"))

    tutor = relationship("User", back_populates="courses")
    lessons = relationship("Lesson", back_populates="course", cascade="all, delete")
    enrollments = relationship("Enrollment", back_populates="course")
