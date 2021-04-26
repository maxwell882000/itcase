import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itcase/app/models/tenders.dart';
import 'package:itcase/app/models/user_model.dart';
import 'package:itcase/app/repositories/task_repository.dart';
import 'package:itcase/app/repositories/user_repository.dart';
import 'package:itcase/app/services/auth_service.dart';
import 'package:itcase/common/pagination_tasks.dart';
import 'package:itcase/common/ui.dart';
import 'package:itcase/app/models/account_see.dart';

class GuestController extends GetxController {
  final UserRepository _userRepository = new UserRepository();
  var timer;
  final TaskRepository _taskRepository = new TaskRepository();
  final PaginationTasks paginationHelper = new PaginationTasks();
  var user = new User().obs;
  var accountSee;
  var  guestTenders;
  @override
  void onInit()  async{
    // if (Get.find<AuthService>().isAuth) Get.toNamed(Routes.ROOT);
    super.onInit();
    guestTenders = List<Tenders>().obs;
    accountSee = new AccountSee().obs;
    user.value = Get.arguments as User;
    accountSee.value.setValues(user, false);
    accountUpdate();
     getTenders();

  }
  void showMore({bool refresh = true}){
    getTenders(refresh: refresh);
  }
  @override
  void onClose() {
    accountSee = new AccountSee().obs;
    super.onClose();
  }


  Future accountUpdate() async {
    Map body = await _userRepository.getAccount(id: accountSee.value.id.toString());
    final user = new User.fromJson(body['user']).obs;
    this.user = user;

    accountSee.value.setValues(this.user, body['permission']);
  }

  Future getTenders({bool refresh = true})async{
    List data = await _taskRepository.getGuestTenders(accountSee.value.id.toString(),
          page: refresh ? '1' : paginationHelper.currentPage.value.toString());
    paginationHelper.getTasks(refresh: refresh,task: guestTenders, data: data);

    if(refresh)
      accountSee.value.numberGivenTasks.value = data.last.toString();
  }

  Future refreshAccount({bool showMessage = false}) async {
    try {
      await accountUpdate();
      getTenders();

      if (showMessage) {
        Get.showSnackbar(
            Ui.SuccessSnackBar(message: "User profile was successfully".tr));
      }
    } catch (e) {
      print(e);
      Get.showSnackbar(Ui.ErrorSnackBar(message: "Cannot be updated".tr));
    }
  }


}
