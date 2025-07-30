import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
class PatientHomeViewModel extends GetxController {
  // Patient Information
  String patientName = 'Mohsin';
  final RxBool isLoading = false.obs;
  final RxBool hasNewNotifications = true.obs;

  // Health Metrics
  final RxString currentRiskLevel = 'Low'.obs;
  final RxString lastAnalysisDate = '3 days ago'.obs;
  final RxString currentHeartRate = '72'.obs;
  final RxString currentBloodPressure = '120/80'.obs;
  final RxInt totalScans = 5.obs;
  final RxInt riskScore = 15.obs;

  // Navigation
  final RxInt currentNavIndex = 0.obs;

  // Recent Analyses
  final RxList<Map<String, dynamic>> recentAnalyses = <Map<String, dynamic>>[
    {
      'title': 'ECG Analysis #005',
      'result': 'Normal Sinus Rhythm - No abnormalities detected',
      'date': '2 hours ago',
      'icon': Icons.favorite,
      'color': Colors.green,
      'validated': true,
      'riskLevel': 'Low'
    },
    {
      'title': 'ECG Analysis #004',
      'result': 'Mild Arrhythmia - Consult with cardiologist',
      'date': '1 day ago',
      'icon': Icons.warning,
      'color': Colors.orange,
      'validated': true,
      'riskLevel': 'Medium'
    },
    {
      'title': 'ECG Analysis #003',
      'result': 'Normal - Regular heart rhythm pattern',
      'date': '3 days ago',
      'icon': Icons.check_circle,
      'color': Colors.blue,
      'validated': false,
      'riskLevel': 'Low'
    },
  ].obs;

  // AI Insights
  final RxList<Map<String, dynamic>> aiInsights = <Map<String, dynamic>>[
    {
      'message': 'Your heart rhythm has been stable for the past week',
      'icon': Icons.trending_up,
      'color': Colors.green,
      'type': 'positive'
    },
    {
      'message': 'Consider scheduling your next cardiologist appointment',
      'icon': Icons.schedule,
      'color': Colors.blue,
      'type': 'reminder'
    },
    {
      'message': 'Your ECG patterns show improvement compared to last month',
      'icon': Icons.analytics,
      'color': Colors.purple,
      'type': 'insight'
    },
  ].obs;

  @override
  void onInit() {
    super.onInit();
    loadPatientData();
    _startPeriodicUpdates();
  }

  // Load patient data
  Future<void> loadPatientData() async {
    try {
      isLoading.value = true;
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Update metrics (in real app, this would come from API)
      await _updateHealthMetrics();
      await _checkForNewReports();
      await _generateAIInsights();
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load patient data: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Refresh data
  Future<void> refreshData() async {
    await loadPatientData();
    Get.snackbar(
      'Refreshed',
      'Health data updated successfully',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  // Update health metrics
  Future<void> _updateHealthMetrics() async {
    // Simulate real-time health data updates
    // In real app, this would fetch from health monitoring devices or manual input
  }

  // Check for new reports
  Future<void> _checkForNewReports() async {
    // Check if there are new AI-generated reports or doctor validations
    hasNewNotifications.value = recentAnalyses.any((analysis) => !analysis['validated']);
  }

  // Generate AI insights
  Future<void> _generateAIInsights() async {
    // This would be replaced with actual AI analysis
    // For now, using mock insights based on recent data
  }

  // Start periodic updates
  void _startPeriodicUpdates() {
    // Update health metrics every 30 seconds (for demo purposes)
    // In real app, this might be less frequent
    ever(isLoading, (loading) {
      if (!loading) {
        // Set up periodic health data refresh
      }
    });
  }

  // Get risk level color
  Color getRiskColor() {
    switch (riskScore.value) {
      case <= 25:
        return Colors.green[400]!;
      case <= 50:
        return Colors.orange[400]!;
      case <= 75:
        return Colors.red[400]!;
      default:
        return Colors.red[600]!;
    }
  }

  // ECG Upload functionality
  Future<void> uploadECG() async {
    try {
      final result = await showDialog<String>(
        context: Get.context!,
        builder: (context) => AlertDialog(
          title: const Text('Upload ECG'),
          content: const Text('Choose upload method:'),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: 'camera'),
              child: const Text('Camera'),
            ),
            TextButton(
              onPressed: () => Get.back(result: 'gallery'),
              child: const Text('Gallery'),
            ),
            TextButton(
              onPressed: () => Get.back(result: 'file'),
              child: const Text('File'),
            ),
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Cancel'),
            ),
          ],
        ),
      );

      if (result != null) {
        await _handleECGUpload(result);
      }
    } catch (e) {
      Get.snackbar(
        'Upload Error',
        'Failed to upload ECG: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Handle ECG upload based on method
  Future<void> _handleECGUpload(String method) async {
    try {
      isLoading.value = true;
      
      File? selectedFile;
      
      switch (method) {
        case 'camera':
          final ImagePicker picker = ImagePicker();
          final XFile? image = await picker.pickImage(source: ImageSource.camera);
          if (image != null) {
            selectedFile = File(image.path);
          }
          break;
          
        case 'gallery':
          final ImagePicker picker = ImagePicker();
          final XFile? image = await picker.pickImage(source: ImageSource.gallery);
          if (image != null) {
            selectedFile = File(image.path);
          }
          break;
          
        case 'file':
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
          );
          if (result != null && result.files.single.path != null) {
            selectedFile = File(result.files.single.path!);
          }
          break;
      }

      if (selectedFile != null) {
        await _processECGFile(selectedFile);
      }
    } catch (e) {
      Get.snackbar(
        'Upload Error',
        'Failed to select file: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Process uploaded ECG file
  Future<void> _processECGFile(File file) async {
    try {
      // Show processing dialog
      Get.dialog(
        AlertDialog(
          title: const Text('Processing ECG'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              const Text('AI is analyzing your ECG...'),
              const SizedBox(height: 8),
              Text(
                'This may take a few moments',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
        ),
        barrierDismissible: false,
      );

      // Simulate AI processing time
      await Future.delayed(const Duration(seconds: 3));

      // Close processing dialog
      Get.back();

      // Generate mock analysis result
      final analysisResult = await _simulateAIAnalysis(file);

      // Add new analysis to recent analyses
      recentAnalyses.insert(0, analysisResult);

      // Update metrics
      totalScans.value++;
      lastAnalysisDate.value = 'Just now';

      // Show success with results
      _showAnalysisResults(analysisResult);

    } catch (e) {
      Get.back(); // Close processing dialog
      Get.snackbar(
        'Processing Error',
        'Failed to process ECG: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Simulate AI analysis (replace with actual ML model)
  Future<Map<String, dynamic>> _simulateAIAnalysis(File file) async {
    // Mock AI analysis results
    final random = DateTime.now().millisecondsSinceEpoch % 4;
    
    switch (random) {
      case 0:
        return {
          'title': 'ECG Analysis #${(totalScans.value + 1).toString().padLeft(3, '0')}',
          'result': 'Normal Sinus Rhythm - No abnormalities detected',
          'date': 'Just now',
          'icon': Icons.favorite,
          'color': Colors.green,
          'validated': false,
          'riskLevel': 'Low',
          'confidence': 95,
          'details': [
            'Heart rate: 72 BPM (Normal)',
            'Rhythm: Regular',
            'P-wave: Normal',
            'QRS complex: Normal',
            'T-wave: Normal'
          ],
          'recommendations': [
            'Maintain current lifestyle',
            'Continue regular exercise',
            'Schedule routine checkup in 6 months'
          ]
        };
      case 1:
        riskScore.value = 35;
        currentRiskLevel.value = 'Medium';
        return {
          'title': 'ECG Analysis #${(totalScans.value + 1).toString().padLeft(3, '0')}',
          'result': 'Mild Arrhythmia detected - Recommend cardiologist consultation',
          'date': 'Just now',
          'icon': Icons.warning,
          'color': Colors.orange,
          'validated': false,
          'riskLevel': 'Medium',
          'confidence': 87,
          'details': [
            'Heart rate: 85 BPM (Slightly elevated)',
            'Rhythm: Irregular intervals detected',
            'P-wave: Normal',
            'QRS complex: Normal',
            'T-wave: Slight abnormality'
          ],
          'recommendations': [
            'Schedule cardiologist appointment within 2 weeks',
            'Monitor symptoms (chest pain, dizziness)',
            'Avoid excessive caffeine',
            'Continue prescribed medications'
          ]
        };
      case 2:
        return {
          'title': 'ECG Analysis #${(totalScans.value + 1).toString().padLeft(3, '0')}',
          'result': 'Borderline findings - Follow-up recommended',
          'date': 'Just now',
          'icon': Icons.info,
          'color': Colors.blue,
          'validated': false,
          'riskLevel': 'Low-Medium',
          'confidence': 78,
          'details': [
            'Heart rate: 68 BPM (Normal)',
            'Rhythm: Mostly regular',
            'P-wave: Normal',
            'QRS complex: Borderline duration',
            'T-wave: Normal'
          ],
          'recommendations': [
            'Repeat ECG in 1 month',
            'Monitor for symptoms',
            'Maintain healthy lifestyle',
            'Consider stress management'
          ]
        };
      default:
        riskScore.value = 20;
        return {
          'title': 'ECG Analysis #${(totalScans.value + 1).toString().padLeft(3, '0')}',
          'result': 'Excellent heart health - Continue current routine',
          'date': 'Just now',
          'icon': Icons.check_circle,
          'color': Colors.green,
          'validated': false,
          'riskLevel': 'Low',
          'confidence': 98,
          'details': [
            'Heart rate: 65 BPM (Excellent)',
            'Rhythm: Perfect regularity',
            'P-wave: Normal',
            'QRS complex: Normal',
            'T-wave: Normal'
          ],
          'recommendations': [
            'Excellent cardiovascular health',
            'Continue current exercise routine',
            'Maintain balanced diet',
            'Next checkup in 12 months'
          ]
        };
    }
  }

  // Show analysis results
  void _showAnalysisResults(Map<String, dynamic> result) {
    Get.dialog(
      AlertDialog(
        title: Row(
          children: [
            Icon(result['icon'], color: result['color']),
            const SizedBox(width: 8),
            const Text('Analysis Complete'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                result['result'],
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              Text(
                'Confidence: ${result['confidence']}%',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 12),
              const Text(
                'Key Findings:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ...result['details'].map<Widget>((detail) => 
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 4),
                  child: Text('• $detail', style: const TextStyle(fontSize: 14)),
                )
              ).toList(),
              const SizedBox(height: 12),
              const Text(
                'Recommendations:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ...result['recommendations'].map<Widget>((rec) => 
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 4),
                  child: Text('• $rec', style: const TextStyle(fontSize: 14)),
                )
              ).toList(),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.orange[600], size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'This AI analysis will be reviewed by a certified cardiologist within 24 hours.',
                        style: TextStyle(fontSize: 12, color: Colors.orange[800]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              navigateToReports();
            },
            child: const Text('View Full Report'),
          ),
        ],
      ),
    );
  }

  // Quick ECG upload (floating action button)
  Future<void> quickECGUpload() async {
    await uploadECG();
  }

  // Try with sample ECG
  Future<void> tryWithSampleECG() async {
    try {
      isLoading.value = true;

      Get.dialog(
        AlertDialog(
          title: const Text('Processing Sample ECG'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              const Text('Analyzing sample ECG with PMcardio AI...'),
            ],
          ),
        ),
        barrierDismissible: false,
      );

      // Simulate processing
      await Future.delayed(const Duration(seconds: 2));

      Get.back(); // Close dialog

      // Show sample result
      final sampleResult = {
        'title': 'Sample ECG Analysis',
        'result': 'Normal Sinus Rhythm - This is a demonstration of our AI capabilities',
        'date': 'Demo',
        'icon': Icons.psychology,
        'color': Colors.purple,
        'validated': true,
        'riskLevel': 'Low',
        'confidence': 94,
        'details': [
          'Heart rate: 75 BPM (Normal)',
          'Rhythm: Regular and consistent',
          'P-wave: Normal morphology',
          'QRS complex: Normal duration',
          'T-wave: Normal amplitude'
        ],
        'recommendations': [
          'This is a sample demonstration',
          'Upload your own ECG for personalized analysis',
          'Our AI can detect various heart conditions',
          'All results are validated by cardiologists'
        ]
      };

      _showAnalysisResults(sampleResult);

    } catch (e) {
      Get.snackbar(
        'Demo Error',
        'Failed to run sample analysis',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Navigation methods
  void openMenu() {
    // This will open the drawer automatically when menu icon is pressed
    // The drawer is defined in the view
  }

  void navigateToUploadECG() {
    Get.back(); // Close drawer
    uploadECG();
  }

  void navigateToHeartPrediction() {
    Get.back(); // Close drawer
    Get.toNamed('/heart-prediction');
  }

  void navigateToReports() {
    Get.back(); // Close drawer if open
    Get.toNamed('/diagnosis-reports');
  }

  void navigateToHistory() {
    Get.back(); // Close drawer
    Get.toNamed('/consultation-history');
  }

  void navigateToHealthData() {
    Get.back(); // Close drawer
    Get.toNamed('/health-data');
  }

  void navigateToProfile() {
    Get.back(); // Close drawer
    Get.toNamed('/patient-profile');
  }

  void navigateToNotifications() {
    Get.back(); // Close drawer
    showNotifications();
  }

  void navigateToSettings() {
    Get.back(); // Close drawer
    Get.toNamed('/settings');
  }

  void navigateToHelp() {
    Get.back(); // Close drawer
    Get.toNamed('/help');
  }

  void viewAllReports() {
    navigateToReports();
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildNotificationItem(
              'New ECG Analysis Ready',
              'Your latest ECG has been analyzed and validated by Dr. Sarah Johnson',
              '15 min ago',
              Icons.description,
              Colors.green,
            ),
            _buildNotificationItem(
              'AI Health Insight',
              'Your heart rhythm pattern shows improvement over the last month',
              '2 hours ago',
              Icons.psychology,
              Colors.purple,
            ),
            _buildNotificationItem(
              'Appointment Reminder',
              'Cardiologist consultation scheduled for tomorrow at 10:00 AM',
              '1 day ago',
              Icons.schedule,
              Colors.blue,
            ),
            _buildNotificationItem(
              'Medication Reminder',
              'Time to take your prescribed heart medication',
              '2 days ago',
              Icons.medical_services,
              Colors.orange,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                  hasNewNotifications.value = false;
                },
                child: const Text('Mark All as Read'),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildNotificationItem(String title, String subtitle, String time, IconData icon, Color color) {
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
              color: color.withValues(alpha: 0.2),
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
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(color: Colors.grey[500], fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Bottom navigation
  void onNavTap(int index) {
    currentNavIndex.value = index;
    
    switch (index) {
      case 0:
        // Already on home
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

  // Logout
  void logout() {
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
              Get.back(); // Close dialog
              Get.back(); // Close drawer
              Get.offAllNamed('/user-type-selection');
              Get.snackbar(
                'Logged Out',
                'You have been successfully logged out',
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
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

  @override
  void onClose() {
    // Clean up any subscriptions or timers
    super.onClose();
  }
}
          