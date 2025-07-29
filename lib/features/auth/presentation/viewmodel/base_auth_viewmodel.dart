import 'package:flutter/material.dart';
import 'package:frontend/core/repositories/auth_repository.dart';
import 'package:frontend/core/services/validation_service.dart';
import 'package:get/get.dart';

abstract class BaseAuthViewModel extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  // Expose it to children
  AuthRepository get authRepository => _authRepository;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  String? validateEmail(String? value) => ValidationService.validateEmail(value);
  String? validatePassword(String? value) => ValidationService.validatePassword(value);
  String? validateConfirmPassword(String? value, String password) => ValidationService.validateConfirmPassword(value, password);

  void handleError(String message) {
    errorMessage.value = message;
    Get.snackbar('Error', message,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }

  void handleSuccess(String message) {
    Get.snackbar('Success', message,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }

  void showLoading() => isLoading.value = true;
  void hideLoading() => isLoading.value = false;
}
  