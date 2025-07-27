from fastapi import APIRouter, UploadFile, File, Depends, HTTPException
from sqlalchemy.orm import Session
import shutil, os
from app.core.database import get_db, Base
from app.models.ecg_record import ECGRecord
from app.core.deps import get_current_user
from app.models.user import User
from datetime import datetime

router = APIRouter(prefix="/ecg", tags=["ECG"])

UPLOAD_DIR = "ecg_images"
os.makedirs(UPLOAD_DIR, exist_ok=True)

@router.post("/upload")
async def upload_ecg_image(
    file: UploadFile = File(...),
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    filename = f"{datetime.utcnow().timestamp()}_{file.filename}"
    file_path = os.path.join(UPLOAD_DIR, filename)

    with open(file_path, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)

    # Create DB record
    ecg_record = ECGRecord(
        user_id=current_user.id,
        image_path=file_path,
        created_at=datetime.utcnow(),
        reviewed_by_doctor=False
    )
    db.add(ecg_record)
    db.commit()
    db.refresh(ecg_record)

    return {"msg": "ECG image uploaded successfully", "ecg_id": ecg_record.id}
