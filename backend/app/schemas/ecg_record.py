from pydantic import BaseModel
from typing import Optional
from datetime import datetime

class ECGRecordCreate(BaseModel):
    user_id: int

class ECGRecordResponse(BaseModel):
    id: int
    user_id: int
    image_path: str
    prediction: Optional[str]
    confidence: Optional[float]
    reviewed_by_doctor: bool
    doctor_remarks: Optional[str]
    created_at: datetime

    class Config:
        orm_mode = True
