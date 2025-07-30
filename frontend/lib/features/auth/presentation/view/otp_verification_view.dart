import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../viewmodel/otp_verification_viewmodel.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/auth_button.dart';

class OtpVerificationView extends StatelessWidget {
  const OtpVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.put(OtpVerificationViewModel());

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Verify OTP',
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
                  Icons.verified_user,
                  size: 50,
                  color: AppColors.primaryColor,
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Title
              Text(
                'Verification Code',
                style: AppFonts.heading1.copyWith(
                  color: AppColors.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 8),
              
              // Subtitle
              Obx(() => Text(
                'We\'ve sent a 6-digit verification code to\n${viewModel.email}',
                style: AppFonts.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              )),
              
              const SizedBox(height: 40),

              // OTP Field
              CustomTextField(
                controller: viewModel.otpController,
                label: 'Verification Code',
                keyboardType: TextInputType.number,
                maxLength: 6,
                prefixIcon: const Icon(
                  Icons.security,
                  color: AppColors.primaryColor,
                ),
                hintText: 'Enter 6-digit code',
                validator: (value) {
                  if (value?.isEmpty == true) return 'OTP is required';
                  if (value!.length != 6) return 'OTP must be 6 digits';
                  return null;
                },
              ),

              const SizedBox(height: 32),

              // Verify Button
              Obx(() => AuthButton(
                text: 'Verify Code',
                isLoading: viewModel.isLoading.value,
                icon: Icons.check_circle,
                onPressed: viewModel.verifyOtp,
              )),

              const SizedBox(height: 24),

              // Resend OTP
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive the code? ",
                    style: AppFonts.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  TextButton(
                    onPressed: viewModel.resendOtp,
                    child: Text(
                      'Resend',
                      style: AppFonts.bodyMedium.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Back Button
              TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  'Back',
                  style: AppFonts.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
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