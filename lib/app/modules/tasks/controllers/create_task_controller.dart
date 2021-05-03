import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:itcase/app/global_widgets/format.dart';
import 'package:itcase/app/models/category_model.dart';
import 'package:itcase/app/models/cateroies_drop_down.dart';
import 'package:itcase/app/models/global_model.dart';
import 'package:itcase/app/models/tenders.dart';
import 'package:itcase/app/modules/category/controllers/categories_controller.dart';
import 'package:itcase/app/repositories/category_repository.dart';
import 'package:itcase/app/routes/app_pages.dart';
import '../../../models/e_service_model.dart';
import '../../../models/task_model.dart';
import '../../../repositories/task_repository.dart';
import '../../../../common/ui.dart';

class CreateTasksController extends GetxController {
  final amount = "".obs;
  final place = 'У меня'.obs;
  final remote = false.obs;
  final List<String> placeItems = ['У меня'.tr, 'У исполнителя'.tr, 'Неважно'.tr];
  final List<String> placeKeys = ['my_place', 'contractor_place', 'dont_mind'];

  CategoriesDropDown categoriesDropDown;
  final textEditingController = new TextEditingController().obs;

  final tenders = new Tenders(
      remote: false,
      work_end_at: Format.parseDate(DateTime.now().toString(), Format.outputFormat),
      work_start_at: Format.parseDate(DateTime.now().toString(), Format.outputFormat),
          deadline: Format.parseDate(DateTime.now().toString(), Format.outputFormatDeadline),
      categories: []).obs;

  @override
  void onInit() async {
    categoriesDropDown = new CategoriesDropDown();
    textEditingController.value.text = tenders.value.budget;
    super.onInit();
  }

  validation() {
    if (tenders.value.categories.isEmpty) {
      return Get.showSnackbar(Ui.ErrorSnackBar(
          title: "Categories".tr, message: "Choose Category".tr));
    }
    if (tenders.value.work_start_at == null ||
        tenders.value.work_start_at.isEmpty) {
      return Get.showSnackbar(Ui.ErrorSnackBar(
          title: "Start Date".tr, message: "Choose Start Date".tr));
    }
    if (tenders.value.work_end_at == null ||
        tenders.value.work_end_at.isEmpty) {
      return Get.showSnackbar(Ui.ErrorSnackBar(
          title: "End Date".tr, message: "Choose End Date".tr));
    }
    if (tenders.value.deadline == null || tenders.value.deadline.isEmpty) {
      return Get.showSnackbar(Ui.ErrorSnackBar(
          title: "Deadline".tr, message: "Choose Deadline".tr));
    }
    if (tenders.value.place == null) {
      return Get.showSnackbar(
          Ui.ErrorSnackBar(title: "Place".tr, message: "Choose Place".tr));
    }
    if (tenders.value.budget == null || tenders.value.budget.isEmpty) {
      return Get.showSnackbar(Ui.ErrorSnackBar(
          title: "Cost of work".tr, message: "Please fill cost of work".tr));
    }
    return true;
  }

  submit_task(GlobalKey<FormState> form) async {
    print("sadasd");
    print(form.currentState.validate());
    if (form.currentState.validate()) {
      form.currentState.save();
      tenders.value.place = placeKeys[placeItems.indexOf(place.value)];
      print(tenders.value.toJsonOnCreate());
      if (validation() != true) {
        return validation();
      }
      Get.toNamed(Routes.MAP, arguments: tenders.value);
    }
  }
}
