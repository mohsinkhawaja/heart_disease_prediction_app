import numpy as np
import tensorflow as tf

# Load the TFLite model
interpreter = tf.lite.Interpreter(model_path="models/heartbeat_model/model.tflite")
interpreter.allocate_tensors()

# Get input and output tensors
input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

# Print input shape required by the model
print("Model Input Shape:", input_details[0]['shape'])

# Create a dummy test input (replace this with real ECG sample later)
# Shape should be (1, 187, 1) based on your model training
test_input = np.random.rand(1, 187, 1).astype(np.float32)

# Set tensor input
interpreter.set_tensor(input_details[0]['index'], test_input)

# Run inference
interpreter.invoke()

# Get output prediction
output_data = interpreter.get_tensor(output_details[0]['index'])

# Display result
print("Predicted Class Probabilities:", output_data)
predicted_class = np.argmax(output_data)
print("Predicted Class Index:", predicted_class)
