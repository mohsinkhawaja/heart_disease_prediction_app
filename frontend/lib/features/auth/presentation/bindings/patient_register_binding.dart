import 'package:frontend/features/auth/presentation/viewmodel/patient_register_viewmodel.dart';
import 'package:get/get.dart';

class PatientRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientRegisterViewModel>(() => PatientRegisterViewModel());
  }
}
