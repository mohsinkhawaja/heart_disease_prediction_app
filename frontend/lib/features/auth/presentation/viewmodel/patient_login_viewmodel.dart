import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientLoginViewModel extends GetxController {
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

      if (email == 'test@example.com') {
        // Success scenario
        Get.snackbar(
          'Success',
          'Login successful! Welcome back.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Navigate to patient dashboard
        Get.offAllNamed('/patient-home');
      } else if (email == 'blocked@example.com') {
        // Account blocked scenario
        throw Exception(
          'Your account has been temporarily blocked. Please contact support.',
        );
      } else {
        // Invalid credentials scenario
        throw Exception('Invalid email or password. Please try again.');
      }
    } catch (e) {
      // Handle different types of errors
      String errorMessage = 'Login failed. Please try again.';

      if (e.toString().contains('Invalid email or password')) {
        errorMessage =
            'Invalid email or password. Please check your credentials.';
      } else if (e.toString().contains('blocked')) {
        errorMessage = 'Account blocked. Please contact support.';
      } else if (e.toString().contains('network')) {
        errorMessage = 'Network error. Please check your connection.';
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

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
