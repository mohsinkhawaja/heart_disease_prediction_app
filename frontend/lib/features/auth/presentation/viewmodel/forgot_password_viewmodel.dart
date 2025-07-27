import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import 'base_auth_viewmodel.dart';

class ForgotPasswordViewModel extends BaseAuthViewModel {
  final TextEditingController emailController = TextEditingController();

  Future<void> sendOTP() async {
    final email = emailController.text.trim();
    
    if (validateEmail(email) != null) {
      handleError('Please enter a valid email address');
      return;
    }

    showLoading();

    try {
      final success = await authRepository.sendOTP(email);
      
      if (success) {
        handleSuccess('OTP sent successfully!');
        Get.toNamed(
          AppRoutes.otpVerification,
          arguments: {
            'email': email,
            'purpose': 'password_reset',
          },
        );
      } else {
        handleError('Failed to send OTP. Please try again.');
      }
    } catch (e) {
      handleError('Error: ${e.toString()}');
    } finally {
      hideLoading();
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}