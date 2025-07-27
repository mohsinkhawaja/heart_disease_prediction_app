import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorLoginViewModel extends GetxController {
  // Form key with unique instance
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Observable variables
  final RxBool obscurePassword = true.obs;
  final RxBool isLoading = false.obs;

  // Methods
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
    update();
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
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  Future<void> login() async {
    try {
      // Validate form first
      if (!_formKey.currentState!.validate()) {
        Get.snackbar(
          'Validation Error',
          'Please check your inputs',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return;
      }

      isLoading.value = true;
      update();

      // Simulate API call with proper error handling
      await Future.delayed(const Duration(seconds: 2));

      // Simulate different scenarios for testing
      final email = emailController.text.trim();

      if (email == 'doctor@hospital.com') {
        // Success scenario - approved doctor
        Get.snackbar(
          'Success',
          'Login successful! Welcome Doctor.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Navigate to doctor dashboard
        // Get.offAllNamed('/doctor-dashboard');
      } else if (email == 'pending.doctor@hospital.com') {
        // Account pending approval scenario
        throw Exception('ACCOUNT_PENDING');
      } else if (email == 'blocked.doctor@hospital.com') {
        // Account blocked scenario
        throw Exception('ACCOUNT_BLOCKED');
      } else if (email == 'suspended.doctor@hospital.com') {
        // Account suspended scenario
        throw Exception('ACCOUNT_SUSPENDED');
      } else {
        // Invalid credentials scenario
        throw Exception('INVALID_CREDENTIALS');
      }
    } catch (e) {
      // Handle different types of errors
      String errorMessage = 'Login failed. Please try again.';

      if (e.toString().contains('INVALID_CREDENTIALS')) {
        errorMessage =
            'Invalid email or password. Please check your credentials.';
      } else if (e.toString().contains('ACCOUNT_PENDING')) {
        errorMessage =
            'Your doctor account is pending approval. Please wait for admin verification.';
      } else if (e.toString().contains('ACCOUNT_BLOCKED')) {
        errorMessage =
            'Your account has been blocked. Please contact support for assistance.';
      } else if (e.toString().contains('ACCOUNT_SUSPENDED')) {
        errorMessage =
            'Your account has been suspended. Please contact administration.';
      } else if (e.toString().contains('network')) {
        errorMessage =
            'Network error. Please check your connection and try again.';
      } else if (e.toString().contains('timeout')) {
        errorMessage = 'Request timeout. Please try again.';
      }

      Get.snackbar(
        'Login Failed',
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

  // Method to handle forgot password
  Future<void> forgotPassword() async {
    if (emailController.text.trim().isEmpty) {
      Get.snackbar(
        'Email Required',
        'Please enter your email address first',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    if (!GetUtils.isEmail(emailController.text.trim())) {
      Get.snackbar(
        'Invalid Email',
        'Please enter a valid email address',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;
      update();

      // Simulate API call for password reset
      await Future.delayed(const Duration(seconds: 2));

      Get.snackbar(
        'Password Reset',
        'Password reset instructions have been sent to your email.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    } catch (e) {
      Get.snackbar(
        'Reset Failed',
        'Failed to send password reset email. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
      update();
    }
  }

  // Method to clear form
  void clearForm() {
    emailController.clear();
    passwordController.clear();
    obscurePassword.value = true;
    update();
  }

  // Method to navigate to registration
  void navigateToRegister() {
    Get.toNamed('/doctor-register');
  }

  // Method to navigate back
  void navigateBack() {
    Get.back();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
