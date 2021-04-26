import 'package:get/get.dart';
import 'package:itcase/app/modules/messages/controllers/chats_controller.dart';
import 'package:itcase/app/modules/messages/controllers/messages_controller.dart';


class MessageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessagesController>(
          () => MessagesController(),
    );
    Get.lazyPut<ChatController>(
          () => ChatController(),
    );
  }
}
