import 'package:flutter/material.dart';
import 'package:frontend/routes/app_routes.dart';
import 'package:get/get.dart';

class OtpVerificationViewModel extends GetxController {
  final TextEditingController otpController = TextEditingController();

  late final String userType;
  late final String email;
   final isLoading = false.obs;
  @override
void onInit() {
  super.onInit();

  final args = Get.arguments;

  if (args == null || args['userType'] == null || args['email'] == null) {
    Get.snackbar('Error', 'Missing OTP verification arguments');
    return;
  }

  userType = args['userType'];
  email = args['email'];
}


  void verifyOtp() {
    final otp = otpController.text.trim();

    if (otp.isEmpty || otp.length != 6 || !RegExp(r'^\d{6}$').hasMatch(otp)) {
      Get.snackbar('Invalid OTP', 'Please enter a valid 6-digit OTP');
      return;
    }

    // TODO: Implement actual OTP verification with backend

    Get.snackbar('Success', 'OTP Verified Successfully!');

    // Navigate to Reset Password Screen
    Get.offNamed(AppRoutes.resetPassword, arguments: {
      'userType': userType,
      'email': email,
    });
  }

  void resendOtp() {
    // TODO: Call backend to resend OTP
    Get.snackbar('OTP Resent', 'A new OTP has been sent to $email');
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }
}
