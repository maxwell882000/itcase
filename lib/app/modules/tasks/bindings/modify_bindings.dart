import 'package:get/get.dart';
import 'package:itcase/app/modules/tasks/controllers/map_conroller.dart';
import 'package:itcase/app/modules/tasks/controllers/modify_controller.dart';


class ModifyTaskBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ModifyController>(() => ModifyController());
    Get.lazyPut<MapsController>(() => MapsController());
  }
}
