import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationService extends GetxService {
  Future init() async {
    initializeNotification();
    requestPermission();
    setActionListener();
    return this;
  }

  void initializeNotification() {
    AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        null,
        [
          NotificationChannel(
              icon: 'resource://drawable/fennel.png',
              channelKey: 'basic_channel',
              playSound: true,
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel for basic tests',
              defaultColor: Color(0xFF9D50DD),
              ledColor: Colors.white)
        ]);
  }

  void requestPermission() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // Insert here your friendly dialog box before call the request method
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  void setActionListener() {
    AwesomeNotifications().actionStream.listen((receivedNotification) {
      print(receivedNotification.id);
    });
  }
}
