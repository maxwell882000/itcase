import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/models/category_model.dart';
import 'package:itcase/app/modules/tasks/controllers/tasks_controller.dart';
import 'package:itcase/app/routes/app_pages.dart';

class TaskIntro extends GetView<TasksController> {
  final bool hideAppBar;
  final GlobalKey<FormState> _profileForm = new GlobalKey<FormState>();

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
                "Select your choice".tr,
                style: context.textTheme.headline6,
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () => Get.back(),
              ),
              elevation: 0,
            ),
      body: ListView(
        primary: true,
        children: [
          Text("Profile details".tr, style: Get.textTheme.headline5)
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
                    FlatButton(
                      onPressed: () {},
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Get.theme.primaryColorDark,
                      child: Text("Become a performer".tr,
                          style: Get.textTheme.bodyText2
                              .merge(TextStyle(color: Get.theme.primaryColor))),
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
