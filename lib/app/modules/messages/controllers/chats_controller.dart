import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/providers/api.dart';
import 'package:itcase/common/ui.dart';
import '../../../models/chat_model.dart';
import '../../../services/auth_service.dart';

import '../../../models/message_model.dart';
import '../../../repositories/chat_repository.dart';
// import '../repository/notification_repository.dart';

class ChatController extends GetxController {
  // var message = Message([]).obs;
  ChatRepository _chatRepository;
  final text = "".obs;
  final messageLastRead = 0.obs;
  final isFetched = false.obs;

  // AuthService _authService;

  var chat = new Chat().obs;
  var timer;

  // final chatTextController = TextEditingController();

  ChatController() {
    _chatRepository = new ChatRepository();
    // _authService = Get.find<AuthService>();
  }

  @override
  void onInit() async {
    //await createMessage(new Message([_authService.user.value], id: UniqueKey().toString(), name: 'First Chat'));
    Chat chat = Get.arguments as Chat;

    print("EnTERED CHATS");
    this.chat.value = chat;
    this
        .chat
        .value
        .message
        .value
        .where((e) => !e.isRead.value && e.user_id == int.parse(chat.user.id))
        .forEach((element) => element.isRead.value = true);
    await getMessagesOfChat();
    await readAllMessages();
    periodicTask();

    super.onInit();
  }

  @override
  void onClose() {
    timer.value.cancel();
    super.onClose();
    // chatTextController.dispose();
  }

  Future periodicTask() async {
    this.timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      await updateChats();
      await updateMessages();
    }).obs;
  }

  Future updateChats() async {
    try {
      List<Message> response = await _chatRepository.updatingChats(
          chat.value.chatId.toString(), chat.value.message.value.last.id);
      print("RESPONSE GOTED");
      print(response);
      List list = chat.value.message.value
          .where((element) => !element.isSend.value)
          .toList();
      print(list);
      int index = -1;
      if (list.isNotEmpty) {
        Message message = list.first;
        print(response);
        index = chat.value.message.value.indexOf(message);
      }

      if (index != -1) {
        List<Message> first = chat.value.message.value.sublist(0, index);
        List<Message> second = chat.value.message.value.sublist(index);
        chat.value.message.value = first + response + second;
      } else {
        if (response.isNotEmpty) {
          chat.value.message.value = chat.value.message.value + response;
          await readAllMessages();
        }
      }
    } catch (e) {
      print("error");
      print(e);
    }
  }

  Future updateMessages() async {
    print("updating");
    List<Message> message = chat.value.message.value
        .sublist(messageLastRead.value)
        .where((e) =>
            !e.isRead.value && int.parse(chat.value.user.id) != e.user_id)
        .toList();
    if (message.isNotEmpty) {

      List<String> messages_id = message.map((e) => e.id).toList();
      try {
        List result = await _chatRepository
            .updateMessages(jsonEncode({"messages_id": messages_id}));
        print(result);
        result.forEach((elem) {
          message
              .where((element) => int.parse(element.id) == elem['id'])
              .forEach((element) {
            element.isRead.value = elem['read'] == 1;
          });
        });
        if(result.every((element) => element['read'] ==1)){
          messageLastRead.value =
              chat.value.message.value.indexOf(message.last);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future readAllMessages() async {
    try {
      print("message read");
      print(chat.value.chatId.toString());
      await _chatRepository.readMessage(chat.value.chatId.toString());
    } catch (e) {
      readAllMessages();
    }
  }

  Future getMessagesOfChat() async {
    try {
      List result =
          await _chatRepository.getMessagesOfChat(chat.value.chatId.toString());
      List<Message> message = result[0] as List<Message>;
      chat.value.message.value = chat.value.message.value + message;
    } catch (e) {
      print(e);
      if (e.isNotEmpty)
        Get.showSnackbar(
            Ui.ErrorSnackBar(title: "Error", message: e.toString()));
    }
    isFetched.value = true;
  }

  Future sendMessage(Message _message) async {
    try {
      await _chatRepository.sendMessage(
          jsonEncode({"chat_id": chat.value.chatId, "text": _message.text}),
          _message);
    } catch (e) {
      print(e);
      sendMessage(_message);
    }
  }
}
