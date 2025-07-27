from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.schemas.auth import UserRegister, UserLogin, Token
from app.services import auth_service
from app.core.database import get_db
from app.core.deps import get_current_user, require_role
from app.models.user import User

# router = APIRouter(prefix="/auth", tags=["Authentication"])
router = APIRouter(tags=["Authentication"])

@router.post("/register", response_model=dict)
def register(user: UserRegister, db: Session = Depends(get_db)):
    created_user = auth_service.register_user(user, db)
    return {"message": f"{created_user.role.capitalize()} registered successfully!"}

@router.post("/login", response_model=Token)
def login(user: UserLogin, db: Session = Depends(get_db)):
    db_user = auth_service.authenticate_user(user.email, user.password, db)
    return auth_service.generate_token(db_user)

@router.get("/me", response_model=dict)
def get_me(user: User = Depends(get_current_user)):
    return {"email": user.email, "role": user.role}

@router.get("/only-admin")
def admin_route(user: User = Depends(require_role("admin"))):
    return {"message": f"Hello Admin {user.full_name}"}

@router.get("/only-doctor")
def doctor_route(user: User = Depends(require_role("doctor"))):
    return {"message": f"Hello Doctor {user.full_name}"}

@router.get("/only-patient")
def patient_route(user: User = Depends(require_role("patient"))):
    return {"message": f"Hello Patient {user.full_name}"}
