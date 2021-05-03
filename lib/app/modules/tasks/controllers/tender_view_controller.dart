import 'dart:convert';

import 'package:get/get.dart';
import 'package:itcase/app/models/category_model.dart';
import 'package:itcase/app/models/chat_model.dart';
import 'package:itcase/app/models/tender_requests.dart';
import 'package:itcase/app/models/tenders.dart';
import 'package:itcase/app/modules/category/controllers/categories_controller.dart';
import 'package:itcase/app/repositories/category_repository.dart';
import 'package:itcase/app/repositories/chat_repository.dart';
import 'package:itcase/app/routes/app_pages.dart';
import 'package:itcase/app/services/auth_service.dart';
import '../../../models/e_service_model.dart';
import '../../../models/task_model.dart';
import '../../../repositories/task_repository.dart';
import '../../../../common/ui.dart';

class TenderViewController extends GetxController {
  TaskRepository _taskRepository;
  ChatRepository _chatRepository;
  final tender = new Tenders().obs;
  final tenderRequests = new List<TenderRequests>().obs;
  final currentUser = Get.find<AuthService>().user;
  final location = "".obs;
  final isOwner = false.obs;
  final status = true.obs;
  final chatId = 0.obs;
  final loading = false.obs;

  // final selectedOngoingTask = Task().obs;
  // final selectedCompletedTask = Task().obs;
  // final selectedArchivedTask = Task().obs;

  @override
  void onInit() async {
    _taskRepository = new TaskRepository();
    _chatRepository = new ChatRepository();
    tender.value = Get.arguments as Tenders;
    isOwner.value = tender.value.owner_id.toString() == currentUser.value.id;

    await getTender();
    await getLocation();
    await getOffers();
    super.onInit();
  }

  getLocation() async {
    if (tender.value.geo_location != null) {
      List loc = tender.value.geo_location.replaceAll(" ", '').split(",");

      location.value = await _taskRepository.getAddress(loc[0], loc[1]);
      print(location.value);
    }
  }

  getTender({bool showMessage = false}) async {
    tender(await _taskRepository.getTender(tender.value.id.toString()));
    status.value = tender.value.opened.value;
    if (showMessage) {
      Get.showSnackbar(
          Ui.SuccessSnackBar(message: "Task page refreshed successfully".tr));
    }
    //selectedOngoingTask.value = ongoingTasks.isNotEmpty ? ongoingTasks.first : new Task();
  }

  getOffers({bool showMessage = false}) async {
    print("TENDER ID " + tender.value.id.toString());
    tenderRequests.value = await _taskRepository
        .getTenderRequests(jsonEncode({'tender_id': tender.value.id}));
    print(tenderRequests.value);
    if (showMessage) {
      Get.showSnackbar(
          Ui.SuccessSnackBar(message: "Task page refreshed successfully".tr));
    }
    //selectedOngoingTask.value = ongoingTasks.isNotEmpty ? ongoingTasks.first : new Task();
  }

  void decline(String id) async {
    tenderRequests.value.removeWhere((element) => element.id == id);
    Map data = {
      'requestId': id,
      'rejected': true,
      'redirect_to': 'has',
    };
    try {
      final response = await _taskRepository.declineRequests(jsonEncode(data));
      Get.showSnackbar(Ui.SuccessSnackBar(
          message: response['success'], title: "Success".tr));
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e, title: "Error".tr));
    }
  }

  void accepts(String id) async {

    Map data = {'redirect_to': 'some'};
    tenderRequests.value.removeWhere((element) => element.id != id);
    tender.update((val) {
      val.contractor_id =  int.parse(tenderRequests.value.first.user.id);
    });
    status.value = false;
    try {
      final response = await _taskRepository.acceptRequests(
          jsonEncode(data), tender.value.id.toString(), id);
      await _chatRepository.createChats(
          jsonEncode({'with_user_id': tenderRequests.value.first.user.id}));
      Get.showSnackbar(Ui.SuccessSnackBar(
          message: response['success'], title: "Success".tr));
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e, title: "Error".tr));
    }
  }

  Future sendMessage(Chat chat) async {
    loading.value = true;
    try {
      print("HERE USER ID");
      print(chat.user.id);
      final result = await _chatRepository.createChats(
          jsonEncode({'with_user_id': chat.user.id}));
      chat.chatId = result['chat_id'];
      print(chat.chatId);
      Get.toNamed(Routes.CHAT, arguments: chat);
    } catch (e) {
      loading.value = false;
      Get.showSnackbar(Ui.ErrorSnackBar(
          message: "Sorry, now is impossible send message".tr, title: "Error".tr));
      return false;
    }
    loading.value = false;
  }

  Future refreshTasks({bool showMessage = false}) async {
    print("USER " + currentUser.value.id);
    await getTender();
    await getLocation();
    await getOffers();
    if (showMessage) {
      Get.showSnackbar(
          Ui.SuccessSnackBar(message: "Task page refreshed successfully".tr));
    }
  }

  Future deleteTender() async {
    loading.value = true;
    try{


      print(tender.value.delete_reason);
          tender.update((val) {
            val.opened.value = false;
          });
      final response = await _taskRepository.deleteTender(
          jsonEncode({'delete_reason': tender.value.delete_reason}), tender.value.id.toString());
     await Get.showSnackbar(
          Ui.SuccessSnackBar(message: response['success']));

      Get.back();
      Get.back(result: tender.value);
    }
    catch(e){
      print("DELETE TENDER");
      print(e);
    }
    loading.value = false;

  }

  Future updateTender() async {}
}
