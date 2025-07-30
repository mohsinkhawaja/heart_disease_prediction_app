import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_fonts.dart';
import '../../../../../core/services/session_service.dart';
import '../../../../../routes/app_routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _animationController.forward();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));

    // Check if user is already logged in
    final isLoggedIn = await SessionService.isLoggedIn();

    if (isLoggedIn) {
      final user = await SessionService.getCurrentUser();
      if (user != null) {
        // Navigate to appropriate dashboard based on user type
        if (user.userType.name == 'patient') {
          Get.offAllNamed(AppRoutes.patientHome);
        } else {
          Get.offAllNamed(AppRoutes.doctorDashboard);
        }
      } else {
        Get.offAllNamed(AppRoutes.userTypeSelection);
      }
    } else {
      Get.offAllNamed(AppRoutes.userTypeSelection);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App Logo
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.whiteColor,
                        size: 60,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // App Name
                    Text(
                      'Heart Disease\nPrediction',
                      style: AppFonts.heading1.copyWith(
                        color: AppColors.whiteColor,
                        fontSize: 32,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 16),

                    // App Tagline
                    Text(
                      'AI-powered ECG Analysis',
                      style: AppFonts.bodyLarge.copyWith(
                        color: AppColors.whiteColor.withValues(alpha: 0.9),
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 48),

                    // Loading Indicator
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        color: AppColors.whiteColor,
                        strokeWidth: 3,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Loading Text
                    Text(
                      'Initializing...',
                      style: AppFonts.bodyMedium.copyWith(
                        color: AppColors.whiteColor.withValues(alpha: 0.1),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
