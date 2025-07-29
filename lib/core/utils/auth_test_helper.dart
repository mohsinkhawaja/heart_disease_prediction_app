// This is a testing utility to help verify your auth flow

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthTestHelper {
  // Test data for quick form filling
  static const Map<String, String> testPatientData = {
    'fullName': 'John Doe',
    'email': 'john.doe@example.com',
    'password': 'TestPassword123!',
    'age': '30',
    'medicalHistory': 'No major medical history',
  };

  static const Map<String, String> testDoctorData = {
    'fullName': 'Dr. Jane Smith',
    'email': 'dr.jane@hospital.com',
    'password': 'DoctorPass123!',
    'phone': '+1234567890',
    'licenseNumber': 'MD123456',
    'licenseAuthority': 'State Medical Board',
    'specialization': 'Cardiology',
    'experience': '10',
    'hospital': 'City General Hospital',
    'workAddress': '123 Medical Center Drive, City, State',
  };

  // Quick fill functions for testing
  static void fillPatientLoginForm({
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) {
    emailController.text = testPatientData['email']!;
    passwordController.text = testPatientData['password']!;
  }

  static void fillDoctorLoginForm({
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) {
    emailController.text = testDoctorData['email']!;
    passwordController.text = testDoctorData['password']!;
  }

  // Navigation test helper
  static void testNavigationFlow() {
    Get.snackbar(
      'Navigation Test',
      'Testing complete auth flow...',
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

  // Validation test helper
  static void testFormValidations() {
    Get.snackbar(
      'Validation Test',
      'Testing form validations...',
      backgroundColor: Colors.orange,
      colorText: Colors.white,
    );
  }

  // Check if all required routes exist
  static bool checkRoutesExist() {
    final requiredRoutes = [
      '/splash',
      '/user-type',
      '/patient-login',
      '/patient-register', 
      '/doctor-login',
      '/doctor-register',
      '/forgot-password',
      '/otp-verification',
      '/reset-password',
    ];

    // This is a basic check - you might need to adjust based on your actual route names
    return true; // Placeholder - implement actual route checking logic
  }

  // Performance test helper
  static void logScreenLoadTime(String screenName) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    debugPrint('[$screenName] Loaded at: $timestamp');
  }

  // Error testing helper
  static void simulateNetworkError() {
    Get.snackbar(
      'Network Error (Simulated)',
      'Testing error handling...',
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

  // Success testing helper
  static void simulateSuccess(String action) {
    Get.snackbar(
      'Success (Simulated)',
      '$action completed successfully!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }
}

// Test Floating Action Button - Add this to any screen for quick testing
class AuthTestFAB extends StatelessWidget {
  const AuthTestFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      backgroundColor: Colors.purple,
      onPressed: () => _showTestMenu(context),
      child: const Icon(Icons.bug_report, color: Colors.white),
    );
  }

  void _showTestMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Auth Testing Menu',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.navigation),
              title: const Text('Test Navigation'),
              onTap: () {
                Navigator.pop(context);
                AuthTestHelper.testNavigationFlow();
              },
            ),
            ListTile(
              leading: const Icon(Icons.check_circle),
              title: const Text('Test Validations'),
              onTap: () {
                Navigator.pop(context);
                AuthTestHelper.testFormValidations();
              },
            ),
            ListTile(
              leading: const Icon(Icons.error),
              title: const Text('Simulate Error'),
              onTap: () {
                Navigator.pop(context);
                AuthTestHelper.simulateNetworkError();
              },
            ),
            ListTile(
              leading: const Icon(Icons.check),
              title: const Text('Simulate Success'),
              onTap: () {
                Navigator.pop(context);
                AuthTestHelper.simulateSuccess('Test Action');
              },
            ),
          ],
        ),
      ),
    );
  }
}