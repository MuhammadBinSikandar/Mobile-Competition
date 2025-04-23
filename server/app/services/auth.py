#servcies/auth.py
from passlib.context import CryptContext
import jwt  # PyJWT
from datetime import datetime, timedelta, timezone
from typing import Optional
from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from sqlalchemy.orm import Session
from app.database import get_db
from app.models.user import User

# Password hashing context
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# JWT configuration
SECRET_KEY = "loyalty"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30

# OAuth2 scheme to extract bearer token
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/auth/login")

# Hash password
def hash_password(password: str) -> str:
    return pwd_context.hash(password)

# Verify password
def verify_password(plain_password: str, hashed_password: str) -> bool:
    return pwd_context.verify(plain_password, hashed_password)

# Create JWT token
def create_access_token(data: dict, expires_delta: Optional[timedelta] = None) -> str:
    to_encode = data.copy()
    expire = datetime.now(timezone.utc) + (expires_delta or timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES))
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

# Decode JWT token
def decode_access_token(token: str):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        print(f"Decoded payload: {payload}")  # Debugging line
        return payload
    except jwt.ExpiredSignatureError:
        print("Token expired")  # Debugging line
        return None
    except jwt.InvalidTokenError:
        print("Invalid token")  # Debugging line
        return None

# ✅ Get current user with optional role validation
def get_current_user(
    db: Session = Depends(get_db),
    token: str = Depends(oauth2_scheme),
    required_role: Optional[str] = None
) -> User:
    payload = decode_access_token(token)
    if payload is None:
        raise HTTPException(status_code=401, detail="Invalid or expired token")

    user = db.query(User).filter(User.email == payload.get("sub")).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    if required_role and user.role != required_role:
        raise HTTPException(status_code=403, detail="You are not authorized to access this resource")

    return user


# Function to handle logout
# Since JWT is stateless, logout is handled client-side (token removal)
# We just send a 200 OK response
def logout_user():
    # No server-side action is necessary for logout with JWT.
    # Instruct the client to remove the token.
    return {"msg": "Successfully logged out. Please remove the token from the client."}
