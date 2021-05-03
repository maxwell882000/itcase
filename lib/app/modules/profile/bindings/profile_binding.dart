import 'package:get/get.dart';
import 'package:itcase/app/modules/auth/controllers/account_fill_controller.dart';
import 'package:itcase/app/modules/auth/controllers/auth_controller.dart';

import '../controllers/change_password_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
    Get.lazyPut<AuthFillController>(
          () => AuthFillController(),
    );
  }
}
