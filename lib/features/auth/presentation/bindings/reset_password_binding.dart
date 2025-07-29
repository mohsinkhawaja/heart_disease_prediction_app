import 'package:frontend/features/auth/presentation/viewmodel/reset_password_viewmodel.dart';
import 'package:get/get.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordViewModel>(() => ResetPasswordViewModel());
  }
}
