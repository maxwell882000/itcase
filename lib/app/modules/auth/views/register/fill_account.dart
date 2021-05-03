import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:itcase/app/global_widgets/block_button_widget.dart';

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:itcase/app/modules/auth/controllers/account_fill_controller.dart';

import 'package:itcase/app/modules/auth/widgets/fill_data.dart';

// ignore: must_be_immutable
class FillAccount extends GetView<AuthFillController> {
  // final _currentUser = Get.find<AuthService>().user;
  File image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create account".tr,
          style: Get.textTheme.headline6
              .merge(TextStyle(color: context.theme.primaryColor)),
        ),
        centerTitle: true,
        backgroundColor: Get.theme.accentColor,
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
      ),
      body: ContainedTabBarView(
        tabBarProperties: TabBarProperties(
          labelColor: Get.theme.accentColor,
          unselectedLabelColor: Colors.black26,
        ),
        tabs: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Contractor'.tr,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('Consumer'.tr),
          )
        ],
        views: [
          contractor(context),
          customer(context),
        ],
        onChange: (index) {
          if (index == 0) {
            controller.tempUser.value.user_role = "contractor";
            controller.user.value.user_role = "contractor";
            controller.role.value = "contractor";
          } else {
            controller.tempUser.value.user_role = "customer";
            controller.user.value.user_role = "customer";
            controller.role.value = "customer";
          }
        },
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.vertical,
            children: [
              Obx(
                () => Visibility(
                  visible: !controller.loading.value,
                  child: SizedBox(
                    width: Get.width,
                    child: BlockButtonWidget(
                      onPressed: () {
                        controller
                            .fill_data_account(
                                controller.tempUser.value.user_role)
                            .then((value) => controller.loading.value = value);
                      },
                      color: Get.theme.accentColor,
                      text: Text(
                        "Зарегистрироваться".tr,
                        style: Get.textTheme.headline6
                            .merge(TextStyle(color: Get.theme.primaryColor)),
                      ),
                    ).paddingOnly(top: 15, bottom: 5, right: 20, left: 20),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget contractor(context) {
    controller.formKey.value = new GlobalKey<FormState>();
    controller.role.value = "contractor";
    return FillData(
      key: UniqueKey(),
    );
  }

  Widget customer(context) {
    controller.formKey.value = new GlobalKey<FormState>();
    controller.role.value = "customer";
    return FillData(
      key: UniqueKey(),
    );
  }
}
