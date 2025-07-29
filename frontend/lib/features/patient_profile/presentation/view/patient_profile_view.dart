import 'package:flutter/material.dart';
import 'package:frontend/features/patient_profile/presentation/viewmodel/patient_profile_viewmodel.dart';
import 'package:frontend/features/patient_profile/presentation/widgets/profile_field.dart';
import 'package:frontend/features/patient_profile/presentation/widgets/profile_header.dart';
import 'package:get/get.dart';

class PatientProfileView extends GetView<PatientProfileViewModel> {
  const PatientProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal[600],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        actions: [
          Obx(
            () =>
                controller.isEditMode.value
                    ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: controller.cancelEdit,
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextButton(
                          onPressed: controller.saveProfile,
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                    : IconButton(
                      onPressed: controller.toggleEditMode,
                      icon: const Icon(Icons.edit, color: Colors.white),
                    ),
          ),
        ],
      ),
      body: Obx(
        () =>
            controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Profile Header
                      ProfileHeader(
                        name: controller.fullName.value,
                        email: controller.email.value,
                        profileImage: controller.profileImage.value,
                        isEditMode: controller.isEditMode.value,
                        onImageTap: controller.changeProfileImage,
                      ),
                      const SizedBox(height: 24),

                      // Personal Information Section
                      _buildSection('Personal Information', [
                        ProfileField(
                          label: 'Full Name',
                          value: controller.fullName.value,
                          controller: controller.fullNameController,
                          isEditable: controller.isEditMode.value,
                          validator: controller.validateName,
                          icon: Icons.person,
                        ),
                        ProfileField(
                          label: 'Email',
                          value: controller.email.value,
                          controller: controller.emailController,
                          isEditable: false, // Email should not be editable
                          icon: Icons.email,
                        ),
                        ProfileField(
                          label: 'Phone Number',
                          value: controller.phoneNumber.value,
                          controller: controller.phoneController,
                          isEditable: controller.isEditMode.value,
                          validator: controller.validatePhone,
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone,
                        ),
                        ProfileField(
                          label: 'Date of Birth',
                          value: controller.dateOfBirth.value,
                          controller: controller.dobController,
                          isEditable: controller.isEditMode.value,
                          icon: Icons.calendar_today,
                          isDateField: true,
                          onTap:
                              controller.isEditMode.value
                                  ? () => controller.selectDate(context)
                                  : null,
                        ),
                        ProfileField(
                          label: 'Gender',
                          value: controller.gender.value,
                          isEditable: controller.isEditMode.value,
                          icon: Icons.person_outline,
                          isDropdown: true,
                          dropdownItems: const ['Male', 'Female', 'Other'],
                          onDropdownChanged: controller.updateGender,
                        ),
                        ProfileField(
                          label: 'Age',
                          value: '${controller.age.value} years',
                          icon: Icons.cake,
                          isEditable: false, // Auto-calculated from DOB
                        ),
                      ]),

                      const SizedBox(height: 20),

                      // Medical Information Section
                      _buildSection('Medical Information', [
                        ProfileField(
                          label: 'Blood Group',
                          value: controller.bloodGroup.value,
                          controller: controller.bloodGroupController,
                          isEditable: controller.isEditMode.value,
                          icon: Icons.bloodtype,
                          isDropdown: true,
                          dropdownItems: const [
                            'A+',
                            'A-',
                            'B+',
                            'B-',
                            'AB+',
                            'AB-',
                            'O+',
                            'O-',
                          ],
                          onDropdownChanged: controller.updateBloodGroup,
                        ),
                        ProfileField(
                          label: 'Height (cm)',
                          value: controller.height.value,
                          controller: controller.heightController,
                          isEditable: controller.isEditMode.value,
                          validator: controller.validateHeight,
                          icon: Icons.height,
                          keyboardType: TextInputType.number,
                        ),
                        ProfileField(
                          label: 'Weight (kg)',
                          value: controller.weight.value,
                          controller: controller.weightController,
                          isEditable: controller.isEditMode.value,
                          validator: controller.validateWeight,
                          icon: Icons.monitor_weight,
                          keyboardType: TextInputType.number,
                        ),
                        ProfileField(
                          label: 'Emergency Contact',
                          value: controller.emergencyContact.value,
                          controller: controller.emergencyContactController,
                          isEditable: controller.isEditMode.value,
                          validator: controller.validatePhone,
                          icon: Icons.emergency,
                          keyboardType: TextInputType.phone,
                        ),
                      ]),

                      const SizedBox(height: 20),

                      // Medical History Section
                      _buildSection('Medical History', [
                        ProfileField(
                          label: 'Allergies',
                          value: controller.allergies.value,
                          controller: controller.allergiesController,
                          isEditable: controller.isEditMode.value,
                          icon: Icons.warning,
                          maxLines: 3,
                        ),
                        ProfileField(
                          label: 'Current Medications',
                          value: controller.currentMedications.value,
                          controller: controller.medicationsController,
                          isEditable: controller.isEditMode.value,
                          icon: Icons.medication,
                          maxLines: 3,
                        ),
                        ProfileField(
                          label: 'Medical Conditions',
                          value: controller.medicalConditions.value,
                          controller: controller.conditionsController,
                          isEditable: controller.isEditMode.value,
                          icon: Icons.medical_services,
                          maxLines: 4,
                        ),
                        ProfileField(
                          label: 'Previous Surgeries',
                          value: controller.previousSurgeries.value,
                          controller: controller.surgeriesController,
                          isEditable: controller.isEditMode.value,
                          icon: Icons.local_hospital,
                          maxLines: 3,
                        ),
                      ]),

                      const SizedBox(height: 20),

                      // Account Settings Section
                      if (!controller.isEditMode.value) ...[
                        _buildSection('Account Settings', [
                          _buildActionTile(
                            'Change Password',
                            Icons.lock,
                            () => controller.changePassword(),
                          ),
                          _buildActionTile(
                            'Privacy Settings',
                            Icons.privacy_tip,
                            () => controller.openPrivacySettings(),
                          ),
                          _buildActionTile(
                            'Notification Settings',
                            Icons.notifications,
                            () => controller.openNotificationSettings(),
                          ),
                          _buildActionTile(
                            'Download My Data',
                            Icons.download,
                            () => controller.downloadData(),
                          ),
                        ]),
                        const SizedBox(height: 20),
                      ],

                      // Delete Account Button (only when not in edit mode)
                      if (!controller.isEditMode.value) ...[
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Danger Zone',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              const SizedBox(height: 12),
                              OutlinedButton.icon(
                                onPressed: controller.deleteAccount,
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.red,
                                  side: const BorderSide(color: Colors.red),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                ),
                                icon: const Icon(Icons.delete_forever),
                                label: const Text('Delete Account'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ],
                  ),
                ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildActionTile(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.teal[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.teal[600], size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}
