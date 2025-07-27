from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
import os

DATABASE_URL = "postgresql://postgres:admin123@localhost/heart_disease_prediction_db"

engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()

# ✅ THIS FUNCTION MUST EXIST
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
    