import 'package:frontend/features/patient_dashboard/presentation/viewmodel/patient_home_viewmodel.dart';
import 'package:get/get.dart';

class PatientHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PatientHomeViewModel());
  }
}
