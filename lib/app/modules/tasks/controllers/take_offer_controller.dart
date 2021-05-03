import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/models/category_model.dart';
import 'package:itcase/app/models/global_model.dart';
import 'package:itcase/app/models/tenders.dart';
import 'package:itcase/app/models/user_model.dart';
import 'package:itcase/app/modules/category/controllers/categories_controller.dart';
import 'package:itcase/app/repositories/category_repository.dart';
import 'package:itcase/app/services/auth_service.dart';
import '../../../models/e_service_model.dart';
import '../../../models/task_model.dart';
import '../../../repositories/task_repository.dart';
import '../../../../common/ui.dart';

class TakeOfferController extends GetxController {
  TaskRepository _taskRepository;
  final tender = new Tenders().obs;
  final comment = "".obs;
  final priceFrom = "".obs;
  final priceTo = "".obs;
  final dayFrom = "".obs;
  final dayTo = "".obs;
  final currentUser = Get.find<AuthService>().user;
  final loading = false.obs;
  // final selectedOngoingTask = Task().obs;
  // final selectedCompletedTask = Task().obs;
  // final selectedArchivedTask = Task().obs;

  @override
  void onInit() async {
    _taskRepository = new TaskRepository();
    tender.value = Get.arguments as Tenders;
    print(tender.value);
    super.onInit();
  }

  void send(GlobalKey<FormState> form) async {
    loading.value = true;
    if (form.currentState.validate()) {
      form.currentState.save();
      try {
        final result = await _taskRepository.sendRequest(this.toJson());
        await Get.showSnackbar(Ui.SuccessSnackBar(message: result['success']));
        Get.back();
        Get.back();
      } catch (e) {
        print(e);
        loading.value = false;
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: e['errors'], title: "Error".tr));
      }
    }
    loading.value = false;
  }

  toJson() {
    print(tender);
    print(Get.arguments);
    tender.value = Get.arguments as Tenders;
    print(currentUser);
    Map<String, dynamic> map = {
      'budget_from': priceFrom.value,
      'budget_to': priceTo.value,
      'period_to': dayTo.value,
      'period_from': dayFrom.value,
      'comment': comment.value,
      'tender_id': tender.value.id,
      'user_id': currentUser.value.id,
    };
    return jsonEncode(map);
  }
}
