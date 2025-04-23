from fastapi import FastAPI
from app.routers import auth, courses,lessons
from app.database import engine
from app import models

# Create tables in the database at startup
models.Base.metadata.create_all(bind=engine)

app = FastAPI()

# Include the authentication routes
app.include_router(auth.router)
app.include_router(courses.router)
app.include_router(lessons.router)
