import 'package:flutter/material.dart';
import 'package:frontend/core/shared_widgets/custom_appbar.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../../../routes/app_routes.dart';
import '../viewmodel/patient_register_viewmodel.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/password_strength_indicator.dart';

class PatientRegisterView extends StatelessWidget {
  const PatientRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.put(PatientRegisterViewModel(), tag: 'patient_register');
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppBar(
        title: "Patient Registration",
        showBackButton: true,
      ),
      body: SafeArea(
        child: Form(
          key: viewModel.formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(screenWidth * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: screenHeight * 0.025),
                
                // Header
                Text(
                  'Create Patient Account',
                  style: AppFonts.heading1.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: screenWidth * 0.065,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Join our heart health monitoring platform',
                  style: AppFonts.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: screenWidth * 0.035,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.04),

                // Full Name
                CustomTextField(
                  controller: viewModel.fullNameController,
                  label: 'Full Name',
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: AppColors.primaryColor,
                    size: screenWidth * 0.06,
                  ),
                  validator: viewModel.validateName,
                ),

                // Email
                CustomTextField(
                  controller: viewModel.emailController,
                  label: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: AppColors.primaryColor,
                    size: screenWidth * 0.06,
                  ),
                  validator: viewModel.validateEmail,
                ),

                // Password
                GetBuilder<PatientRegisterViewModel>(
                  tag: 'patient_register',
                  builder: (controller) => CustomTextField(
                    controller: controller.passwordController,
                    label: 'Password',
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
                    onChanged: controller.checkPasswordStrength,
                  ),
                ),

                // Password Strength - Only show for registration
                GetBuilder<PatientRegisterViewModel>(
                  tag: 'patient_register',
                  builder: (controller) => PasswordStrengthIndicator(
                    password: controller.passwordController.text,
                  ),
                ),

                // Confirm Password
                GetBuilder<PatientRegisterViewModel>(
                  tag: 'patient_register',
                  builder: (controller) => CustomTextField(
                    controller: controller.confirmPasswordController,
                    label: 'Confirm Password',
                    obscureText: controller.obscureConfirmPassword.value,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: AppColors.primaryColor,
                      size: screenWidth * 0.06,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.obscureConfirmPassword.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.primaryColor,
                        size: screenWidth * 0.06,
                      ),
                      onPressed: controller.toggleConfirmPasswordVisibility,
                    ),
                    validator: controller.validateConfirmPasswordField,
                  ),
                ),

                // Age
                CustomTextField(
                  controller: viewModel.ageController,
                  label: 'Age',
                  keyboardType: TextInputType.number,
                  prefixIcon: Icon(
                    Icons.cake_outlined,
                    color: AppColors.primaryColor,
                    size: screenWidth * 0.06,
                  ),
                  validator: viewModel.validateAge,
                ),

                // Gender Selection
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Gender',
                  style: AppFonts.labelText.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: screenWidth * 0.035,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                GetBuilder<PatientRegisterViewModel>(
                  tag: 'patient_register',
                  builder: (controller) => Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.borderColor),
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.cardColor,
                    ),
                    child: Row(
                      children: ['Male', 'Female', 'Other'].map((gender) {
                        return Expanded(
                          child: RadioListTile<String>(
                            title: Text(
                              gender,
                              style: AppFonts.bodyMedium.copyWith(
                                fontSize: screenWidth * 0.035,
                              ),
                            ),
                            value: gender,
                            groupValue: controller.gender.value,
                            onChanged: (value) => controller.gender.value = value!,
                            activeColor: AppColors.primaryColor,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                // Medical History
                SizedBox(height: screenHeight * 0.02),
                CustomTextField(
                  controller: viewModel.medicalHistoryController,
                  label: 'Medical History (Optional)',
                  maxLines: 4,
                  prefixIcon: Icon(
                    Icons.medical_information_outlined,
                    color: AppColors.primaryColor,
                    size: screenWidth * 0.06,
                  ),
                  hintText: 'Enter any relevant medical history...',
                ),

                // Terms & Conditions
                SizedBox(height: screenHeight * 0.02),
                GetBuilder<PatientRegisterViewModel>(
                  tag: 'patient_register',
                  builder: (controller) => CheckboxListTile(
                    title: Text(
                      "I agree to the Terms & Conditions and Privacy Policy",
                      style: AppFonts.bodyMedium.copyWith(
                        fontSize: screenWidth * 0.035,
                      ),
                    ),
                    value: controller.termsAccepted.value,
                    onChanged: (value) => controller.termsAccepted.value = value ?? false,
                    activeColor: AppColors.primaryColor,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),

                SizedBox(height: screenHeight * 0.03),

                // Register Button
                GetBuilder<PatientRegisterViewModel>(
                  tag: 'patient_register',
                  builder: (controller) => AuthButton(
                    text: "Create Account",
                    isLoading: controller.isLoading.value,
                    icon: Icons.person_add,
                    onPressed: controller.registerPatient,
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),

                // Login Link - Fixed
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: AppFonts.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: screenWidth * 0.035,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.patientLogin),
                      child: Text(
                        "Sign In",
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

                SizedBox(height: screenHeight * 0.025),
              ],
            ),
          ),
        ),
      ),
    );
  }
}