from sqlalchemy.orm import Session
from fastapi import HTTPException, status
from app.models.user import User
from app.schemas.auth import UserRegister
from app.core.security import get_password_hash, verify_password, create_access_token
from datetime import datetime, timedelta
from jose import jwt
from app.core.config import settings

# Checks if the email is already taken
# Hashes the password using get_password_hash
# Creates and saves a new user
def register_user(user_data: UserRegister, db: Session):
    existing = db.query(User).filter(User.email == user_data.email).first()
    if existing:
        raise HTTPException(status_code=400, detail="Email already registered")

    new_user = User(
        email=user_data.email,
        full_name=user_data.full_name,
        role=user_data.role,
        hashed_password=get_password_hash(user_data.password),
    )
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    return new_user
# Fetches the user by email
# Verifies the password
def authenticate_user(email: str, password: str, db: Session):
    user = db.query(User).filter(User.email == email).first()
    if not user or not verify_password(password, user.hashed_password):
        raise HTTPException(status_code=401, detail="Invalid credentials")
    return user
# Generates a JWT with user's email and role
# def generate_token(user: User):
#     token = create_access_token(data={"sub": user.email, "role": user.role})
#     return {"access_token": token, "token_type": "bearer"}
def generate_token(user):
    expire = datetime.utcnow() + timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
    payload = {
        "sub": str(user.id),  # 👈 store user.id not email
        "role": user.role,
        "exp": expire
    }
    token = jwt.encode(payload, settings.SECRET_KEY, algorithm=settings.ALGORITHM)
    return {"access_token": token, "token_type": "bearer"}