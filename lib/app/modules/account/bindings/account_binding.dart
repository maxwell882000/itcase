import 'package:get/get.dart';
import 'package:itcase/app/modules/account/controllers/account_controller.dart';
import 'package:itcase/app/modules/auth/controllers/verify_controller.dart';
import 'package:itcase/app/modules/account/controllers/guest_controller.dart';
import 'package:itcase/app/modules/tasks/controllers/tender_controller.dart';
class AccountBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<AccountController>(
          () => AccountController(),
    );
    Get.lazyPut<GuestController>(
          () => GuestController(),
    );
  }
}
