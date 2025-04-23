#models/user.py
from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship
from enrollments import Enrollment  # Import the Enrollment model
from . import Base  # Clean import from the package

class User(Base):
    __tablename__ = 'users'

    id = Column(Integer, primary_key=True, index=True)
    first_name = Column(String)
    last_name = Column(String)
    username = Column(String, unique=True, index=True)
    email = Column(String, unique=True, index=True)
    password_hash = Column(String)
    role = Column(String, default='student')  # 'tutor' or 'student'


    courses = relationship("Course", back_populates="tutor")
    enrollments = relationship(Enrollment, back_populates="user")
