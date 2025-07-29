import 'package:frontend/features/patient_profile/presentation/viewmodel/patient_profile_viewmodel.dart';
import 'package:get/get.dart';

class PatientProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientProfileViewModel>(
      () => PatientProfileViewModel(),
    );
  }
}