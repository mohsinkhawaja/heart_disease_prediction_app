import 'package:frontend/features/auth/presentation/viewmodel/splash_viewmodel.dart';
import 'package:get/get.dart';


class SplashViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashViewModel());
  }
}
