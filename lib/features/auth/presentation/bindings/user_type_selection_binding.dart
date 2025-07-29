import 'package:frontend/features/auth/presentation/viewmodel/user_type_selection_viewmodel.dart';
import 'package:get/get.dart';

class UserTypeSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserTypeSelectionViewModel>(() => UserTypeSelectionViewModel());
  }
}
