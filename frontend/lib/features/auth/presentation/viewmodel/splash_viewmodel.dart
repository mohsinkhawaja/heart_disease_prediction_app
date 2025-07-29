import 'package:frontend/routes/app_routes.dart';
import 'package:get/get.dart';
import 'dart:async';

class SplashViewModel extends GetxController {
  @override
  void onInit() {
    super.onInit();
    startDelay();
  }

  void startDelay() {
    Timer(const Duration(seconds: 3), () {
      Get.offNamed(AppRoutes.userTypeSelection);
    });
  }
}
