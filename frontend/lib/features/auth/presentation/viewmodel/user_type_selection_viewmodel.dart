import 'package:get/get.dart';

class UserTypeSelectionViewModel extends GetxController {
  void navigateToPatientLogin() {
    Get.toNamed('/patient-login');
  }

  void navigateToDoctorLogin() {
    Get.toNamed('/doctor-login');
  }
}
