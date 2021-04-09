import 'package:get/get.dart';
import 'package:itcase/app/models/category_model.dart';
import 'package:itcase/app/models/tenders.dart';
import 'package:itcase/app/modules/category/controllers/categories_controller.dart';
import 'package:itcase/app/repositories/category_repository.dart';
import '../../../models/e_service_model.dart';
import '../../../models/task_model.dart';
import '../../../repositories/task_repository.dart';
import '../../../../common/ui.dart';

class TenderController extends GetxController {
  TaskRepository _taskRepository;

  var ongoingTasks = List<Tenders>().obs;
  var completedTasks = List<Tenders>().obs;
  var archivedTasks = List<Tenders>().obs;
  final task = new Tenders().obs;

  // final selectedOngoingTask = Task().obs;
  // final selectedCompletedTask = Task().obs;
  // final selectedArchivedTask = Task().obs;

  @override
  void onInit() async {
    _taskRepository = new TaskRepository();
    await getOngoingTasks();
    super.onInit();
    Get.lazyPut(() => TenderController());
  }

  Future refreshTasks({bool showMessage = false}) async {
    await getOngoingTasks();
    await getCompletedTasks();
    await getArchivedTasks();
    if (showMessage) {
      Get.showSnackbar(
          Ui.SuccessSnackBar(message: "Task page refreshed successfully".tr));
    }
  }

  Future<void> getOngoingTasks({bool showMessage = false}) async {
    ongoingTasks.value = await _taskRepository.getAll();
    if (showMessage) {
      Get.showSnackbar(
          Ui.SuccessSnackBar(message: "Task page refreshed successfully".tr));
    }
    //selectedOngoingTask.value = ongoingTasks.isNotEmpty ? ongoingTasks.first : new Task();
  }

  Future<void> getCompletedTasks({bool showMessage = false}) async {
    completedTasks.value = await _taskRepository.getAll();
    if (showMessage) {
      Get.showSnackbar(
          Ui.SuccessSnackBar(message: "Task page refreshed successfully".tr));
    }
    //selectedCompletedTask.value = completedTasks.isNotEmpty ? completedTasks.first : new Task();
  }

  Future<void> getArchivedTasks({bool showMessage = false}) async {
    archivedTasks.value = await _taskRepository.getAll();
    if (showMessage) {
      Get.showSnackbar(
          Ui.SuccessSnackBar(message: "Task page refreshed successfully".tr));
    }
    //selectedArchivedTask.value = archivedTasks.isNotEmpty ? archivedTasks.first : new Task();
  }

}
