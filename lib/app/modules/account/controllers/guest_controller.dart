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
import 'package:itcase/common/pagination_tenders.dart';
import 'package:itcase/common/ui.dart';
import 'package:itcase/app/models/account_see.dart';

class GuestController extends GetxController {
  final UserRepository _userRepository = new UserRepository();
  var timer;
  final TaskRepository _taskRepository = new TaskRepository();
  final PaginationTenders paginationHelper = new PaginationTenders();
  final acceptedTasks = <Tenders>[].obs;
  final user = new User().obs;
  Function showMore;
  var accountSee;
  var guestTenders;

  @override
  void onInit() async {
    // if (Get.find<AuthService>().isAuth) Get.toNamed(Routes.ROOT);
    super.onInit();
    guestTenders = List<Tenders>().obs;
    accountSee = new AccountSee().obs;
    user.value = Get.arguments as User;

    accountSee.value.setValues(user, false);
    paginationHelper.addingListener(controller: this);
    accountUpdate();
    getTenders();
    getAcceptedTenders();
  }

  void setShowMore(Function showMore) {
    this.showMore = showMore;
    update();
  }

  @override
  void onClose() {
    accountSee = new AccountSee().obs;
    super.onClose();
  }

  Future accountUpdate() async {
    Map body =
        await _userRepository.getAccount(id: accountSee.value.id.toString());
    final user = new User.fromJson(body['user']).obs;
    this.user(user.value);

    accountSee.value.setValues(user, body['permission']);
  }

  Future getTenders({bool refresh = true}) async {
    List data = await _taskRepository.getGuestTenders(
        accountSee.value.id.toString(),
        page: refresh ? '1' : paginationHelper.currentPage.value.toString());
    print(data);
    paginationHelper.processData(
        refresh: refresh, tenders: guestTenders, data: data);
    print(guestTenders);
    if (refresh) accountSee.value.numberGivenTasks.value = data.last.toString();
  }

  Future getAcceptedTenders({bool refresh = true}) async {
    if (refresh) acceptedTasks.value = <Tenders>[];
    String page =
        "${(refresh ? '1' : paginationHelper.currentPage.value.toString())}&user_id=${user.value.id}";
    List data = await _taskRepository.getAcceptedTenders(page: page);
    print(data);
    paginationHelper.processData(
        refresh: refresh, tenders: acceptedTasks, data: data);
    print(guestTenders);
    if (data.length == 4 && refresh)
      accountSee.value.numberAccomplishedTasks.value = data.last.toString();
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
