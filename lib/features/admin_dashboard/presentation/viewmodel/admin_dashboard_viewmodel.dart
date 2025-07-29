import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDashboardViewModel extends GetxController {
  // Observable variables
  final RxBool isLoading = false.obs;
  final RxString adminName = 'Admin'.obs;
  final RxString lastLogin = 'Today at 9:30 AM'.obs;
  final RxInt totalPatients = 1250.obs;
  final RxInt totalDoctors = 85.obs;
  final RxInt pendingApprovals = 12.obs;
  final RxInt totalReports = 3420.obs;
  final RxBool hasNotifications = true.obs;
  final RxInt currentIndex = 0.obs;

  // Pending actions list
  final RxList<Map<String, dynamic>> pendingActions = <Map<String, dynamic>>[
    {
      'id': '1',
      'title': 'Doctor Registration Pending',
      'description': 'Dr. Sarah Johnson - Cardiologist',
      'icon': Icons.person_add,
      'type': 'doctor_approval',
      'urgent': true,
    },
    {
      'id': '2',
      'title': 'Patient Complaint',
      'description': 'Service quality complaint #1234',
      'icon': Icons.feedback,
      'type': 'complaint',
      'urgent': false,
    },
    {
      'id': '3',
      'title': 'System Backup Required',
      'description': 'Weekly backup overdue',
      'icon': Icons.backup,
      'type': 'system',
      'urgent': true,
    },
  ].obs;

  // Recent activities list
  final RxList<Map<String, dynamic>> recentActivities = <Map<String, dynamic>>[
    {
      'title': 'Doctor Approved',
      'subtitle': 'Dr. Michael Chen registration approved',
      'time': '30 minutes ago',
      'icon': Icons.check_circle,
      'color': Colors.green,
      'type': 'approval'
    },
    {
      'title': 'Patient Registered',
      'subtitle': 'New patient: John Smith',
      'time': '1 hour ago',
      'icon': Icons.person_add,
      'color': Colors.blue,
      'type': 'registration'
    },
    {
      'title': 'Report Generated',
      'subtitle': 'Monthly system report created',
      'time': '2 hours ago',
      'icon': Icons.description,
      'color': Colors.purple,
      'type': 'report'
    },
    {
      'title': 'Complaint Resolved',
      'subtitle': 'Ticket #1230 marked as resolved',
      'time': '3 hours ago',
      'icon': Icons.check,
      'color': Colors.orange,
      'type': 'complaint'
    },
    {
      'title': 'System Backup',
      'subtitle': 'Database backup completed',
      'time': '5 hours ago',
      'icon': Icons.backup,
      'color': Colors.indigo,
      'type': 'backup'
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
      
      // Load admin data (replace with actual API calls)
      await _loadAdminInfo();
      await _loadSystemStats();
      await _loadPendingActions();
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

  // Load admin information
  Future<void> _loadAdminInfo() async {
    // TODO: Replace with actual API call
    adminName.value = 'Admin';
    lastLogin.value = 'Today at 9:30 AM';
  }

  // Load system statistics
  Future<void> _loadSystemStats() async {
    // TODO: Replace with actual API call
    totalPatients.value = 1250;
    totalDoctors.value = 85;
    pendingApprovals.value = 12;
    totalReports.value = 3420;
  }

  // Load pending actions
  Future<void> _loadPendingActions() async {
    // TODO: Replace with actual API call
    // pendingActions is already initialized above
  }

  // Load recent activities
  Future<void> _loadRecentActivities() async {
    // TODO: Replace with actual API call
    // recentActivities is already initialized above
  }

  // Check notifications
  Future<void> _checkNotifications() async {
    // TODO: Replace with actual API call
    hasNotifications.value = pendingApprovals.value > 0;
  }

  // Navigation methods
  void navigateToPatientManagement() {
    Get.toNamed('/admin-patient-management');
  }

  void navigateToDoctorManagement() {
    Get.toNamed('/admin-doctor-management');
  }

  void navigateToPendingApprovals() {
    Get.toNamed('/admin-pending-approvals');
  }

  void navigateToReportsManagement() {
    Get.toNamed('/admin-reports-management');
  }

  void navigateToDoctorApprovals() {
    Get.toNamed('/admin-doctor-approvals');
  }

  void navigateToUserManagement() {
    Get.toNamed('/admin-user-management');
  }

  void navigateToComplaints() {
    Get.toNamed('/admin-complaints');
  }

  void navigateToSystemReports() {
    Get.toNamed('/admin-system-reports');
  }

  void navigateToSettings() {
    Get.toNamed('/admin-settings');
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
                  'System Notifications',
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
              'New Doctor Registration',
              'Dr. Sarah Johnson has submitted registration documents',
              '10 min ago',
              Icons.person_add,
              Colors.green,
            ),
            _buildNotificationItem(
              'System Alert',
              'Server CPU usage exceeded 80%',
              '30 min ago',
              Icons.warning,
              Colors.orange,
            ),
            _buildNotificationItem(
              'Patient Complaint',
              'New complaint received from patient ID #1234',
              '1 hour ago',
              Icons.feedback,
              Colors.red,
            ),
            _buildNotificationItem(
              'Backup Completed',
              'Daily database backup completed successfully',
              '2 hours ago',
              Icons.backup,
              Colors.blue,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildNotificationItem(
    String title,
    String subtitle,
    String time,
    IconData icon,
    Color color,
  ) {
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
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
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
      case 'settings':
        navigateToSettings();
        break;
      case 'backup':
        initiateBackup();
        break;
      case 'reports':
        navigateToSystemReports();
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
        content: const Text('Are you sure you want to logout from admin panel?'),
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
    // Clear admin session
    Get.offAllNamed('/admin-login');
    Get.snackbar(
      'Logged Out',
      'Admin session ended successfully',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  // Handle pending actions
  void handlePendingAction(Map<String, dynamic> action) {
    switch (action['type']) {
      case 'doctor_approval':
        navigateToDoctorApprovals();
        break;
      case 'complaint':
        navigateToComplaints();
        break;
      case 'system':
        if (action['title'].contains('Backup')) {
          initiateBackup();
        } else {
          navigateToSettings();
        }
        break;
      default:
        Get.snackbar(
          'Info',
          'Opening ${action['title']}...',
          backgroundColor: Colors.blue,
          colorText: Colors.white,
        );
    }
  }

  // View all pending actions
  void viewAllPendingActions() {
    Get.toNamed('/admin-pending-actions');
  }

  // View all activities
  void viewAllActivities() {
    Get.toNamed('/admin-activity-log');
  }

  // Handle recent activity tap
  void handleActivityTap(Map<String, dynamic> activity) {
    switch (activity['type']) {
      case 'approval':
        navigateToDoctorManagement();
        break;
      case 'registration':
        navigateToPatientManagement();
        break;
      case 'report':
        navigateToSystemReports();
        break;
      case 'complaint':
        navigateToComplaints();
        break;
      case 'backup':
        navigateToSettings();
        break;
      default:
        Get.snackbar(
          'Info',
          'Viewing ${activity['title']}...',
          backgroundColor: Colors.blue,
          colorText: Colors.white,
        );
    }
  }

  // Initiate backup
  void initiateBackup() {
    Get.dialog(
      AlertDialog(
        title: const Text('System Backup'),
        content: const Text(
          'This will create a backup of all system data. The process may take several minutes.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              _performBackup();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo[600],
              foregroundColor: Colors.white,
            ),
            child: const Text('Start Backup'),
          ),
        ],
      ),
    );
  }

  void _performBackup() async {
    try {
      Get.dialog(
        const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Creating backup...'),
            ],
          ),
        ),
        barrierDismissible: false,
      );

      // Simulate backup process
      await Future.delayed(const Duration(seconds: 5));
      
      Get.back(); // Close progress dialog
      
      Get.snackbar(
        'Backup Complete',
        'System backup created successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );

      // Remove backup pending action
      pendingActions.removeWhere((action) => action['type'] == 'system');
      
    } catch (e) {
      Get.back(); // Close progress dialog
      Get.snackbar(
        'Backup Failed',
        'Failed to create backup: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Bottom navigation tab change
  void onTabChanged(int index) {
    currentIndex.value = index;
    
    switch (index) {
      case 0:
        // Dashboard - already here
        break;
      case 1:
        navigateToUserManagement();
        break;
      case 2:
        navigateToDoctorManagement();
        break;
      case 3:
        navigateToReportsManagement();
        break;
      case 4:
        navigateToSettings();
        break;
    }
  }
}