import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_widgets/circular_loading_widget.dart';
import '../../../services/auth_service.dart' show AuthService;
import '../controllers/messages_controller.dart';
import '../widgets/message_item_widget.dart';

class MessagesView extends GetView<MessagesController> {
  Widget conversationsList() {
    return ListView.separated(
        itemCount: controller.chats.value.length,
        separatorBuilder: (context, index) {
          return SizedBox(height: 7);
        },
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          // Message _message = _messages.elementAt(index);
          // printInfo(info: _message.toMap().toString());

          return MessageItemWidget(
            chat: controller.chats.value[index],
            onDismissed: (conversation) {
              controller.chats.value[index];
            },
          );
        });
  }

  @override
  GetPageBuilder OnPageDispose() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chats".tr,
          style: Get.textTheme.headline6,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_outlined, color: Get.theme.hintColor),
          onPressed: () => {Get.back()},
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            Visibility(
              visible: controller.chats.value.isEmpty,
              child: CircularLoadingWidget(
                height: Get.height,
                onCompleteText: "Messages List Empty".tr,
              ),
            ),
            Visibility(
              visible: controller.chats.value.isNotEmpty,
              child: ListView(
                primary: false,
                children: <Widget>[
                  conversationsList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
