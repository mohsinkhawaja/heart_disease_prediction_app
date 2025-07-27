from sqlalchemy import Column, Integer, String, Float, Boolean, DateTime, ForeignKey
from sqlalchemy.orm import relationship
from datetime import datetime
from .base import Base  # Adjust if you use a different base class
from app.models.base import Base

class ECGRecord(Base):
    __tablename__ = "ecg_records"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"))
    image_path = Column(String, nullable=False)
    prediction = Column(String, nullable=True)
    confidence = Column(Float, nullable=True)
    reviewed_by_doctor = Column(Boolean, default=False)
    doctor_remarks = Column(String, nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow)

    user = relationship("User", back_populates="ecg_records")
