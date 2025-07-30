import 'package:flutter/material.dart';
import 'package:frontend/features/patient_dashboard/presentation/viewmodel/patient_dashboard_viewmodel.dart';
import 'package:frontend/features/patient_dashboard/presentation/widgets/dashboard_card.dart';
import 'package:frontend/features/patient_dashboard/presentation/widgets/quick_action_card.dart';
import 'package:frontend/features/patient_dashboard/presentation/widgets/recent_activity_card.dart';
import 'package:get/get.dart';

class PatientDashboardView extends GetView<PatientDashboardViewModel> {
  const PatientDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Obx(
          () => Text(
            'Welcome, ${controller.patientName.value}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.teal[600],
        elevation: 0,
        actions: [
          IconButton(
            onPressed: controller.showNotifications,
            icon: Stack(
              children: [
                const Icon(Icons.notifications_outlined, color: Colors.white),
                Obx(
                  () =>
                      controller.hasNotifications.value
                          ? Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 12,
                                minHeight: 12,
                              ),
                            ),
                          )
                          : const SizedBox(),
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            onSelected: controller.handleMenuAction,
            itemBuilder:
                (context) => [
                  const PopupMenuItem(
                    value: 'profile',
                    child: Row(
                      children: [
                        Icon(Icons.person, color: Colors.teal),
                        SizedBox(width: 8),
                        Text('Profile'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'settings',
                    child: Row(
                      children: [
                        Icon(Icons.settings, color: Colors.teal),
                        SizedBox(width: 8),
                        Text('Settings'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Logout'),
                      ],
                    ),
                  ),
                ],
            icon: const Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
      ),
      body: Obx(
        () =>
            controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                  onRefresh: controller.refreshDashboard,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Health Status Overview
                        _buildHealthStatusSection(),
                        const SizedBox(height: 20),

                        // Quick Actions
                        _buildQuickActionsSection(),
                        const SizedBox(height: 20),

                        // Recent Activity
                        _buildRecentActivitySection(),
                        const SizedBox(height: 20),

                        // Upcoming Appointments
                        _buildUpcomingSection(),
                      ],
                    ),
                  ),
                ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildHealthStatusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Health Overview',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: DashboardCard(
                title: 'Heart Rate',
                value: controller.heartRate.value,
                unit: 'BPM',
                icon: Icons.favorite,
                color: Colors.red[400]!,
                onTap: () => controller.navigateToHealthData(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DashboardCard(
                title: 'Risk Level',
                value: controller.riskLevel.value,
                unit: '',
                icon: Icons.security,
                color: controller.getRiskColor(),
                onTap: () => controller.navigateToHeartPrediction(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: DashboardCard(
                title: 'Reports',
                value: controller.totalReports.value.toString(),
                unit: 'Total',
                icon: Icons.description,
                color: Colors.blue[400]!,
                onTap: () => controller.navigateToReports(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DashboardCard(
                title: 'Last Checkup',
                value: controller.lastCheckup.value,
                unit: '',
                icon: Icons.calendar_today,
                color: Colors.green[400]!,
                onTap: () => controller.navigateToHistory(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.5,
          children: [
            QuickActionCard(
              title: 'Upload ECG',
              subtitle: 'Upload health data',
              icon: Icons.upload_file,
              color: Colors.purple[400]!,
              onTap: () => controller.navigateToUploadECG(),
            ),
            QuickActionCard(
              title: 'Heart Check',
              subtitle: 'AI Prediction',
              icon: Icons.psychology,
              color: Colors.orange[400]!,
              onTap: () => controller.navigateToHeartPrediction(),
            ),
            QuickActionCard(
              title: 'View Reports',
              subtitle: 'Diagnosis reports',
              icon: Icons.assignment,
              color: Colors.indigo[400]!,
              onTap: () => controller.navigateToReports(),
            ),
            QuickActionCard(
              title: 'Consultation',
              subtitle: 'History & reviews',
              icon: Icons.history,
              color: Colors.teal[400]!,
              onTap: () => controller.navigateToHistory(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentActivitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Activity',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            TextButton(
              onPressed: () => controller.navigateToHistory(),
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Obx(
          () =>
              controller.recentActivities.isEmpty
                  ? Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.1),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'No recent activity',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  )
                  : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        controller.recentActivities.length > 3
                            ? 3
                            : controller.recentActivities.length,
                    separatorBuilder:
                        (context, index) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final activity = controller.recentActivities[index];
                      return RecentActivityCard(
                        title: activity['title'],
                        subtitle: activity['subtitle'],
                        time: activity['time'],
                        icon: activity['icon'],
                        color: activity['color'],
                        onTap: () => controller.handleActivityTap(activity),
                      );
                    },
                  ),
        ),
      ],
    );
  }

  Widget _buildUpcomingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upcoming',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Obx(
            () =>
                controller.hasUpcomingAppointments.value
                    ? Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.green[100],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.schedule,
                                color: Colors.green[600],
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.nextAppointment.value,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Dr. ${controller.doctorName.value}',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed:
                                  () => controller.viewAppointmentDetails(),
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                    : Column(
                      children: [
                        Icon(
                          Icons.event_available,
                          size: 48,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'No upcoming appointments',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => controller.bookAppointment(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal[600],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Book Appointment'),
                        ),
                      ],
                    ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigation() {
    return Obx(
      () => BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        onTap: controller.onTabChanged,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.teal[600],
        unselectedItemColor: Colors.grey[600],
        backgroundColor: Colors.white,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Health'),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Reports',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
