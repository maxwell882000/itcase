import 'package:get/get.dart';
import '../../../models/task_model.dart';

class RatingController extends GetxController {
  final task = Task().obs;

  @override
  void onInit() {
    task.value = Get.arguments as Task;
    super.onInit();
  }
}
