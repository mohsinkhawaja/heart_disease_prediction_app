import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../viewmodel/reset_password_viewmodel.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/auth_button.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.put(ResetPasswordViewModel());

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Reset Password',
          style: AppFonts.heading2.copyWith(color: AppColors.whiteColor),
        ),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: viewModel.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                
                // Icon
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.successColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.lock_reset,
                    size: 50,
                    color: AppColors.successColor,
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Title
                Text(
                  'Create New Password',
                  style: AppFonts.heading1.copyWith(
                    color: AppColors.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 8),
                
                // Subtitle
                Text(
                  'Please create a strong new password for your account.',
                  style: AppFonts.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 40),

                // New Password Field
                Obx(() => CustomTextField(
                  controller: viewModel.newPasswordController,
                  label: 'New Password',
                  obscureText: viewModel.obscureNewPassword.value,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: AppColors.primaryColor,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      viewModel.obscureNewPassword.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.primaryColor,
                    ),
                    onPressed: viewModel.toggleNewPasswordVisibility,
                  ),
                  validator: viewModel.validatePassword,
                )),

                // Confirm Password Field
                Obx(() => CustomTextField(
                  controller: viewModel.confirmPasswordController,
                  label: 'Confirm New Password',
                  obscureText: viewModel.obscureConfirmPassword.value,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: AppColors.primaryColor,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      viewModel.obscureConfirmPassword.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.primaryColor,
                    ),
                    onPressed: viewModel.toggleConfirmPasswordVisibility,
                  ),
                  validator: viewModel.validateConfirmPasswordField,
                )),

                const SizedBox(height: 32),

                // Reset Button
                Obx(() => AuthButton(
                  text: 'Reset Password',
                  isLoading: viewModel.isLoading.value,
                  icon: Icons.save,
                  onPressed: viewModel.resetPassword,
                )),

                const SizedBox(height: 24),

                // Password Requirements
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.infoColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.infoColor.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password Requirements:',
                        style: AppFonts.labelText.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '• At least 8 characters long\n'
                        '• Contains at least one letter\n'
                        '• Contains at least one number\n'
                        '• Contains at least one special character (!@#\$%^&*)',
                        style: AppFonts.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}