import 'package:get/get.dart';

import 'package:itcase/app/modules/tasks/controllers/tender_controller.dart';
class AccountTenderBindings extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<TenderController>(
          () => TenderController(),
    );
  }
}
