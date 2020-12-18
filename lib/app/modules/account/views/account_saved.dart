import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/modules/account/controllers/account_controller.dart';
import '../../../global_widgets/main_drawer_widget.dart';
import "../../root/controllers/root_controller.dart";

import '../../../global_widgets/block_button_widget.dart';

class AccountCreatedView extends GetView<AccountController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawerWidget(),
      /*appBar: AppBar(
        title: Text(
          "Success".tr,
          style: context.textTheme.headline6,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Get.theme.hintColor),
          onPressed: () => {Scaffold.of(context).openDrawer()},
        ),
        elevation: 0,
      ),*/
      body: Container(
        alignment: AlignmentDirectional.center,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Colors.green.withOpacity(1),
                            Colors.green.withOpacity(0.2),
                          ])),
                  child: Icon(
                    Icons.check,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    size: 90,
                  ),
                ),
                Positioned(
                  right: -30,
                  bottom: -50,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(0.15),
                      borderRadius: BorderRadius.circular(150),
                    ),
                  ),
                ),
                Positioned(
                  left: -20,
                  top: -50,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(0.15),
                      borderRadius: BorderRadius.circular(150),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 40),
            Text(
              "Thank you!".tr,
              textAlign: TextAlign.center,
              style: Get.textTheme.headline3,
            ),
            SizedBox(height: 10),
            Opacity(
              opacity: 0.3,
              child: Text(
                "Your account has been successfully created, you will be able to perform any actions.",
                textAlign: TextAlign.center,
                style: Get.textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildBlockButtonWidget(),
    );
  }

  Widget buildBlockButtonWidget() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Get.theme.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
              color: Get.theme.focusColor.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -5)),
        ],
      ),
      child: BlockButtonWidget(
          text: Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Search tasks".tr,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.headline6.merge(
                    TextStyle(color: Get.theme.primaryColor),
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios,
                  color: Get.theme.primaryColor, size: 20)
            ],
          ),
          color: Get.theme.accentColor,
          onPressed: () {
            Get.find<RootController>().changePageOutRoot(1);
          }).paddingOnly(bottom: 20, right: 20, left: 20),
    );
  }
}
