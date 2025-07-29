// Patient Profile ViewModel
// File: features/patient_profile/presentation/viewmodel/patient_profile_viewmodel.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientProfileViewModel extends GetxController {
  // Controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController bloodGroupController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController emergencyContactController = TextEditingController();
  final TextEditingController allergiesController = TextEditingController();
  final TextEditingController medicationsController = TextEditingController();
  final TextEditingController conditionsController = TextEditingController();
  final TextEditingController surgeriesController = TextEditingController();

  // Observable variables
  final RxBool isLoading = false.obs;
  final RxBool isEditMode = false.obs;
  final RxString fullName = 'John Doe'.obs;
  final RxString email = 'john.doe@example.com'.obs;
  final RxString phoneNumber = '+1 234 567 8900'.obs;
  final RxString dateOfBirth = '15/03/1990'.obs;
  final RxString gender = 'Male'.obs;
  final RxInt age = 34.obs;
  final RxString bloodGroup = 'O+'.obs;
  final RxString height = '175'.obs;
  final RxString weight = '70'.obs;
  final RxString emergencyContact = '+1 234 567 8901'.obs;
  final RxString allergies = 'None'.obs;
  final RxString currentMedications = 'None'.obs;
  final RxString medicalConditions = 'None'.obs;
  final RxString previousSurgeries = 'None'.obs;
  final RxString profileImage = ''.obs;

  // Original values for cancel functionality
  final Map<String, String> _originalValues = {};

  @override
  void onInit() {
    super.onInit();
    loadPatientProfile();
  }

  // Load patient profile data
  Future<void> loadPatientProfile() async {
    try {
      isLoading.value = true;
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Load data (TODO: Replace with actual API call)
      _initializeControllers();
      _storeOriginalValues();
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load profile: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Initialize controllers with current values
  void _initializeControllers() {
    fullNameController.text = fullName.value;
    emailController.text = email.value;
    phoneController.text = phoneNumber.value;
    dobController.text = dateOfBirth.value;
    bloodGroupController.text = bloodGroup.value;
    heightController.text = height.value;
    weightController.text = weight.value;
    emergencyContactController.text = emergencyContact.value;
    allergiesController.text = allergies.value;
    medicationsController.text = currentMedications.value;
    conditionsController.text = medicalConditions.value;
    surgeriesController.text = previousSurgeries.value;
  }

  // Store original values for cancel functionality
  void _storeOriginalValues() {
    _originalValues.clear();
    _originalValues['fullName'] = fullName.value;
    _originalValues['phoneNumber'] = phoneNumber.value;
    _originalValues['dateOfBirth'] = dateOfBirth.value;
    _originalValues['gender'] = gender.value;
    _originalValues['bloodGroup'] = bloodGroup.value;
    _originalValues['height'] = height.value;
    _originalValues['weight'] = weight.value;
    _originalValues['emergencyContact'] = emergencyContact.value;
    _originalValues['allergies'] = allergies.value;
    _originalValues['currentMedications'] = currentMedications.value;
    _originalValues['medicalConditions'] = medicalConditions.value;
    _originalValues['previousSurgeries'] = previousSurgeries.value;
  }

  // Toggle edit mode
  void toggleEditMode() {
    isEditMode.value = true;
    _storeOriginalValues();
  }

  // Cancel edit
  void cancelEdit() {
    isEditMode.value = false;
    _restoreOriginalValues();
    _initializeControllers();
  }

  // Restore original values
  void _restoreOriginalValues() {
    fullName.value = _originalValues['fullName'] ?? '';
    phoneNumber.value = _originalValues['phoneNumber'] ?? '';
    dateOfBirth.value = _originalValues['dateOfBirth'] ?? '';
    gender.value = _originalValues['gender'] ?? '';
    bloodGroup.value = _originalValues['bloodGroup'] ?? '';
    height.value = _originalValues['height'] ?? '';
    weight.value = _originalValues['weight'] ?? '';
    emergencyContact.value = _originalValues['emergencyContact'] ?? '';
    allergies.value = _originalValues['allergies'] ?? '';
    currentMedications.value = _originalValues['currentMedications'] ?? '';
    medicalConditions.value = _originalValues['medicalConditions'] ?? '';
    previousSurgeries.value = _originalValues['previousSurgeries'] ?? '';
  }

  // Save profile
  Future<void> saveProfile() async {
    try {
      // Validate all fields
      if (!_validateAllFields()) {
        return;
      }

      isLoading.value = true;
      
      // Update observable values
      _updateValuesFromControllers();
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // TODO: Replace with actual API call
      
      isEditMode.value = false;
      
      Get.snackbar(
        'Success',
        'Profile updated successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update profile: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Update values from controllers
  void _updateValuesFromControllers() {
    fullName.value = fullNameController.text.trim();
    phoneNumber.value = phoneController.text.trim();
    dateOfBirth.value = dobController.text.trim();
    bloodGroup.value = bloodGroupController.text.trim();
    height.value = heightController.text.trim();
    weight.value = weightController.text.trim();
    emergencyContact.value = emergencyContactController.text.trim();
    allergies.value = allergiesController.text.trim();
    currentMedications.value = medicationsController.text.trim();
    medicalConditions.value = conditionsController.text.trim();
    previousSurgeries.value = surgeriesController.text.trim();
    
    // Calculate age from date of birth
    _calculateAge();
  }

  // Calculate age from date of birth
  void _calculateAge() {
    try {
      final parts = dateOfBirth.value.split('/');
      if (parts.length == 3) {
        final birthday = DateTime(
          int.parse(parts[2]),
          int.parse(parts[1]),
          int.parse(parts[0]),
        );
        final now = DateTime.now();
        int calculatedAge = now.year - birthday.year;
        if (now.month < birthday.month || 
            (now.month == birthday.month && now.day < birthday.day)) {
          calculatedAge--;
        }
        age.value = calculatedAge;
      }
    } catch (e) {
      // Handle parsing error
    }
  }

  // Validate all fields
  bool _validateAllFields() {
    if (validateName(fullNameController.text) != null) {
      Get.snackbar('Validation Error', 'Please enter a valid name',
          backgroundColor: Colors.orange, colorText: Colors.white);
      return false;
    }
    
    if (validatePhone(phoneController.text) != null) {
      Get.snackbar('Validation Error', 'Please enter a valid phone number',
          backgroundColor: Colors.orange, colorText: Colors.white);
      return false;
    }
    
    if (validateHeight(heightController.text) != null) {
      Get.snackbar('Validation Error', 'Please enter a valid height',
          backgroundColor: Colors.orange, colorText: Colors.white);
      return false;
    }
    
    if (validateWeight(weightController.text) != null) {
      Get.snackbar('Validation Error', 'Please enter a valid weight',
          backgroundColor: Colors.orange, colorText: Colors.white);
      return false;
    }
    
    return true;
  }

  // Validation methods
  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    if (value.trim().length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? validateHeight(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Height is required';
    }
    final height = double.tryParse(value.trim());
    if (height == null || height < 50 || height > 300) {
      return 'Please enter a valid height (50-300 cm)';
    }
    return null;
  }

  String? validateWeight(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Weight is required';
    }
    final weight = double.tryParse(value.trim());
    if (weight == null || weight < 20 || weight > 500) {
      return 'Please enter a valid weight (20-500 kg)';
    }
    return null;
  }

  // Update dropdown values
  void updateGender(String? value) {
    if (value != null && isEditMode.value) {
      gender.value = value;
    }
  }

  void updateBloodGroup(String? value) {
    if (value != null && isEditMode.value) {
      bloodGroup.value = value;
      bloodGroupController.text = value;
    }
  }

  // Date selection
  Future<void> selectDate(BuildContext context) async {
    if (!isEditMode.value) return;
    
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _parseDate(dateOfBirth.value) ?? DateTime.now().subtract(const Duration(days: 365 * 25)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    
    if (picked != null) {
      final formattedDate = "${picked.day.toString().padLeft(2, '0')}/"
          "${picked.month.toString().padLeft(2, '0')}/"
          "${picked.year}";
      dobController.text = formattedDate;
      dateOfBirth.value = formattedDate;
      _calculateAge();
    }
  }

  DateTime? _parseDate(String dateString) {
    try {
      final parts = dateString.split('/');
      if (parts.length == 3) {
        return DateTime(
          int.parse(parts[2]),
          int.parse(parts[1]),
          int.parse(parts[0]),
        );
      }
    } catch (e) {
      // Handle parsing error
    }
    return null;
  }

  // Change profile image
  void changeProfileImage() {
    if (!isEditMode.value) return;
    
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Change Profile Picture',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImageOption(
                  'Camera',
                  Icons.camera_alt,
                  () {
                    Get.back();
                    _pickImageFromCamera();
                  },
                ),
                _buildImageOption(
                  'Gallery',
                  Icons.photo_library,
                  () {
                    Get.back();
                    _pickImageFromGallery();
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildImageOption(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.teal[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Colors.teal[600],
              size: 32,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Pick image from camera
  void _pickImageFromCamera() {
    // TODO: Implement camera image picker
    Get.snackbar(
      'Info',
      'Camera functionality will be implemented',
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

  // Pick image from gallery
  void _pickImageFromGallery() {
    // TODO: Implement gallery image picker
    Get.snackbar(
      'Info',
      'Gallery functionality will be implemented',
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

  // Account settings methods
  void changePassword() {
    Get.toNamed('/change-password');
  }

  void openPrivacySettings() {
    Get.toNamed('/privacy-settings');
  }

  void openNotificationSettings() {
    Get.toNamed('/notification-settings');
  }

  void downloadData() {
    Get.dialog(
      AlertDialog(
        title: const Text('Download Data'),
        content: const Text(
          'Your personal data will be prepared and sent to your email address. This may take a few minutes.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              _initiateDataDownload();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal[600],
              foregroundColor: Colors.white,
            ),
            child: const Text('Download'),
          ),
        ],
      ),
    );
  }

  void _initiateDataDownload() {
    Get.snackbar(
      'Download Started',
      'Your data is being prepared and will be sent to your email',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

  // Delete account
  void deleteAccount() {
    Get.dialog(
      AlertDialog(
        title: const Text(
          'Delete Account',
          style: TextStyle(color: Colors.red),
        ),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently removed.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              _confirmDeleteAccount();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteAccount() {
    Get.dialog(
      AlertDialog(
        title: const Text(
          'Final Confirmation',
          style: TextStyle(color: Colors.red),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'This will permanently delete:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('• Your profile and medical history'),
            const Text('• All uploaded health data and reports'),
            const Text('• Consultation history and feedback'),
            const Text('• Account settings and preferences'),
            const SizedBox(height: 16),
            const Text(
              'Type "DELETE" to confirm:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              onChanged: (value) {
                // Handle confirmation text
              },
              decoration: const InputDecoration(
                hintText: 'Type DELETE here',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              _performAccountDeletion();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete Forever'),
          ),
        ],
      ),
    );
  }

  void _performAccountDeletion() async {
    try {
      isLoading.value = true;
      
      // Simulate API call for account deletion
      await Future.delayed(const Duration(seconds: 3));
      
      Get.snackbar(
        'Account Deleted',
        'Your account has been permanently deleted',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      
      // Navigate to login screen
      Get.offAllNamed('/user-type-selection');
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete account: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();
    bloodGroupController.dispose();
    heightController.dispose();
    weightController.dispose();
    emergencyContactController.dispose();
    allergiesController.dispose();
    medicationsController.dispose();
    conditionsController.dispose();
    surgeriesController.dispose();
    super.onClose();
  }
}