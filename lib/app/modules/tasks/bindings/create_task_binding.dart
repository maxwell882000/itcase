import 'package:get/get.dart';
import 'package:itcase/app/modules/tasks/controllers/create_task_controller.dart';
import 'package:itcase/app/modules/tasks/controllers/map_conroller.dart';

class CreateTaskBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapsController>(() => MapsController());
    Get.lazyPut<CreateTasksController>(() => CreateTasksController());
  }
}
