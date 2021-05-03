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

class MessagesController extends GetxController {
  // var message = Message([]).obs;
  ChatRepository _chatRepository;

  // AuthService _authService;
  var chats = List<Chat>().obs;

  // final chatTextController = TextEditingController();

  MessagesController() {
    _chatRepository = new ChatRepository();
    // _authService = Get.find<AuthService>();
  }

  @override
  void onInit() async {
    //await createMessage(new Message([_authService.user.value], id: UniqueKey().toString(), name: 'First Chat'));

    await getChats();

    super.onInit();
  }

  @override
  void onClose() {
    // chatTextController.dispose();
  }

  Future getChats() async {
    try {
      chats.value = await _chatRepository.getAllChats();
      print(chats);
    } catch (e) {
      chats.value = [];
      return Get.showSnackbar(
          Ui.ErrorSnackBar(title: "Error".tr, message: e.toString()));
    }
  }
}
