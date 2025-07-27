import 'package:frontend/features/auth/presentation/viewmodel/patient_login_viewmodel.dart';
import 'package:get/get.dart';

class PatientLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientLoginViewModel>(() => PatientLoginViewModel());
  }
}
