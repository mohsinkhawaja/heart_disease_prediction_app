// Admin Dashboard View
// File: features/admin_dashboard/presentation/view/admin_dashboard_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodel/admin_dashboard_viewmodel.dart';
import '../widgets/admin_stat_card.dart';
import '../widgets/admin_quick_action_card.dart';
import '../widgets/admin_recent_activity_card.dart';

class AdminDashboardView extends GetView<AdminDashboardViewModel> {
  const AdminDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigo[700],
        elevation: 0,
        actions: [
          IconButton(
            onPressed: controller.showNotifications,
            icon: Stack(
              children: [
                const Icon(Icons.notifications_outlined, color: Colors.white),
                Obx(() => controller.hasNotifications.value
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
                    : const SizedBox()),
              ],
            ),
          ),
          PopupMenuButton<String>(
            onSelected: controller.handleMenuAction,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings, color: Colors.indigo),
                    SizedBox(width: 8),
                    Text('System Settings'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'backup',
                child: Row(
                  children: [
                    Icon(Icons.backup, color: Colors.indigo),
                    SizedBox(width: 8),
                    Text('Data Backup'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'reports',
                child: Row(
                  children: [
                    Icon(Icons.analytics, color: Colors.indigo),
                    SizedBox(width: 8),
                    Text('System Reports'),
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
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: controller.refreshDashboard,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome Section
                    _buildWelcomeSection(),
                    const SizedBox(height: 20),
                    
                    // System Statistics
                    _buildSystemStatsSection(),
                    const SizedBox(height: 20),
                    
                    // Quick Actions
                    _buildQuickActionsSection(),
                    const SizedBox(height: 20),
                    
                    // Pending Actions
                    _buildPendingActionsSection(),
                    const SizedBox(height: 20),
                    
                    // Recent Activity
                    _buildRecentActivitySection(),
                    const SizedBox(height: 20),
                    
                    // System Health
                    _buildSystemHealthSection(),
                  ],
                ),
              ),
            )),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.indigo[600]!,
            Colors.indigo[800]!,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withValues(alpha: 0.3),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.admin_panel_settings,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => Text(
                          'Welcome, ${controller.adminName.value}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )),
                    const SizedBox(height: 4),
                    Text(
                      'System Administrator',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Obx(() => Text(
                'Last login: ${controller.lastLogin.value}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildSystemStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'System Overview',
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
          childAspectRatio: 1.2,
          children: [
            AdminStatCard(
              title: 'Total Patients',
              value: controller.totalPatients.value.toString(),
              icon: Icons.people,
              color: Colors.blue[600]!,
              trend: '+12%',
              onTap: () => controller.navigateToPatientManagement(),
            ),
            AdminStatCard(
              title: 'Total Doctors',
              value: controller.totalDoctors.value.toString(),
              icon: Icons.medical_services,
              color: Colors.green[600]!,
              trend: '+5%',
              onTap: () => controller.navigateToDoctorManagement(),
            ),
            AdminStatCard(
              title: 'Pending Approvals',
              value: controller.pendingApprovals.value.toString(),
              icon: Icons.pending_actions,
              color: Colors.orange[600]!,
              trend: '-3%',
              onTap: () => controller.navigateToPendingApprovals(),
            ),
            AdminStatCard(
              title: 'Total Reports',
              value: controller.totalReports.value.toString(),
              icon: Icons.assignment,
              color: Colors.purple[600]!,
              trend: '+18%',
              onTap: () => controller.navigateToReportsManagement(),
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
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.0,
          children: [
            AdminQuickActionCard(
              title: 'Approve Doctors',
              icon: Icons.how_to_reg,
              color: Colors.green[500]!,
              onTap: () => controller.navigateToDoctorApprovals(),
            ),
            AdminQuickActionCard(
              title: 'Manage Users',
              icon: Icons.people_alt,
              color: Colors.blue[500]!,
              onTap: () => controller.navigateToUserManagement(),
            ),
            AdminQuickActionCard(
              title: 'View Complaints',
              icon: Icons.feedback,
              color: Colors.red[500]!,
              onTap: () => controller.navigateToComplaints(),
            ),
            AdminQuickActionCard(
              title: 'System Reports',
              icon: Icons.analytics,
              color: Colors.purple[500]!,
              onTap: () => controller.navigateToSystemReports(),
            ),
            AdminQuickActionCard(
              title: 'Backup Data',
              icon: Icons.backup,
              color: Colors.indigo[500]!,
              onTap: () => controller.initiateBackup(),
            ),
            AdminQuickActionCard(
              title: 'Settings',
              icon: Icons.settings,
              color: Colors.grey[600]!,
              onTap: () => controller.navigateToSettings(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPendingActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Pending Actions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Obx(() => controller.pendingActions.isNotEmpty
                ? TextButton(
                    onPressed: () => controller.viewAllPendingActions(),
                    child: const Text('View All'),
                  )
                : const SizedBox()),
          ],
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
          child: Obx(() => controller.pendingActions.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 48,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'No pending actions',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Column(
                  children: controller.pendingActions
                      .take(3)
                      .map((action) => _buildPendingActionItem(action))
                      .toList(),
                )),
        ),
      ],
    );
  }

  Widget _buildPendingActionItem(Map<String, dynamic> action) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.orange[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              action['icon'],
              color: Colors.orange[600],
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  action['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  action['description'],
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => controller.handlePendingAction(action),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange[600],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              minimumSize: Size.zero,
            ),
            child: const Text(
              'Review',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
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
              onPressed: () => controller.viewAllActivities(),
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Obx(() => controller.recentActivities.isEmpty
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
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            : ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.recentActivities.length > 5
                    ? 5
                    : controller.recentActivities.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final activity = controller.recentActivities[index];
                  return AdminRecentActivityCard(
                    title: activity['title'],
                    subtitle: activity['subtitle'],
                    time: activity['time'],
                    icon: activity['icon'],
                    color: activity['color'],
                    onTap: () => controller.handleActivityTap(activity),
                  );
                },
              )),
      ],
    );
  }

  Widget _buildSystemHealthSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'System Health',
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
          child: Column(
            children: [
              _buildHealthItem(
                'Server Status',
                'Online',
                Colors.green,
                Icons.cloud_done,
              ),
              const Divider(),
              _buildHealthItem(
                'Database',
                'Healthy',
                Colors.green,
                Icons.storage,
              ),
              const Divider(),
              _buildHealthItem(
                'ML Service',
                'Running',
                Colors.green,
                Icons.psychology,
              ),
              const Divider(),
              _buildHealthItem(
                'Backup Status',
                'Last: 2 hours ago',
                Colors.blue,
                Icons.backup,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHealthItem(
    String title,
    String status,
    Color color,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            status,
            style: TextStyle(
              fontSize: 14,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Obx(() => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.onTabChanged,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.indigo[600],
          unselectedItemColor: Colors.grey[600],
          backgroundColor: Colors.white,
          elevation: 8,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Users',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.medical_services),
              label: 'Doctors',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: 'Reports',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ));
  }
}