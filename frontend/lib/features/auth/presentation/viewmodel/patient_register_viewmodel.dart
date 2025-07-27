import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientRegisterViewModel extends GetxController {
  // Form key with unique instance
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  // Controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController medicalHistoryController =
      TextEditingController();

  // Observable variables
  final RxBool obscurePassword = true.obs;
  final RxBool obscureConfirmPassword = true.obs;
  final RxBool isLoading = false.obs;
  final RxString gender = 'Male'.obs;
  final RxBool termsAccepted = false.obs;

  // Methods
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
    update();
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
    update();
  }

  void checkPasswordStrength(String password) {
    // Update password strength logic here
    update();
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    return null;
  }

  String? validateConfirmPasswordField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Age is required';
    }
    final age = int.tryParse(value);
    if (age == null || age < 1 || age > 120) {
      return 'Please enter a valid age (1-120)';
    }
    return null;
  }

  Future<void> registerPatient() async {
    try {
      // Validate form
      if (!_formKey.currentState!.validate()) {
        Get.snackbar(
          'Validation Error',
          'Please check all required fields',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return;
      }

      // Check terms acceptance
      if (!termsAccepted.value) {
        Get.snackbar(
          'Terms Required',
          'Please accept the terms and conditions',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return;
      }

      isLoading.value = true;
      update();

      // Simulate API call
      await Future.delayed(const Duration(seconds: 3));

      // Simulate email check
      final email = emailController.text.trim();
      if (email == 'existing@example.com') {
        throw Exception('EMAIL_EXISTS');
      }

      // Success
      Get.snackbar(
        'Registration Successful',
        'Your account has been created successfully! Please login.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );

      // Navigate to login
      Get.offNamed('/patient-login');
    } catch (e) {
      String errorMessage = 'Registration failed. Please try again.';

      if (e.toString().contains('EMAIL_EXISTS')) {
        errorMessage =
            'This email is already registered. Please use a different email or try logging in.';
      } else if (e.toString().contains('network')) {
        errorMessage =
            'Network error. Please check your connection and try again.';
      }

      Get.snackbar(
        'Registration Failed',
        errorMessage,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    } finally {
      isLoading.value = false;
      update();
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    ageController.dispose();
    medicalHistoryController.dispose();
    super.onClose();
  }
}
