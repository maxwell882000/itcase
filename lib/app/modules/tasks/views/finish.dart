import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/modules/account/widgets/account_link_widget.dart';

import 'package:itcase/app/routes/app_pages.dart';


class TaskFinish extends StatelessWidget {
  final bool hideAppBar;

  TaskFinish({this.hideAppBar = false}) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(30),
                margin: EdgeInsets.only(top: 0, left: 20, right: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Get.theme.accentColor,
                    boxShadow: [
                      BoxShadow(
                          color: Get.theme.focusColor.withOpacity(0.2),
                          blurRadius: 20,
                          offset: Offset(0, 10)),
                    ],
                    border: Border.all(
                        color: Get.theme.focusColor.withOpacity(0.3))),
                child: Column(
                  children: [
                    Text(
                      "Thank you for entrusting your task to Itcase.com, now the performers see your task and will soon start offering their services to you",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(20),
                width: Get.width * 0.7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    // color: Get.theme.accentColor,
                    boxShadow: [
                      BoxShadow(
                          color: Get.theme.focusColor.withOpacity(0.2),
                          blurRadius: 20,
                          offset: Offset(0, 10)),
                    ],
                    border: Border.all(
                      color: Get.theme.focusColor.withOpacity(0.3),
                    )),
                child: AccountLinkWidget(
                  icon: Icon(Icons.album, color: Get.theme.accentColor),
                  text: Text(
                    "Go to assignment".tr,
                    style: TextStyle(
                      color: Get.theme.accentColor,
                    ),
                  ),
                  onTap: (e) async {
                    Get.toNamed(Routes.MY_TASKS);
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
