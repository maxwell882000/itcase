import 'dart:convert';

import 'package:itcase/app/providers/api.dart';
import 'package:get/get.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';

class ChatRepository {
//  User _userFromFirebaseUser(User user) {
//    return user != null ? User(uid: user.uid) : null;
//  }
  Future<Map> createChats(String json) async {
    final result = await API().post(json, 'account/chats');
    if (result.statusCode == 200) {
      return jsonDecode(result.body);
    }
    throw "Chat cannot be created".tr;
  }
  Future<List<Chat>> getAllChats() async {
    final response = await API().getData("messages/all_chats");
    final result = jsonDecode(response.body);
    print('sadsaddsdsadsadadasdas');
    print(result);
    if (response.statusCode ==200){

      return result.map<Chat>((e) => new Chat.fromJson(e)).toList();
    }

    throw "get All Chats";
  }
  Future<List<Message>> updatingChats(String chatId, String lastMessageGotten) async {
    final response = await API().getData("messages/" + chatId + "/" + lastMessageGotten);
    final body = jsonDecode(response.body);
    print(body);
    print(response.statusCode == 200);
    if (response.statusCode == 200) {
      return body.map<Message>((e) => new Message.fromJson(e)).toList().reversed.toList();
    }
    print(body);
    throw "updating Chats";
  }

  Future<List<Chat>> notificationChats()async{
    final response = await API().getData('messages/notificationLastMessages');
    final body = jsonDecode(response.body);

    if(response.statusCode == 200){
      return body.map<Chat>((e)=> new Chat.fromJson(e)).toList();
    }
    throw "notificationChats";
  }
  Future<bool> readSomeMessages(String messagesId) async{
    final response = await API().put(messagesId, "messages/read/messagesIsRead");
    print(response.body);
    if (response.statusCode ==200){
      return true;
    }
    return false;
  }
   Future<List> updateMessages(String listInt) async{
      final response = await API().post(listInt, "messages/read/messagesIsRead");
      print("MESSAGES GET");
      print(response.body);
      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }
      throw "Update Message errisNullOrBlank";
   }
   Future<bool> readMessage(String chatId)async {
    final response = await API().getData('messages/read/'+ chatId);
    print(response.body);
    if (response.statusCode == 200){
      print("messages are read");
      return true;
    }
    return false;
  }

  Future<List> getMessagesOfChat(String chatId) async {
    final response = await API().getData('account/chats/' + chatId);
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (body['chat']['data'].isEmpty){
        throw "";
      }

      List<Message> messages =
          body['chat']['data'].map<Message>((e) => new Message.fromJson(e)).toList();
      return [
        messages.reversed.toList(),
        body['chat']['last_page'],
        body['chat']['current_page']
      ];
    }
    print(body);
    throw "Get message of chat Error";
  }

  Future<void> sendMessage(String json, final message) async {
    final response = await API().post(json, 'messages');
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
       message.fromJsonSend(body);
       return;
    }
    print(body);
    throw "Send Message Error".tr;
  }
}
