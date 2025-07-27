from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
import numpy as np
import tensorflow as tf
import os

router = APIRouter(prefix="/predict", tags=["ECG Prediction"])

# ✅ Get absolute model path
BASE_DIR = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
MODEL_PATH = os.path.join(BASE_DIR, "models", "heartbeat_model", "model.tflite")

# ✅ Load the TFLite model once at startup
interpreter = tf.lite.Interpreter(model_path=MODEL_PATH)
interpreter.allocate_tensors()
input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

# Input schema
class ECGInput(BaseModel):
    ecg_data: list  # Must be 187 floats

@router.post("/")
async def predict_ecg(input_data: ECGInput):
    if len(input_data.ecg_data) != 187:
        raise HTTPException(status_code=400, detail="ECG data must be 187 points long.")

    try:
        ecg_array = np.array(input_data.ecg_data, dtype=np.float32).reshape(1, 187, 1)
        interpreter.set_tensor(input_details[0]['index'], ecg_array)
        interpreter.invoke()

        output_data = interpreter.get_tensor(output_details[0]['index'])
        predicted_class = int(np.argmax(output_data))
        probabilities = output_data.tolist()[0]

        return {
            "predicted_class": predicted_class,
            "class_probabilities": probabilities
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
