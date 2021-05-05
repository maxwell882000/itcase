import 'dart:convert';

import 'package:get/get.dart';
import 'package:itcase/app/models/notifications/notification.dart';

import '../../../../common/ui.dart';

import '../../../repositories/notification_repository.dart';

class NotificationsController extends GetxController {
  final notifications = <NotificationBase>[].obs;
  NotificationRepository _notificationRepository;
  final loading = true.obs;
  NotificationsController() {
    _notificationRepository = new NotificationRepository();
  }

  @override
  void onInit() async {
    await refreshNotifications();
    super.onInit();
  }

  Future refreshNotifications({bool showMessage}) async {
    await getNotifications();
    if (showMessage == true) {
      Get.showSnackbar(Ui.SuccessSnackBar(
          message: "List of notifications refreshed successfully".tr));
    }
  }

  Future getNotifications() async {
    try {
      loading.value = true;
      notifications.value = await _notificationRepository.getNotificationAll();
      loading.value = false;
      notificationMarkAsRead();
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future notificationMarkAsRead() async {
    try {
      await _notificationRepository.markAsReadNotification();
    } catch (e) {
      print(e);
    }
  }

  Future notificationDelete(
      {NotificationBase notificationBase, int index}) async {
    notifications.removeAt(index);
    Map data = {'id': notificationBase.id};
    try {
      print(data);
      await _notificationRepository.deleteNotification(jsonEncode(data));

    } catch (e) {
      print(e);
      Get.showSnackbar(
          Ui.ErrorSnackBar(message: "Try later".tr, title: "Error".tr));
    }
  }
}
