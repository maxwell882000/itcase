import 'package:get/get.dart';
import 'package:itcase/app/modules/auth/controllers/account_fill_controller.dart';

import '../controllers/auth_controller.dart';

class FillAccountBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthFillController>(() => AuthFillController());
  }
}
