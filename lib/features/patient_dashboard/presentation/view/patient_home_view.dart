import 'package:flutter/material.dart';
import 'package:frontend/core/shared_widgets/custom_appbar.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
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
            icon: const Icon(Icons.notifications, color: AppColors.whiteColor),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: AppColors.whiteColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.secondaryLight,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Image.asset(
                    'assets/images/sample_ecg.jpg',
                    width: 200,
                    height: 200,
                  ),
                ), // placeholder
                const SizedBox(height: 10),
                const Text(
                  "Try CardioAI with a sample ECG",
                  style: AppFonts.bodyMedium,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Try CardioAI now"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 100),
          Center(
            child: const Text(
              "or upload your ECG here",
              style: TextStyle(color: Colors.blue),
            ),
          ),
          const SizedBox(height: 8),
          const SizedBox(height: 8),
          Icon(Icons.arrow_downward, color: AppColors.primaryColor, size: 32),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        backgroundColor: AppColors.primaryColor,
        tooltip: 'Upload ECG',
        onPressed: () {
          // TODO: Floating action button functionality
        },
        child: Icon(Icons.add, color: AppColors.cardColor),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          if (index == 1) {
            // TODO: Navigate to Reports
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Reports",
          ),
        ],
      ),
    );
  }
}
