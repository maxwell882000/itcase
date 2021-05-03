  import 'dart:convert';

import 'package:get/get.dart';
import 'package:itcase/app/models/category_model.dart';
import 'package:itcase/app/models/tenders.dart';
import 'package:itcase/app/modules/category/controllers/categories_controller.dart';
import 'package:itcase/app/modules/search/controllers/search_controller.dart';
import 'package:itcase/app/providers/api.dart';
import 'package:itcase/app/repositories/category_repository.dart';
import 'package:itcase/common/pagination_helper.dart';
import 'package:itcase/common/pagination_tenders.dart';
import '../../../models/e_service_model.dart';
import '../../../models/task_model.dart';
import '../../../repositories/task_repository.dart';
import '../../../../common/ui.dart';

class TenderController extends GetxController {
  TaskRepository _taskRepository;
  var my_tasks = List<Tenders>().obs;
  var allTasks = List<Tenders>().obs;
  var availableTasks = List<Tenders>().obs;
  var currentTasks = List<Tenders>().obs;
  final task = new Tenders().obs;
  final PaginationTenders paginationHelper = new PaginationTenders();
  final isClicked = false.obs;
  Function showMore;

  // final selectedOngoingTask = Task().obs;
  // final selectedCompletedTask = Task().obs;
  // final selectedArchivedTask = Task().obs;

  @override
  void onInit() async {
    _taskRepository = new TaskRepository();
    showMore = getTenders;
    paginationHelper.addingListener(controller: this);
    await getTenders();
    super.onInit();
  }

  void setShowMore(Function showMore) {
    this.showMore = showMore;
    update();
  }

  Function getMore() {
    return this.showMore();
  }


  Future refreshTasks({bool showMessage = false, bool refresh = true}) async {
    await getTenders();
    await getAvailableTenders();
    if (showMessage) {
      Get.showSnackbar(
          Ui.SuccessSnackBar(message: "Task page refreshed successfully".tr));
    }
  }





  Future<void> getTenders(
      {bool showMessage = false, bool refresh = true}) async {
    List data = await _taskRepository.getTenders(
        page: refresh ? '1' : paginationHelper.currentPage.value.toString());
    currentTasks.value = paginationHelper.processData(refresh: refresh,tenders: allTasks, data: data);
    if (showMessage) {
      Get.showSnackbar(
          Ui.SuccessSnackBar(message: "Task page refreshed successfully".tr));
    }
    //selectedOngoingTask.value = ongoingTasks.isNotEmpty ? ongoingTasks.first : new Task();
  }



  Future<void> getAvailableTenders(
      {bool showMessage = false, bool refresh = true}) async {
    List data = await _taskRepository.getAvailableTenders(
        page: refresh ? '1' : paginationHelper.currentPage.value.toString());
    currentTasks.value = paginationHelper.processData(refresh: refresh,tenders: availableTasks, data: data);

    if (showMessage) {
      Get.showSnackbar(
          Ui.SuccessSnackBar(message: "Task page refreshed successfully".tr));
    }
    //selectedArchivedTask.value = archivedTasks.isNotEmpty ? archivedTasks.first : new Task();
  }
}
