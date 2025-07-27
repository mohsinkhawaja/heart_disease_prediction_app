import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorRegisterViewModel extends GetxController {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;
  
  // Controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController licenseNumberController = TextEditingController();
  final TextEditingController licenseAuthorityController = TextEditingController();
  final TextEditingController licenseExpiryController = TextEditingController();
  final TextEditingController specializationController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController hospitalController = TextEditingController();
  final TextEditingController workAddressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  
  // Observable variables
  final RxBool obscurePassword = true.obs;
  final RxBool obscureConfirmPassword = true.obs;
  final RxBool isLoading = false.obs;
  final RxString gender = 'Male'.obs;
  final RxBool termsAccepted = false.obs;
  final RxMap<String, dynamic> uploadedFiles = <String, dynamic>{}.obs;
  
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
    update();
  }
  
  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
    update();
  }
  
  void checkPasswordStrength(String password) {
    update();
  }
  
  void setFile(String key, dynamic file) {
    uploadedFiles[key] = file;
    update();
  }
  
  Future<void> selectDate(BuildContext context, TextEditingController controller, {bool isFutureDate = false}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isFutureDate ? DateTime.now().add(const Duration(days: 365)) : DateTime.now(),
      firstDate: isFutureDate ? DateTime.now() : DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = "${picked.day}/${picked.month}/${picked.year}";
      update();
    }
  }
  
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
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
  
  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (value.length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
  
  String? validateLicenseNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'License number is required';
    }
    if (value.length < 5) {
      return 'Please enter a valid license number';
    }
    return null;
  }
  
  String? validateExperience(String? value) {
    if (value == null || value.isEmpty) {
      return 'Experience is required';
    }
    final exp = int.tryParse(value);
    if (exp == null || exp < 0 || exp > 50) {
      return 'Please enter valid years of experience (0-50)';
    }
    return null;
  }
  
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    return null;
  }
  
  String? validateConfirmPasswordField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
  
  Future<void> registerDoctor() async {
    try {
      if (!_formKey.currentState!.validate()) {
        Get.snackbar(
          'Validation Error',
          'Please check all required fields',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return;
      }
      
      if (!termsAccepted.value) {
        Get.snackbar(
          'Terms Required',
          'Please accept the terms and conditions',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return;
      }
      
      // Check required documents
      final requiredDocs = ['license', 'id', 'photo', 'signature', 'stamp'];
      for (String doc in requiredDocs) {
        if (!uploadedFiles.containsKey(doc)) {
          Get.snackbar(
            'Documents Required',
            'Please upload all required documents',
            backgroundColor: Colors.orange,
            colorText: Colors.white,
          );
          return;
        }
      }
      
      isLoading.value = true;
      update();
      
      await Future.delayed(const Duration(seconds: 4));
      
      final email = emailController.text.trim();
      if (email == 'existing.doctor@hospital.com') {
        throw Exception('EMAIL_EXISTS');
      }
      
      Get.snackbar(
        'Registration Submitted',
        'Your registration has been submitted for review. You will receive an email notification once approved.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
      
      Get.offNamed('/doctor-login');
      
    } catch (e) {
      String errorMessage = 'Registration failed. Please try again.';
      
      if (e.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email is already registered. Please use a different email or try logging in.';
      } else if (e.toString().contains('network')) {
        errorMessage = 'Network error. Please check your connection and try again.';
      }
      
      Get.snackbar(
        'Registration Failed',
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
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();
    licenseNumberController.dispose();
    licenseAuthorityController.dispose();
    licenseExpiryController.dispose();
    specializationController.dispose();
    experienceController.dispose();
    hospitalController.dispose();
    workAddressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}