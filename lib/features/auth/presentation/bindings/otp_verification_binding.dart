import 'package:frontend/features/auth/presentation/viewmodel/otp_verification_viewmodel.dart';
import 'package:get/get.dart';

class OtpVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpVerificationViewModel>(() => OtpVerificationViewModel());
  }
}
