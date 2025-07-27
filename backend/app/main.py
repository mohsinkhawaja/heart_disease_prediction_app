from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.routes import auth  
from app.api import ecg, predict  # ✅ Import the new predict API

app = FastAPI()

# Optional: Allow frontend apps (Flutter) to connect
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # ✅ You can restrict this in production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ✅ Include all routers
app.include_router(auth.router, prefix="/auth", tags=["Auth"])
app.include_router(ecg.router)
app.include_router(predict.router)  # ✅ Register the prediction router

# ✅ Root endpoint for basic health check
@app.get("/")
def root():
    return {"message": "Heart Disease Prediction API is running."}
