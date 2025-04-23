from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

# Import all models to make them discoverable for Alembic and SQLAlchemy
from .user import User
from .course import Course
