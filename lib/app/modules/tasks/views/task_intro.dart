import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:itcase/app/routes/app_pages.dart';
import 'package:itcase/app/services/auth_service.dart';

class TaskIntro extends StatelessWidget {
  final bool hideAppBar;
  final GlobalKey<FormState> _profileForm = new GlobalKey<FormState>();
  final currentUser = Get.find<AuthService>().user;
  TaskIntro({this.hideAppBar = false}) {
    // controller.profileForm = new GlobalKey<FormState>();
  }

  var subcategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: hideAppBar
          ? null
          : AppBar(
              title: Text(
                "Additional".tr,
                style: context.textTheme.headline6,
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              leading: new IconButton(
                icon: new Icon(Icons.sort, color: Colors.black87),
                onPressed: () => {Scaffold.of(context).openDrawer()},
              ),
              elevation: 0,
            ),
      body: ListView(
        primary: true,
        children: [
          Text("Choose action".tr, style: Get.textTheme.headline5)
              .paddingOnly(top: 25, bottom: 0, right: 22, left: 22),
          Text("Change the following details and save them".tr,
                  style: Get.textTheme.caption)
              .paddingSymmetric(horizontal: 22, vertical: 5),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding:
                    EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
                margin: EdgeInsets.only(
                    top: Get.height * 0.25, left: 20, right: 20),
                decoration: BoxDecoration(
                    color: Get.theme.primaryColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          color: Get.theme.focusColor.withOpacity(0.6),
                          blurRadius: 10,
                          offset: Offset(0, 5)),
                    ],
                    border: Border.all(
                        color: Get.theme.focusColor.withOpacity(0.1))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      onPressed: () {
                        // Get.toNamed(Routes.CATEGORIES,
                        // arguments: {'who': 'create'});
                        Get.toNamed(Routes.CREATE_TASK);
                      },
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Get.theme.accentColor,
                      child: Text("Create a task".tr,
                          style: Get.textTheme.bodyText2
                              .merge(TextStyle(color: Get.theme.primaryColor))),
                    ),
                    SizedBox(height: 15.0),
                    Obx(
                   ()=> FlatButton(
                        onPressed: () {
                          Get.toNamed(Routes.BECOME_CONSTRUCTOR);
                        },
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Get.theme.primaryColorDark,
                        child: Text(currentUser.value.isContractor.value ? "Change categories".tr: "Become a contractor".tr,
                            style: Get.textTheme.bodyText2
                                .merge(TextStyle(color: Get.theme.primaryColor)
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
