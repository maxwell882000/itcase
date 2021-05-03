import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/modules/messages/controllers/chats_controller.dart';
import 'package:itcase/app/routes/app_pages.dart';
import '../../../global_widgets/circular_loading_widget.dart';
import '../../../models/chat_model.dart';
import '../../../models/message_model.dart';
import '../controllers/messages_controller.dart';
import '../widgets/chat_message_item_widget.dart';

// ignore: must_be_immutable
class ChatsView extends GetView<ChatController> {
  final _myListKey = GlobalKey<AnimatedListState>();
  TextEditingController _chatController = TextEditingController();

  Widget chatList() {
    Widget result;

    if (!controller.isFetched.value) {
      result = CircularLoadingWidget(
        height: Get.height,
        onCompleteText: "Type a message to start chat!".tr,
      );
    } else {
      int length = controller.chat.value.message.value.length - 1;
      result = ListView.builder(
          key: _myListKey,
          controller: controller.paginationMessages.scrollController.value,
          physics: const AlwaysScrollableScrollPhysics(),
          reverse: true,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          itemCount: length + 2,
          shrinkWrap: false,
          itemBuilder: (context, index) {
            if (length + 1 == index) {
              return Obx(
                () => Visibility(
                  child: CircularLoadingWidget(
                    height: 50,
                  ),
                  visible: !controller.paginationMessages.isLast.value &&
                      length > 28,
                ),
              );
            }

            return ChatMessageItem(
              message: controller.chat.value.message.value[length - index],
            );
          });
    }
    return result;
  }

  Widget textAppBar(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 15),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
            onPressed: () {
              Get.back();
            }),
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.GUEST,
                    arguments: controller.chat.value.user);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                width: 42,
                height: 42,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(42)),
                  child: CachedNetworkImage(
                    width: double.infinity,
                    fit: BoxFit.cover,
                    imageUrl: controller.chat.value.user.image_gotten,
                    placeholder: (context, url) => Image.asset(
                      'assets/img/loading.gif',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error_outline),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textAppBar(controller.chat.value.user.name.split(' ')[1]),
                textAppBar(controller.chat.value.user.lastSeen),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Obx(() => chatList()),
          ),
          Container(
            decoration: BoxDecoration(
              color: Get.theme.primaryColor,
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).hintColor.withOpacity(0.10),
                    offset: Offset(0, -4),
                    blurRadius: 10)
              ],
            ),
            child: TextField(
              controller: _chatController,
              onChanged: (value) {
                controller.text.value = value;
                value = "";
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(20),
                hintText: "Type to start chat".tr,
                hintStyle:
                    TextStyle(color: Get.theme.focusColor.withOpacity(0.8)),
                suffixIcon: IconButton(
                  padding: EdgeInsets.only(right: 30),
                  onPressed: () {
                    if (controller.text.value.isNotEmpty) {
                      _chatController.clear();
                      Message message =
                          new Message(text: controller.text.value);
                      controller.text.value = "";
                      controller.chat.value.message.add(message);
                      controller.sendMessage(message);
                    }
                  },
                  icon: Icon(
                    Icons.send_outlined,
                    color: Theme.of(context).accentColor,
                    size: 30,
                  ),
                ),
                border: UnderlineInputBorder(borderSide: BorderSide.none),
                enabledBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none),
                focusedBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          )
        ],
      ),
    );
  }
}
