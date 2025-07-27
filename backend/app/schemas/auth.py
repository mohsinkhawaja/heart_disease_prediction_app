from pydantic import BaseModel, EmailStr
from typing import Literal

class UserRegister(BaseModel):
    email: EmailStr
    password: str
    full_name: str
    role: Literal["admin", "doctor", "patient"]

class UserLogin(BaseModel):
    email: EmailStr
    password: str

class Token(BaseModel):
    access_token: str
    token_type: str
