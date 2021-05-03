import 'package:flutter/material.dart';
import 'package:itcase/app/models/message_model.dart';

import 'package:itcase/app/models/parents/model.dart';
import 'package:get/get.dart';
import 'user_model.dart';

class Chat {
  int chatId;
  User user;
  final unread = 0.obs;
  final message = List<Message>().obs;
  Message lastMessage;

  Chat({this.chatId, this.user, this.lastMessage});

  Chat.fromJson(Map<String, dynamic> json) {
    chatId = json['chat_id'];

    user = User.fromJsonRequests(json['user']);
    unread.value = json['unread'];
    if (json['last_message'] != null)
    lastMessage = Message.fromJson(json['last_message']);
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
// String id = UniqueKey().toString();
// // message text
// String text;
// int chatId;
// // time of the message
// int time;
// // user id who send the message
// String userId;
//

//
// Chat(this.text, this.time, this.userId);
//
// Chat.fromDocumentSnapshot( jsonMap) {
//   try {
//     id = jsonMap.id;
//     text = jsonMap.get('text') != null ? jsonMap.get('text').toString() : '';
//     time = jsonMap.get('time') != null ? jsonMap.get('time') : 0;
//     userId =
//         jsonMap.get('user') != null ? jsonMap.get('user').toString() : null;
//   } catch (e) {
//     id = null;
//     text = '';
//     time = 0;
//     user = null;
//     userId = null;
//     print(e);
//   }
// }
//
// @override
// Map<String, dynamic> toJson() {
//   var map = new Map<String, dynamic>();
//   map["id"] = id;
//   map["text"] = text;
//   map["time"] = time;
//   map["user"] = userId;
//   return map;
// }
}
