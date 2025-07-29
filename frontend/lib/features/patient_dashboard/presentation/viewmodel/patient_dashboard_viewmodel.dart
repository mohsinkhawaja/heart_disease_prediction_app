// Patient Dashboard ViewModel
// File: features/patient_dashboard/presentation/viewmodel/patient_dashboard_viewmodel.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientDashboardViewModel extends GetxController {
  // Observable variables
  final RxBool isLoading = false.obs;
  final RxString patientName = 'John Doe'.obs;
  final RxString heartRate = '72'.obs;
  final RxString riskLevel = 'Low'.obs;
  final RxInt totalReports = 3.obs;
  final RxString lastCheckup = '2 days ago'.obs;
  final RxBool hasNotifications = true.obs;
  final RxBool hasUpcomingAppointments = true.obs;
  final RxString nextAppointment = 'Tomorrow at 10:00 AM'.obs;
  final RxString doctorName = 'Sarah Johnson'.obs;
  final RxInt currentIndex = 0.obs;
  
  // Recent activities list
  final RxList<Map<String, dynamic>> recentActivities = <Map<String, dynamic>>[
    {
      'title': 'ECG Upload Completed',
      'subtitle': 'Report generated successfully',
      'time': '2 hours ago',
      'icon': Icons.upload_file,
      'color': Colors.green,
      'type': 'upload'
    },
    {
      'title': 'Heart Disease Prediction',
      'subtitle': 'Low risk detected',
      'time': '1 day ago',
      'icon': Icons.psychology,
      'color': Colors.blue,
      'type': 'prediction'
    },
    {
      'title': 'Profile Updated',
      'subtitle': 'Medical history updated',
      'time': '3 days ago',
      'icon': Icons.person,
      'color': Colors.orange,
      'type': 'profile'
    },
  ].obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }

  // Load dashboard data
  Future<void> loadDashboardData() async {
    try {
      isLoading.value = true;
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Load patient data (replace with actual API calls)
      await _loadPatientInfo();
      await _loadHealthData();
      await _loadRecentActivities();
      await _checkNotifications();
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load dashboard data: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Refresh dashboard
  Future<void> refreshDashboard() async {
    await loadDashboardData();
    Get.snackbar(
      'Refreshed',
      'Dashboard data updated',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  // Load patient information
  Future<void> _loadPatientInfo() async {
    // TODO: Replace with actual API call
    patientName.value = 'John Doe';
  }

  // Load health data
  Future<void> _loadHealthData() async {
    // TODO: Replace with actual API call
    heartRate.value = '72';
    riskLevel.value = 'Low';
    totalReports.value = 3;
    lastCheckup.value = '2 days ago';
  }

  // Load recent activities
  Future<void> _loadRecentActivities() async {
    // TODO: Replace with actual API call
    // recentActivities is already initialized above
  }

  // Check notifications
  Future<void> _checkNotifications() async {
    // TODO: Replace with actual API call
    hasNotifications.value = true;
  }

  // Get risk level color
  Color getRiskColor() {
    switch (riskLevel.value.toLowerCase()) {
      case 'low':
        return Colors.green[400]!;
      case 'medium':
        return Colors.orange[400]!;
      case 'high':
        return Colors.red[400]!;
      default:
        return Colors.grey[400]!;
    }
  }

  // Navigation methods
  void navigateToUploadECG() {
    Get.toNamed('/upload-ecg');
  }

  void navigateToHeartPrediction() {
    Get.toNamed('/heart-prediction');
  }

  void navigateToReports() {
    Get.toNamed('/diagnosis-reports');
  }

  void navigateToHistory() {
    Get.toNamed('/consultation-history');
  }

  void navigateToHealthData() {
    Get.toNamed('/health-data');
  }

  void navigateToProfile() {
    Get.toNamed('/patient-profile');
  }

  // Show notifications
  void showNotifications() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildNotificationItem(
              'ECG Report Ready',
              'Your latest ECG analysis is available for review',
              '10 min ago',
              Icons.description,
            ),
            _buildNotificationItem(
              'Appointment Reminder',
              'You have an appointment tomorrow at 10:00 AM',
              '2 hours ago',
              Icons.schedule,
            ),
            _buildNotificationItem(
              'Health Tip',
              'Remember to take your daily medication',
              '1 day ago',
              Icons.medical_services,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildNotificationItem(String title, String subtitle, String time, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
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
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Handle menu actions
  void handleMenuAction(String action) {
    switch (action) {
      case 'profile':
        navigateToProfile();
        break;
      case 'settings':
        Get.toNamed('/settings');
        break;
      case 'logout':
        _showLogoutDialog();
        break;
    }
  }

  // Show logout confirmation dialog
  void _showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              logout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  // Logout functionality
  void logout() {
    // Clear user session
    Get.offAllNamed('/user-type-selection');
    Get.snackbar(
      'Logged Out',
      'You have been successfully logged out',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  // Handle recent activity tap
  void handleActivityTap(Map<String, dynamic> activity) {
    switch (activity['type']) {
      case 'upload':
        navigateToReports();
        break;
      case 'prediction':
        navigateToHeartPrediction();
        break;
      case 'profile':
        navigateToProfile();
        break;
      default:
        navigateToHistory();
    }
  }

  // View appointment details
  void viewAppointmentDetails() {
    Get.toNamed('/appointment-details');
  }

  // Book new appointment
  void bookAppointment() {
    Get.toNamed('/book-appointment');
  }

  // Bottom navigation tab change
  void onTabChanged(int index) {
    currentIndex.value = index;
    
    switch (index) {
      case 0:
        // Dashboard - already here
        break;
      case 1:
        navigateToHealthData();
        break;
      case 2:
        navigateToReports();
        break;
      case 3:
        navigateToProfile();
        break;
    }
  }
}