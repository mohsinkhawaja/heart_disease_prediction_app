import 'package:get/get.dart';
import '../viewmodel/patient_dashboard_viewmodel.dart';

class PatientDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientDashboardViewModel>(
      () => PatientDashboardViewModel(),
    );
  }
}