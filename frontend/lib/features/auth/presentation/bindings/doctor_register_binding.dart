import 'package:frontend/features/auth/presentation/viewmodel/doctor_register_viewmodel.dart';
import 'package:get/get.dart';

class DoctorRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorRegisterViewModel>(() => DoctorRegisterViewModel());
  }
}
