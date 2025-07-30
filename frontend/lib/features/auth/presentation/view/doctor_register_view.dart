import 'package:flutter/material.dart';
import 'package:frontend/core/shared_widgets/custom_appbar.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
import '../../../../routes/app_routes.dart';
import '../viewmodel/doctor_register_viewmodel.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/file_upload_field.dart';
import '../../widgets/password_strength_indicator.dart';

class DoctorRegisterView extends StatelessWidget {
  const DoctorRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Get.put(DoctorRegisterViewModel(), tag: 'doctor_register');
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppBar(
        title: "Doctor Registration",
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
                  'Medical Professional Registration',
                  style: AppFonts.heading1.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: screenWidth * 0.06,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Join our network of healthcare professionals',
                  style: AppFonts.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: screenWidth * 0.035,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.04),

                // Personal Information Section
                _buildSectionHeader('Personal Information', screenWidth),
                
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

                CustomTextField(
                  controller: viewModel.phoneController,
                  label: 'Phone Number',
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icon(
                    Icons.phone_outlined,
                    color: AppColors.primaryColor,
                    size: screenWidth * 0.06,
                  ),
                  validator: viewModel.validatePhone,
                ),

                CustomTextField(
                  controller: viewModel.dobController,
                  label: 'Date of Birth',
                  readOnly: true,
                  prefixIcon: Icon(
                    Icons.cake_outlined,
                    color: AppColors.primaryColor,
                    size: screenWidth * 0.06,
                  ),
                  suffixIcon: Icon(
                    Icons.calendar_today,
                    color: AppColors.primaryColor,
                    size: screenWidth * 0.05,
                  ),
                  onTap: () => viewModel.selectDate(context, viewModel.dobController),
                  validator: (value) => value?.isEmpty == true ? 'Date of birth is required' : null,
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
                GetBuilder<DoctorRegisterViewModel>(
                  tag: 'doctor_register',
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

                SizedBox(height: screenHeight * 0.03),

                // Professional Information Section
                _buildSectionHeader('Professional Information', screenWidth),

                CustomTextField(
                  controller: viewModel.licenseNumberController,
                  label: 'Medical License Number',
                  prefixIcon: Icon(
                    Icons.badge_outlined,
                    color: AppColors.primaryColor,
                    size: screenWidth * 0.06,
                  ),
                  validator: viewModel.validateLicenseNumber,
                ),

                CustomTextField(
                  controller: viewModel.licenseAuthorityController,
                  label: 'License Issuing Authority',
                  prefixIcon: Icon(
                    Icons.account_balance_outlined,
                    color: AppColors.primaryColor,
                    size: screenWidth * 0.06,
                  ),
                  validator: (value) => value?.isEmpty == true ? 'Authority is required' : null,
                ),

                CustomTextField(
                  controller: viewModel.licenseExpiryController,
                  label: 'License Expiry Date',
                  readOnly: true,
                  prefixIcon: Icon(
                    Icons.date_range_outlined,
                    color: AppColors.primaryColor,
                    size: screenWidth * 0.06,
                  ),
                  suffixIcon: Icon(
                    Icons.calendar_today,
                    color: AppColors.primaryColor,
                    size: screenWidth * 0.05,
                  ),
                  onTap: () => viewModel.selectDate(context, viewModel.licenseExpiryController, isFutureDate: true),
                  validator: (value) => value?.isEmpty == true ? 'Expiry date is required' : null,
                ),

                CustomTextField(
                  controller: viewModel.specializationController,
                  label: 'Medical Specialization',
                  prefixIcon: Icon(
                    Icons.local_hospital_outlined,
                    color: AppColors.primaryColor,
                    size: screenWidth * 0.06,
                  ),
                  validator: (value) => value?.isEmpty == true ? 'Specialization is required' : null,
                ),

                CustomTextField(
                  controller: viewModel.experienceController,
                  label: 'Years of Experience',
                  keyboardType: TextInputType.number,
                  prefixIcon: Icon(
                    Icons.work_outline,
                    color: AppColors.primaryColor,
                    size: screenWidth * 0.06,
                  ),
                  validator: viewModel.validateExperience,
                ),

                CustomTextField(
                  controller: viewModel.hospitalController,
                  label: 'Hospital/Clinic Name',
                  prefixIcon: Icon(
                    Icons.business_outlined,
                    color: AppColors.primaryColor,
                    size: screenWidth * 0.06,
                  ),
                  validator: (value) => value?.isEmpty == true ? 'Hospital/Clinic is required' : null,
                ),

                CustomTextField(
                  controller: viewModel.workAddressController,
                  label: 'Work Address',
                  maxLines: 3,
                  prefixIcon: Icon(
                    Icons.location_on_outlined,
                    color: AppColors.primaryColor,
                    size: screenWidth * 0.06,
                  ),
                  validator: (value) => value?.isEmpty == true ? 'Work address is required' : null,
                ),

                SizedBox(height: screenHeight * 0.03),

                // Document Upload Section
                _buildSectionHeader('Required Documents', screenWidth),

                FileUploadField(
                  label: 'Medical License Certificate',
                  onFileSelected: (file) => viewModel.setFile('license', file!),
                  isRequired: true,
                ),

                FileUploadField(
                  label: 'Government-issued ID',
                  onFileSelected: (file) => viewModel.setFile('id', file!),
                  isRequired: true,
                ),

                FileUploadField(
                  label: 'Professional Profile Photo',
                  onFileSelected: (file) => viewModel.setFile('photo', file!),
                  imageOnly: true,
                  isRequired: true,
                ),

                FileUploadField(
                  label: 'Digital Signature',
                  onFileSelected: (file) => viewModel.setFile('signature', file!),
                  imageOnly: true,
                  isRequired: true,
                ),

                FileUploadField(
                  label: 'Official Medical Stamp',
                  onFileSelected: (file) => viewModel.setFile('stamp', file!),
                  imageOnly: true,
                  isRequired: true,
                ),

                SizedBox(height: screenHeight * 0.03),

                // Security Section
                _buildSectionHeader('Account Security', screenWidth),

                GetBuilder<DoctorRegisterViewModel>(
                  tag: 'doctor_register',
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
                GetBuilder<DoctorRegisterViewModel>(
                  tag: 'doctor_register',
                  builder: (controller) => PasswordStrengthIndicator(
                    password: controller.passwordController.text,
                  ),
                ),

                GetBuilder<DoctorRegisterViewModel>(
                  tag: 'doctor_register',
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

                SizedBox(height: screenHeight * 0.03),

                // Terms & Conditions
                GetBuilder<DoctorRegisterViewModel>(
                  tag: 'doctor_register',
                  builder: (controller) => CheckboxListTile(
                    title: Text(
                      "I confirm that all information provided is accurate and I agree to the terms and conditions for medical professionals.",
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
                GetBuilder<DoctorRegisterViewModel>(
                  tag: 'doctor_register',
                  builder: (controller) => AuthButton(
                    text: "Submit Registration",
                    isLoading: controller.isLoading.value,
                    icon: Icons.send,
                    onPressed: controller.registerDoctor,
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
                      onTap: () => Get.toNamed(AppRoutes.doctorLogin),
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
                      'Register with Google',
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
                        'Google Registration will be available soon',
                        backgroundColor: AppColors.infoColor,
                        colorText: AppColors.whiteColor,
                      );
                    },
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),

                // Registration Notice
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  decoration: BoxDecoration(
                    color: AppColors.warningColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.warningColor.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: AppColors.warningColor,
                            size: screenWidth * 0.05,
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Text(
                            'Registration Review Process',
                            style: AppFonts.labelText.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                              fontSize: screenWidth * 0.035,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        '• Your registration will be reviewed by our medical verification team\n'
                        '• All documents will be verified for authenticity\n'
                        '• You will receive an email notification once approved\n'
                        '• This process typically takes 2-3 business days',
                        style: AppFonts.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: screenWidth * 0.03,
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
      ),
    );
  }

  Widget _buildSectionHeader(String title, double screenWidth) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.04),
      child: Text(
        title,
        style: AppFonts.heading3.copyWith(
          color: AppColors.primaryColor,
          fontSize: screenWidth * 0.045,
        ),
      ),
    );
  }
}