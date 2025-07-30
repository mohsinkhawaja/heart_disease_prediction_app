import 'package:flutter/material.dart';
import 'package:frontend/core/shared_widgets/custom_appbar.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../viewmodel/patient_home_viewmodel.dart';

class PatientHomeView extends StatelessWidget {
  const PatientHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PatientHomeViewModel>();

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(
        title: 'Welcome, ${controller.patientName}',
        showBackButton: false,
        backgroundColor: AppColors.primaryColor,
        titleColor: AppColors.whiteColor,
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.notifications_outlined, color: AppColors.whiteColor),
                Obx(() => controller.hasNewNotifications.value
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
            onPressed: controller.showNotifications,
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: AppColors.whiteColor),
            onPressed: controller.openMenu,
          ),
        ],
      ),
      drawer: _buildDrawerMenu(controller),
      body: Obx(() => controller.isLoading.value 
        ? const Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: controller.refreshData,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Health Status Overview Card
                  _buildHealthOverviewCard(controller),
                  const SizedBox(height: 20),
                  
                  // ECG Upload Section (Main Feature)
                  _buildECGUploadSection(controller),
                  const SizedBox(height: 20),
                  
                  // Quick Health Metrics
                  _buildQuickMetrics(controller),
                  const SizedBox(height: 20),
                  
                  // Recent Analysis History
                  _buildRecentAnalysis(controller),
                  const SizedBox(height: 20),
                  
                  // AI Insights & Recommendations
                  _buildAIInsights(controller),
                ],
              ),
            ),
          )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: controller.quickECGUpload,
        backgroundColor: AppColors.primaryColor,
        icon: const Icon(Icons.favorite, color: Colors.white),
        label: const Text('Quick ECG', style: TextStyle(color: Colors.white)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: _buildBottomNavigation(controller),
    );
  }

  Widget _buildDrawerMenu(PatientHomeViewModel controller) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primaryColor, AppColors.primaryColor.withValues(alpha: 0.8),],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 30, color: AppColors.primaryColor),
                ),
                const SizedBox(height: 10),
                Text(
                  'Welcome, ${controller.patientName}',
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Heart Health Monitoring',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14),
                ),
              ],
            ),
          ),
          _buildMenuTile(Icons.home, 'Home', () => Get.back()),
          _buildMenuTile(Icons.upload_file, 'Upload ECG', controller.navigateToUploadECG),
          _buildMenuTile(Icons.psychology, 'AI Heart Analysis', controller.navigateToHeartPrediction),
          _buildMenuTile(Icons.assignment, 'My Reports', controller.navigateToReports),
          _buildMenuTile(Icons.history, 'Consultation History', controller.navigateToHistory),
          _buildMenuTile(Icons.favorite, 'Heart Health Data', controller.navigateToHealthData),
          _buildMenuTile(Icons.person, 'Profile', controller.navigateToProfile),
          _buildMenuTile(Icons.notifications, 'Notifications', controller.navigateToNotifications),
          const Divider(),
          _buildMenuTile(Icons.settings, 'Settings', controller.navigateToSettings),
          _buildMenuTile(Icons.help, 'Help & Support', controller.navigateToHelp),
          _buildMenuTile(Icons.logout, 'Logout', controller.logout, isDestructive: true),
        ],
      ),
    );
  }

  Widget _buildMenuTile(IconData icon, String title, VoidCallback onTap, {bool isDestructive = false}) {
    return ListTile(
      leading: Icon(icon, color: isDestructive ? Colors.red : AppColors.primaryColor),
      title: Text(title, style: TextStyle(color: isDestructive ? Colors.red : Colors.black87)),
      onTap: onTap,
    );
  }

  Widget _buildHealthOverviewCard(PatientHomeViewModel controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue[400]!, Colors.blue[600]!],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.3),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Heart Health Status',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Obx(() => Text(
                  'Risk Level: ${controller.currentRiskLevel.value}',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                )),
                const SizedBox(height: 4),
                Obx(() => Text(
                  'Last Analysis: ${controller.lastAnalysisDate.value}',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 14),
                )),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.favorite,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildECGUploadSection(PatientHomeViewModel controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          // Sample ECG Demo Section
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
                // ECG Sample Image Placeholder
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.monitor_heart, size: 48, color: Colors.grey[400]),
                      const SizedBox(height: 8),
                      Text(
                        'Sample ECG Waveform',
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Try PMcardio with a sample ECG',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Experience our AI-powered heart disease prediction with a demo ECG',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.tryWithSampleECG,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Try PMcardio now', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          
          // Upload Section
          const Text(
            'or upload your ECG here',
            style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          
          // Upload Area
          GestureDetector(
            onTap: controller.uploadECG,
            child: Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primaryColor, width: 2, style: BorderStyle.solid),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload, size: 48, color: AppColors.primaryColor),
                  const SizedBox(height: 8),
                  Text(
                    'Tap to upload ECG image',
                    style: TextStyle(color: AppColors.primaryColor, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Supports JPG, PNG, PDF formats',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickMetrics(PatientHomeViewModel controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Heart Health Metrics',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                'Heart Rate',
                controller.currentHeartRate.value,
                'BPM',
                Icons.favorite,
                Colors.red[400]!,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                'Blood Pressure',
                controller.currentBloodPressure.value,
                'mmHg',
                Icons.speed,
                Colors.orange[400]!,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                'Total Scans',
                controller.totalScans.value.toString(),
                'ECGs',
                Icons.analytics,
                Colors.blue[400]!,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                'Risk Score',
                controller.riskScore.value.toString(),
                '%',
                Icons.security,
                controller.getRiskColor(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, String unit, IconData icon, Color color) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              if (unit.isNotEmpty) ...[
                const SizedBox(width: 4),
                Text(
                  unit,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w500),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentAnalysis(PatientHomeViewModel controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Analysis',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: controller.viewAllReports,
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Obx(() => controller.recentAnalyses.isEmpty
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
                  child: Column(
                    children: [
                      Icon(Icons.analytics, size: 48, color: Colors.grey),
                      SizedBox(height: 8),
                      Text('No recent analysis', style: TextStyle(color: Colors.grey, fontSize: 16)),
                      SizedBox(height: 4),
                      Text('Upload your first ECG to get started', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
              )
            : ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.recentAnalyses.length > 3 ? 3 : controller.recentAnalyses.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final analysis = controller.recentAnalyses[index];
                  return _buildAnalysisCard(analysis);
                },
              )),
      ],
    );
  }

  Widget _buildAnalysisCard(Map<String, dynamic> analysis) {
    return Container(
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: analysis['color'].withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              analysis['icon'],
              color: analysis['color'],
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  analysis['title'],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
                ),
                const SizedBox(height: 4),
                Text(
                  analysis['result'],
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 12, color: Colors.grey[500]),
                    const SizedBox(width: 4),
                    Text(
                      analysis['date'],
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                    const Spacer(),
                    if (analysis['validated'] == true)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.verified, size: 12, color: Colors.green[700]),
                            const SizedBox(width: 4),
                            Text(
                              'Doctor Validated',
                              style: TextStyle(fontSize: 10, color: Colors.green[700], fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
        ],
      ),
    );
  }

  Widget _buildAIInsights(PatientHomeViewModel controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.purple[50]!, Colors.purple[100]!],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.psychology, color: Colors.purple[600], size: 28),
              const SizedBox(width: 12),
              const Text(
                'AI Health Insights',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Obx(() => Column(
            children: controller.aiInsights.map((insight) => 
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(insight['icon'], color: insight['color'], size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        insight['message'],
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              )
            ).toList(),
          )),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation(PatientHomeViewModel controller) {
    return Obx(() => BottomNavigationBar(
      currentIndex: controller.currentNavIndex.value,
      onTap: controller.onNavTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: Colors.grey[600],
      backgroundColor: Colors.white,
      elevation: 8,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Health'),
        BottomNavigationBarItem(icon: Icon(Icons.description), label: 'Reports'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    ));
  }
}