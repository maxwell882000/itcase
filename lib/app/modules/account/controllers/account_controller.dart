import 'dart:async';

import 'dart:io';

import 'package:get/get.dart';
import 'package:itcase/app/models/tenders.dart';
import 'package:itcase/app/repositories/task_repository.dart';

import 'package:itcase/app/repositories/user_repository.dart';
import 'package:itcase/app/services/auth_service.dart';

import 'package:itcase/common/pagination_tasks.dart';
import 'package:itcase/common/ui.dart';
import 'package:itcase/app/models/account_see.dart';
class AccountController extends GetxController {

  var currentUser;
  final PaginationTasks paginationHelper = new PaginationTasks();
  var currentTasks = List<Tenders>().obs;
  var onModification = List<Tenders>().obs;
  var archivedTasks = List<Tenders>().obs;
  var requestSendTasks = List<Tenders>().obs;
  var acceptedTasks = List<Tenders>().obs;
  Function showMore;
  final TaskRepository _taskRepository = new TaskRepository();
  var timer;


  var accountSee;
  void setShowMore(Function refresh){
    showMore = refresh;
    update();
  }

  @override
  void onInit() {
    // if (Get.find<AuthService>().isAuth) Get.toNamed(Routes.ROOT);
    super.onInit();
    currentUser = Get.find<AuthService>().user;
    accountSee = new AccountSee().obs;
    accountSee.value.setValues(currentUser,true);
    paginationHelper.addingListener(controller: this);
    showMore = () async{
      getOpenedTasks();
      getAcceptedTenders();
    };
    showMore();
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
  void onNextPage(Function nextPage){
    setShowMore(nextPage);
    paginationHelper.update();
  }
  Future getOpenedTasks({bool refresh = true})async{
    if(refresh)
    currentTasks.value = [];
    List data = await _taskRepository.getMyOpenedTenders(
        page: refresh ? '1' : paginationHelper.currentPage.value.toString());
    paginationHelper.getTasks(refresh: refresh,task: currentTasks, data: data);
    if(data.length == 4 && refresh)
     accountSee.value.numberGivenTasks.value = data.last.toString();

  }

  Future getArchivedTasks({bool refresh = true})async{
    if(refresh)
    archivedTasks.value = [];
    List data = await _taskRepository.getArchivedTasks(
        page: refresh ? '1' : paginationHelper.currentPage.value.toString());
    paginationHelper.getTasks(refresh: refresh,task: archivedTasks, data: data);
  }

  Future getModificationTasks({bool refresh = true})async{
    if(refresh)
      onModification.value = [];
    List data = await _taskRepository.getModificationTasks(
        page: refresh ? '1' : paginationHelper.currentPage.value.toString());
  paginationHelper.getTasks(refresh: refresh,task: onModification, data: data);
  }


  Future getAcceptedTenders({bool refresh = true})async{
    if(refresh)
      acceptedTasks.value = [];
    print(acceptedTasks.value);
    List data = await _taskRepository.getAcceptedTenders(
        page: refresh ? '1' : paginationHelper.currentPage.value.toString());
    print("ACCEPTED");
    print(data);
    paginationHelper.getTasks(refresh: refresh,task: acceptedTasks, data: data);

    if(data.length == 4 && refresh)
      accountSee.value.numberAccomplishedTasks.value = data.last.toString();
  }

  Future getRequestedTenders({bool refresh = true})async{
    if(refresh)
      requestSendTasks.value = [];
    List data = await _taskRepository.getRequestedTenders(
        page: refresh ? '1' : paginationHelper.currentPage.value.toString());
    paginationHelper.getTasks(refresh: refresh,task: requestSendTasks, data: data);
  }


  Future refreshAccount({bool showMessage = false}) async {
    currentUser = Get.find<AuthService>().user;

    try {
     accountSee.value.setValues(currentUser,true);
   await  getOpenedTasks();
    await  getAcceptedTenders();

      if (showMessage) {
            Get.showSnackbar(
                Ui.SuccessSnackBar(message: "User profile was successfully".tr));
      }
    }
    catch(e){
      Get.showSnackbar(
          Ui.SuccessSnackBar(message: "Cannot be updated".tr));
    }
  }


}
