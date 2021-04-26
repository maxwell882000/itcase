
import 'package:get/get.dart';
import 'package:itcase/app/modules/auth/controllers/account_fill_controller.dart';
import 'package:itcase/app/modules/auth/controllers/register_controller.dart';
import 'package:itcase/app/modules/auth/controllers/verify_controller.dart';
import 'package:itcase/app/modules/root/controllers/root_controller.dart';

import '../controllers/auth_controller.dart';

class VerifyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyController>(() =>
        VerifyController());

    Get.lazyPut<RegisterController>(
          () => RegisterController(),
    );

  }
}
