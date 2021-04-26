import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/models/chat_model.dart';
import '../../../models/message_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_service.dart';
import '../../../../common/ui.dart';
import 'package:intl/intl.dart' show DateFormat;

class MessageItemWidget extends StatelessWidget {
  MessageItemWidget({Key key, this.chat, this.onDismissed}) : super(key: key);
  final Chat chat;
  final ValueChanged<Chat> onDismissed;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        Get.toNamed(Routes.CHAT, arguments: this.chat);
      },
      child: Dismissible(
        key: Key(this.chat.hashCode.toString()),
        background: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: Ui.getBoxDecoration(color: Colors.red),
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
        ),
        onDismissed: (direction) {
          onDismissed(this.chat);
          // Then show a snackbar.
          Get.showSnackbar(Ui.SuccessSnackBar(message: "The conversation with NAME is dismissed"));
        },
        child: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: Ui.getBoxDecoration(color: true ? Get.theme.primaryColor : Get.theme.accentColor.withOpacity(0.05)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: CachedNetworkImage(
                        height: 140,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl: chat.user.image_gotten,
                        // imageUrl: 'assets/img/loading.gif',
                        placeholder: (context, url) => Image.asset(
                          'assets/img/loading.gif',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 140,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error_outline),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 3,
                    right: 3,
                    width: 12,
                    height: 12,
                    child: Container(
                      decoration: BoxDecoration(
//                        color: widget.message.user.userState == UserState.available
//                            ? Colors.green
//                            : widget.message.user.userState == UserState.away ? Colors.orange : Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(width: 15),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            chat.user.name,
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            style: Get.textTheme.bodyText1
                                .merge(TextStyle(fontWeight: false ? FontWeight.w400 : FontWeight.w800)),
                          ),
                        ),
                        Text(
                          // DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(this.message.lastMessageTime, isUtc: true)),
                        chat.user.lastSeen,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: Get.textTheme.caption,
                        ),
                      ],
                    ),
                    if(!chat.lastMessage.isNull)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                        chat.lastMessage.text,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Get.textTheme.caption
                                .merge(TextStyle(fontWeight: true? FontWeight.w400 : FontWeight.w800)),
                          ),
                        ),
                        Obx(
                          ()=> Text(
                            // DateFormat('dd-MM-yyyy').format(DateTime.fromMillisecondsSinceEpoch(this.message.lastMessageTime, isUtc: true)),
                            chat.lastMessage.whenSended.value,
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            style: Get.textTheme.caption,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
