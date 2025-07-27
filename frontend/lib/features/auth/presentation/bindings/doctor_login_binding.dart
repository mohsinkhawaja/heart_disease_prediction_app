import 'package:frontend/features/auth/presentation/viewmodel/doctor_login_viewmodel.dart';
import 'package:get/get.dart';

class DoctorLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorLoginViewModel>(() => DoctorLoginViewModel());
  }
}
