import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import 'base_auth_viewmodel.dart';

class ResetPasswordViewModel extends BaseAuthViewModel {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final RxBool obscureNewPassword = true.obs;
  final RxBool obscureConfirmPassword = true.obs;

  late final String email;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>?;
    if (args == null || args['email'] == null) {
      handleError('Invalid reset data');
      Get.back();
      return;
    }

    email = args['email'];
  }

  String? validateConfirmPasswordField(String? value) {
    return validateConfirmPassword(value, newPasswordController.text);
  }

  void toggleNewPasswordVisibility() {
    obscureNewPassword.value = !obscureNewPassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  Future<void> resetPassword() async {
    if (!formKey.currentState!.validate()) return;

    showLoading();

    try {
      final success = await authRepository.resetPassword(
        email,
        newPasswordController.text,
      );

      if (success) {
        handleSuccess('Password reset successfully!');

        // Navigate back to user type selection
        Get.offAllNamed(AppRoutes.userTypeSelection);
      } else {
        handleError('Failed to reset password');
      }
    } catch (e) {
      handleError('Error: ${e.toString()}');
    } finally {
      hideLoading();
    }
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
