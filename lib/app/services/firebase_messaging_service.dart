import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/repositories/firebase_messagin_repository.dart';
import 'package:itcase/app/services/auth_service.dart';

class FireBaseService extends GetxService {
  FirebaseMessaging messaging;
  FirebaseApp firebase;
  FirebaseMessagingRepository _firebaseMessagingRepository =
      new FirebaseMessagingRepository();

  Future<FireBaseService> init() async {
    firebase = await Firebase.initializeApp();
    messaging = FirebaseMessaging.instance;
    requestPermission();
    await sendOrMissToken();
    listenStreamOnMessage();
    return this;
  }

  static Future<void> backGroundTasks(RemoteMessage message) async {
    await Firebase.initializeApp();
    print("IN THE BACK GROUND ");
    // AwesomeNotifications().createNotificationFromJsonData(message.data);
    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          title: 'Simple Notification',
          color: Colors.red,
          body: 'Simple body'
      ),
      actionButtons: [
        NotificationActionButton(
            key: "10",
            label: "Something",
            enabled: true,
            buttonType: ActionButtonType.InputField
        )
      ],
    );
  }

  void listenStreamOnMessage() {
    FirebaseMessaging.onMessage.listen((event) async {
      await Firebase.initializeApp();
      print("On Message ");
      print(event.data);
      AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            title: 'Simple Notification',
            body: 'Simple body'
        ),
        actionButtons: [
          NotificationActionButton(
              key: "10",
              label: "Something",
              enabled: true,
              buttonType: ActionButtonType.InputField
          )
        ],
      );
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      await Firebase.initializeApp();
      print("on Message Opened App");
      print(event.data);
    });
  }

  Future sendOrMissToken() async {
    AuthService service = Get.find<AuthService>();
    print('SEND OR MISS TOKEN');
    service.prefs.remove('message_token');
    if (!service.prefs.containsKey('message_token') &&
        service.user.value.auth) {
      // await messaging.deleteToken();
      String token = await messaging.getToken();
      print(token);
      bool result = await _firebaseMessagingRepository
          .sendMessageToken(jsonEncode({'token': token}));
      if (result) {
        service.prefs.setString('message_token', token);
      }
    }
  }

  Future requestPermission() async {
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
