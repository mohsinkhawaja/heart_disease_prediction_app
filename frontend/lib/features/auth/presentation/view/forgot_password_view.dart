import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../viewmodel/forgot_password_viewmodel.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/auth_button.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.put(ForgotPasswordViewModel());

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Forgot Password',
          style: AppFonts.heading2.copyWith(color: AppColors.whiteColor),
        ),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              
              // Icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.lock_reset,
                  size: 50,
                  color: AppColors.primaryColor,
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Title
              Text(
                'Forgot your password?',
                style: AppFonts.heading1.copyWith(
                  color: AppColors.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 8),
              
              // Subtitle
              Text(
                'No worries! Enter your email address and we\'ll send you a verification code to reset your password.',
                style: AppFonts.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 40),

              // Email Field
              CustomTextField(
                controller: viewModel.emailController,
                label: 'Email Address',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: AppColors.primaryColor,
                ),
                validator: viewModel.validateEmail,
                hintText: 'Enter your registered email',
              ),

              const SizedBox(height: 32),

              // Send OTP Button
              Obx(() => AuthButton(
                text: 'Send Verification Code',
                isLoading: viewModel.isLoading.value,
                icon: Icons.send,
                onPressed: viewModel.sendOTP,
              )),

              const SizedBox(height: 24),

              // Back to Login
              TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  'Back to Login',
                  style: AppFonts.bodyMedium.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}