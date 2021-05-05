import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:itcase/app/global_widgets/format.dart';
import 'package:itcase/app/models/message_model.dart';
import 'package:itcase/app/modules/messages/controllers/chats_controller.dart';
import 'package:itcase/app/modules/messages/controllers/messages_controller.dart';

import '../../../models/chat_model.dart';
import '../../../services/auth_service.dart';

class ChatMessageItem extends GetView<ChatController> {
  final Message message;

  ChatMessageItem({this.message});

  @override
  Widget build(BuildContext context) {
    return message.user_id != int.parse(controller.chat.value.user.id)
        ? getSentMessageLayout(context)
        : getReceivedMessageLayout(context);
  }

  Widget layout({Widget child = const SizedBox()}) {
    return new Flexible(
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Flexible(
            child: new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text(message.text,
                  style: Get.textTheme.bodyText1
                      .merge(TextStyle(color: Colors.white))),
            ),
          ),
          Align(
            heightFactor: 2,
            child: SizedBox(
              height: 5,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Text(
                      !message.isSend.value
                          ? ""
                          : Format.parseDate(message.whenSended.value,
                              Format.outputFormatMessages),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.visible,
                      style: Get.textTheme.bodyText1
                          .merge(TextStyle(color: Colors.white, fontSize: 10)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }

  Widget myLayout({Widget child = const SizedBox()}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: new Container(

                margin: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                child: new Text(message.text,
                textAlign: TextAlign.left,),
              ),
            ),
            child,
          ],
        ),
        Container(
          child: Align(
            child: Obx(
                  () => Text(
                !message.isSend.value
                    ? ""
                    : Format.parseDate(
                    message.whenSended.value, Format.outputFormatMessages),
                textAlign: TextAlign.start,
                overflow: TextOverflow.visible,
                style: Get.textTheme.bodyText1.merge(TextStyle(fontSize: 10)),
              ),
            ),
            widthFactor: 0.0,
            heightFactor: 0.0,
          ),
        margin: EdgeInsets.only(left: 12),
        ),
      ],
    );
  }

  Widget getSentMessageLayout(context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
            color: Get.theme.focusColor.withOpacity(0.2),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 17),
        margin: EdgeInsets.symmetric(vertical: 5),
        child: myLayout(
          child: Align(
            heightFactor: 0.05,
            child: Obx(
              () => !message.isSend.value
                  ? Icon(Icons.refresh, size: 12)
                  : !message.isRead.value
                      ? Icon(Icons.check, size: 12)
                      : SvgPicture.asset(
                          "assets/icon/messages/double_check.svg",
                          height: Get.height * 0.01,
                          width: Get.width * 0.01,
                          color: Get.theme.accentColor,
                        ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getReceivedMessageLayout(context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
            color: Get.theme.accentColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[layout()],
        ),
      ),
    );
  }
}
