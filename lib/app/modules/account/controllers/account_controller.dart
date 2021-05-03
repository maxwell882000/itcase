import 'dart:async';
import 'dart:convert';

import 'dart:io';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:itcase/app/models/tenders.dart';
import 'package:itcase/app/repositories/task_repository.dart';

import 'package:itcase/app/repositories/user_repository.dart';
import 'package:itcase/app/services/auth_service.dart';

import 'package:itcase/common/pagination_tenders.dart';
import 'package:itcase/common/ui.dart';
import 'package:itcase/app/models/account_see.dart';

class AccountController extends GetxController {
  var currentUser;
  final PaginationTenders paginationHelper = new PaginationTenders();
  var currentTasks = <Tenders>[].obs;
  // var onModification = List<Tenders>().obs;
  var archivedTasks = <Tenders>[].obs;
  var requestSendTasks = <Tenders>[].obs;
  var acceptedTasks = <Tenders>[].obs;
  var invitedTasks = <Tenders>[].obs;
  Function showMore;
  final TaskRepository _taskRepository = new TaskRepository();
  var timer;

  var accountSee;

  void setShowMore(Function refresh) {
    showMore = refresh;
    update();
  }

  void initState() {
    currentUser = Get.find<AuthService>().user;
    accountSee = new AccountSee().obs;
    accountSee.value.setValues(currentUser, true);
    paginationHelper.addingListener(controller: this);
    showMore = () async {
      getOpenedTasks();
      getAcceptedTenders();
    };
    showMore();
  }

  @override
  void onInit() {
    // if (Get.find<AuthService>().isAuth) Get.toNamed(Routes.ROOT);
    super.onInit();
    initState();
    timer = Timer.periodic(Duration(seconds: 2), (timer) async {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          accountSee.value.statusOnline.value = true;
        }
      } catch (_) {
        accountSee.value.statusOnline.value = false;
      }
    }).obs;
  }

  @override
  void onClose() {
    timer.value.cancel();
    accountSee = new AccountSee();
    super.onClose();
  }

  void onNextPage(Function nextPage) {
    setShowMore(nextPage);
    paginationHelper.update();
  }

  Future getOpenedTasks({bool refresh = true}) async {
    if (refresh) currentTasks.value = [];
    List data = await _taskRepository.getMyOpenedTenders(
        page: refresh ? '1' : paginationHelper.currentPage.value.toString());
    paginationHelper.processData(refresh: refresh, tenders: currentTasks, data: data);
    if (data.length == 4 && refresh)
      accountSee.value.numberGivenTasks.value = data.last.toString();
  }

  Future getArchivedTasks({bool refresh = true}) async {
    if (refresh) archivedTasks.value = [];
    List data = await _taskRepository.getArchivedTasks(
        page: refresh ? '1' : paginationHelper.currentPage.value.toString());
    paginationHelper.processData(
        refresh: refresh, tenders: archivedTasks, data: data);
  }

  // Future getModificationTasks({bool refresh = true}) async {
  //   if (refresh) onModification.value = [];
  //   List data = await _taskRepository.getModificationTasks(
  //       page: refresh ? '1' : paginationHelper.currentPage.value.toString());
  //   paginationHelper.getTasks(
  //       refresh: refresh, task: onModification, data: data);
  // }

  Future getAcceptedTenders({bool refresh = true}) async {
    if (refresh) acceptedTasks.value = <Tenders>[];
    print(acceptedTasks.value);
    List data = await _taskRepository.getAcceptedTenders(
        page: refresh ? '1' : paginationHelper.currentPage.value.toString());
    print("ACCEPTED");
    print(data);
      paginationHelper.processData(
        refresh: refresh, tenders: acceptedTasks, data: data);

    if (data.length == 4 && refresh)
      accountSee.value.numberAccomplishedTasks.value = data.last.toString();
  }

  Future getRequestedTenders({bool refresh = true}) async {
    if (refresh) requestSendTasks.value = <Tenders>[];
    List data = await _taskRepository.getRequestedTenders(
        page: refresh ? '1' : paginationHelper.currentPage.value.toString());
    paginationHelper.processData(
        refresh: refresh, tenders: requestSendTasks, data: data);
  }

  Future getInvitedTenders({bool refresh = true}) async {
    if (refresh) requestSendTasks.value = <Tenders>[];
    List data = await _taskRepository.getInvitationTenders(
        page: refresh ? '1' : paginationHelper.currentPage.value.toString());
    paginationHelper.processData(
        refresh: refresh, tenders: invitedTasks, data: data);
  }

  Future<bool> acceptInvitation({Tenders tender})async{
    try {
      invitedTasks.removeWhere((element) => element.id==tender.id);
      final result = await _taskRepository.acceptInvitation(
          jsonEncode({'tenderId': tender.id})
      );
      Get.showSnackbar(
          Ui.SuccessSnackBar(message: result['success']));
      return true;
    }
    catch(e){

    }
    return false;
  }

  Future<bool> declineInvitation({Tenders tender})async{
    try{
      print(tender.id);
      invitedTasks.removeWhere((element) => element.id==tender.id);
        final result = await _taskRepository.declineInvitation(
            jsonEncode({'tenderId': tender.id})
        );
        print(result);
        Get.showSnackbar(
            Ui.SuccessSnackBar(message: result['success']));
        return true;
    }
    catch(e){

    }
    return false;
  }

  Future refreshAccount({bool showMessage = false}) async {
    currentUser = Get.find<AuthService>().user;

    try {
      accountSee.value.setValues(currentUser, true);
      await getOpenedTasks();
      await getAcceptedTenders();

      if (showMessage) {
        Get.showSnackbar(
            Ui.SuccessSnackBar(message: "User profile was successfully updated".tr));
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: "Cannot be updated".tr));
    }
  }
}
