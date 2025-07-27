from sqlalchemy import Column, Integer, String, Enum
from app.core.database import Base
import enum
from sqlalchemy.orm import relationship
from app.models.base import Base

class UserRole(str, enum.Enum):
    patient = "patient"
    doctor = "doctor"
    admin = "admin"

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    full_name = Column(String, nullable=False)
    email = Column(String, unique=True, index=True, nullable=False)
    hashed_password = Column(String, nullable=False)
    role = Column(Enum(UserRole), default="patient", nullable=False)
ecg_records = relationship("ECGRecord", back_populates="user")
