
import 'package:get/get.dart';
import 'package:itcase/app/models/tenders.dart';

import 'package:itcase/app/repositories/task_repository.dart';
import 'package:itcase/common/ui.dart';
class AccountSee{
  final id = "".obs;
  final name = "".obs;
  final email = "".obs;
  final numberAccomplishedTasks = "0".obs;
  final numberGivenTasks = "0".obs;
  final aboutMyself = "".obs;
  final _taskRepository = new TaskRepository();
  final image = "".obs;
  final phone = "".obs;
  final isContractor = false.obs;
  final statusOnline = false.obs;
  final permission = false.obs;
  void setValues(var currentUser, bool permission) {
    id.value = currentUser.value.id;
    name.value = currentUser.value.name ?? "";
    email.value = currentUser.value.email ?? " ";
    aboutMyself.value = currentUser.value.about_myself ?? " ";
    image.value = currentUser.value.image_gotten ?? " ";
    phone.value =currentUser.value.phone_number ?? " ";
    isContractor.value = currentUser.value.isContractor.value;
   this.permission.value = permission;
  }


  void  updateAccount() {
    id.value = "";
    name.value = "";
    email.value = "";
    numberAccomplishedTasks.value = "0";
    numberGivenTasks.value = "0";
    aboutMyself.value = "";
    image.value = "";
    permission.value = false;
    isContractor.value = false;
  }

  // Future<void> getOpenedTasks({bool showMessage = false}) async {
  //   try {
  //      myTenders.assignAll([]);
  //      myTenders.assignAll(await _taskRepository.getOpenedTenders(id:id.value));
  //      numberGivenTasks.value = myTenders.length.toString();
  //     if (showMessage) {
  //       Get.showSnackbar(
  //           Ui.SuccessSnackBar(message: "Task page refreshed successfully".tr));
  //     }
  //   } catch (e) {
  //     Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
  //   }
  // }

  // Future<void> getFinishedTasks({})
}