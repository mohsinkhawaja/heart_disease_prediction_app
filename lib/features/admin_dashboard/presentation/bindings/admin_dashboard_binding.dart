import 'package:frontend/features/admin_dashboard/presentation/viewmodel/admin_dashboard_viewmodel.dart';
import 'package:get/get.dart';

class AdminDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminDashboardViewModel>(
      () => AdminDashboardViewModel(),
    );
  }
}