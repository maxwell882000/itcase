// import 'dart:async';
//
// import 'dart:io';
//
// import 'package:get/get.dart';
// import 'package:itcase/app/models/tenders.dart';
// import 'package:itcase/app/repositories/task_repository.dart';
//
// import 'package:itcase/app/repositories/user_repository.dart';
// import 'package:itcase/app/services/auth_service.dart';
//
// import 'package:itcase/common/pagination_tenders.dart';
// import 'package:itcase/common/ui.dart';
// import 'package:itcase/app/models/account_see.dart';
// class RequestsController extends GetxController {
//
//   var currentUser = Get.find<AuthService>().user;
//   final PaginationTasks paginationHelper = new PaginationTasks();
//
//
//   Function showMore;
//   final TaskRepository _taskRepository = new TaskRepository();
//   var timer;
//
//
//   final accountSee = new AccountSee().obs;
//   void setShowMore(Function refresh){
//     showMore = refresh;
//     update();
//   }
//
//   @override
//   void onInit() {
//     // if (Get.find<AuthService>().isAuth) Get.toNamed(Routes.ROOT);
//     super.onInit();
//     accountSee.value.setValues(currentUser,true);
//     getAcceptedTenders();
//     paginationHelper.addingListener(controller: this);
//     showMore = getAcceptedTenders;
//     timer = Timer.periodic(Duration(seconds: 2), (timer) async {
//       try {
//         final result = await InternetAddress.lookup('google.com');
//         if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//           accountSee.value.statusOnline.value = true;
//         }
//       } catch (_) {
//         accountSee.value.statusOnline.value = false;
//       }
//     }).obs;
//   }
//
//   @override
//   void onClose() {
//     timer.value.cancel();
//     super.onClose();
//   }
//
//   Future getAcceptedTenders({bool refresh = true})async{
//     List data = await _taskRepository.getAcceptedTenders(
//         page: refresh ? '1' : paginationHelper.currentPage.value.toString());
//     paginationHelper.getTasks(refresh: refresh,task: requestSendTasks, data: data);
//     print(data);
//     if(data.length == 4 && refresh)
//       accountSee.value.numberAccomplishedTasks.value = data.last.toString();
//
//   }
//
//   Future getModificationTasks({bool refresh = true})async{
//     List data = await _taskRepository.getModificationTasks(
//         page: refresh ? '1' : paginationHelper.currentPage.value.toString());
//     paginationHelper.getTasks(refresh: refresh,task: acceptedTasks, data: data);
//   }
//
//
//
// // final currentUser = Get.find<AuthService>().user;
//
// }
