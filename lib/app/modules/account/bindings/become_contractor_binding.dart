import 'package:get/get.dart';
import 'package:itcase/app/modules/account/controllers/account_controller.dart';
import 'package:itcase/app/modules/account/controllers/become_contractor_controller.dart';
import 'package:itcase/app/modules/auth/controllers/verify_controller.dart';
import 'package:itcase/app/modules/account/controllers/guest_controller.dart';
class BecomeContractorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BecomeContractorController>(
          () => BecomeContractorController(),
    );
  }
}
