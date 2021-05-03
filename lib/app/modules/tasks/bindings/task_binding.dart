import 'package:get/get.dart';
import 'package:itcase/app/modules/search/controllers/search_controller.dart';
import 'package:itcase/app/modules/tasks/controllers/create_task_controller.dart';
import 'package:itcase/app/modules/tasks/controllers/map_conroller.dart';
import 'package:itcase/app/modules/tasks/controllers/modify_controller.dart';

import 'package:itcase/app/modules/tasks/controllers/take_offer_controller.dart';
import 'package:itcase/app/modules/tasks/controllers/tender_controller.dart';
import 'package:itcase/app/modules/tasks/controllers/tender_view_controller.dart';

class TaskBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TenderController>(
      () => TenderController(),
    );
    Get.lazyPut<ModifyController>(() => ModifyController());

    Get.lazyPut<TenderViewController>(() => TenderViewController());
    Get.lazyPut<TakeOfferController>(() => TakeOfferController());
    Get.lazyPut<SearchController>(
      () => SearchController(),
    );
  }
}
