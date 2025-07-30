import 'package:flutter/material.dart';
import 'package:frontend/core/shared_widgets/custom_appbar.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../../../routes/app_routes.dart';
import '../viewmodel/doctor_login_viewmodel.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/auth_button.dart';

class DoctorLoginView extends StatelessWidget {
  const DoctorLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.put(DoctorLoginViewModel(), tag: 'doctor_login');
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppBar(
        title: "Doctor Login",
        showBackButton: true,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(screenWidth * 0.06),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - (screenWidth * 0.12),
                ),
                child: Form(
                  key: viewModel.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.025),
                      
                      // Welcome Section
                      Text(
                        'Welcome Doctor!',
                        style: AppFonts.heading1.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: screenWidth * 0.07,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        'Login to your medical dashboard',
                        style: AppFonts.bodyLarge.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: screenWidth * 0.04,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * 0.04),

                      // Email Field
                      CustomTextField(
                        controller: viewModel.emailController,
                        label: "Email Address",
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: AppColors.primaryColor,
                          size: screenWidth * 0.06,
                        ),
                        validator: viewModel.validateEmail,
                      ),

                      // Password Field
                      GetBuilder<DoctorLoginViewModel>(
                        tag: 'doctor_login',
                        builder: (controller) => CustomTextField(
                          controller: controller.passwordController,
                          label: "Password",
                          obscureText: controller.obscurePassword.value,
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: AppColors.primaryColor,
                            size: screenWidth * 0.06,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.obscurePassword.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: AppColors.primaryColor,
                              size: screenWidth * 0.06,
                            ),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                          validator: controller.validatePassword,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.035),

                      // Login Button
                      GetBuilder<DoctorLoginViewModel>(
                        tag: 'doctor_login',
                        builder: (controller) => AuthButton(
                          text: "Login",
                          isLoading: controller.isLoading.value,
                          icon: Icons.medical_services,
                          onPressed: controller.login,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      // Forgot Password
                      TextButton(
                        onPressed: () => Get.toNamed(AppRoutes.forgotPassword),
                        child: Text(
                          'Forgot Password?',
                          style: AppFonts.bodyMedium.copyWith(
                            color: AppColors.primaryColor,
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                      ),

                      // Register Link - Fixed
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: AppFonts.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: screenWidth * 0.035,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.toNamed(AppRoutes.doctorRegister),
                            child: Text(
                              "Register",
                              style: AppFonts.bodyMedium.copyWith(
                                color: AppColors.secondaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: screenWidth * 0.035,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.02),
                      Divider(
                        color: AppColors.borderColor,
                        height: screenHeight * 0.04,
                      ),

                      // Google Sign In
                      SizedBox(
                        height: screenHeight * 0.06,
                        child: OutlinedButton.icon(
                          icon: Image.asset(
                            'assets/images/google_logo.png',
                            height: screenWidth * 0.06,
                            errorBuilder: (context, error, stackTrace) =>
                                Icon(
                                  Icons.g_mobiledata,
                                  size: screenWidth * 0.06,
                                ),
                          ),
                          label: Text(
                            'Sign in with Google',
                            style: AppFonts.buttonText.copyWith(
                              color: AppColors.textPrimary,
                              fontSize: screenWidth * 0.035,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.textPrimary,
                            side: const BorderSide(color: AppColors.borderColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: AppColors.whiteColor,
                          ),
                          onPressed: () {
                            Get.snackbar(
                              'Coming Soon',
                              'Google Sign-In will be available soon',
                              backgroundColor: AppColors.infoColor,
                              colorText: AppColors.whiteColor,
                            );
                          },
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      // Professional Notice
                      Container(
                        padding: EdgeInsets.all(screenWidth * 0.04),
                        decoration: BoxDecoration(
                          color: AppColors.infoColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.infoColor.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: AppColors.infoColor,
                              size: screenWidth * 0.05,
                            ),
                            SizedBox(width: screenWidth * 0.03),
                            Expanded(
                              child: Text(
                                'Doctor accounts require admin approval before activation',
                                style: AppFonts.bodySmall.copyWith(
                                  color: AppColors.textPrimary,
                                  fontSize: screenWidth * 0.03,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: screenHeight * 0.025),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}