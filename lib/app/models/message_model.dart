import 'package:itcase/app/models/parents/model.dart';
import 'package:get/get.dart';
import 'user_model.dart';

class Message extends Model {
  int user_id;
  String text;
  final whenSended = "".obs;
  final isRead = false.obs;
  final isSend = false.obs;

  Message({this.user_id, this.text});

  Message.fromJson(Map json) {
    user_id = json['user_id'];
    text = json['text'];
    whenSended.value = json['created_at'];
    isRead.value = json['read'] == 1;
    isSend.value = true;
    super.fromJson({'id': json['id'].toString()});
  }

   fromJsonSend(Map json) {
    whenSended.value = json['created_at'];
    isSend.value = true;
    super.fromJson({'id':json['id'].toString()});
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "text": text,
    };
  }

}
