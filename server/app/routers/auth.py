from fastapi import APIRouter, Depends, HTTPException, status, Header
from sqlalchemy.orm import Session
from app.models.user import User
from app.schemas.user import UserCreate, UserLogin, UserOut
from app.services import auth as auth_service
from app.database import get_db
from typing import Optional

router = APIRouter(
    prefix="/auth",
    tags=["Authentication"]
)

# Register user or tutor
@router.post("/register", response_model=UserOut, status_code=status.HTTP_201_CREATED)
def register_user(user: UserCreate, db: Session = Depends(get_db)):
    # Check if user or tutor already exists
    existing_user = db.query(User).filter(User.email == user.email).first()
    if existing_user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Email is already registered"
        )
    
    existing_username = db.query(User).filter(User.username == user.username).first()
    if existing_username:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Username is already taken"
        )

    # Hash the password and create user
    hashed_password = auth_service.hash_password(user.password)
    
    # Determine role based on email domain or by user input
    role = user.role if user.role in ['student', 'tutor'] else 'student'

    # Create a new user with the provided fields
    new_user = User(
        first_name=user.first_name,
        last_name=user.last_name,
        username=user.username,
        email=user.email,
        password_hash=hashed_password,
        role=role
    )
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    
    return new_user


# Login user or tutor
@router.post("/login", response_model=dict)
def login_user(user: UserLogin, db: Session = Depends(get_db)):
    # Find user by email
    db_user = db.query(User).filter(User.email == user.email).first()
    if not db_user or not auth_service.verify_password(user.password, db_user.password_hash):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid email or password"
        )

    # Create access token
    token = auth_service.create_access_token(data={"sub": db_user.email, "role": db_user.role})
    return {"access_token": token, "token_type": "bearer"}


# Get current user
@router.get("/me", response_model=UserOut)
async def get_current_user_info(current_user: User = Depends(auth_service.get_current_user)):
    if not current_user:
        raise HTTPException(status_code=401, detail="Not authenticated")
    return current_user


# Logout user (removes the token on the client side)
@router.post("/logout")
def logout():
    return auth_service.logout_user()
