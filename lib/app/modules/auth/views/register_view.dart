import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_widgets/block_button_widget.dart';
import '../../../global_widgets/text_field_widget.dart';
import '../../../models/setting_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/settings_service.dart';
import '../controllers/auth_controller.dart';

class RegisterView extends GetView<AuthController> {
  // final _currentUser = Get.find<AuthService>().user;
  final Setting _settings = Get.find<SettingsService>().setting.value;
  final GlobalKey<FormState> signupForm = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('Are you sure you want to exit?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  FlatButton(
                    child: Text('Yes, exit'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              );
            });

        return value == true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Register".tr,
            style: Get.textTheme.headline6
                .merge(TextStyle(color: context.theme.primaryColor)),
          ),
          centerTitle: true,
          backgroundColor: Get.theme.accentColor,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: Form(
          key: signupForm,
          child: ListView(
            primary: true,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    height: 120,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Get.theme.accentColor,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            color: Get.theme.focusColor.withOpacity(0.2),
                            blurRadius: 10,
                            offset: Offset(0, 5)),
                      ],
                    ),
                    margin: EdgeInsets.only(bottom: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            "Let's create your account!".tr,
                            style: Get.textTheme.headline6.merge(TextStyle(
                                color: Get.theme.primaryColor, fontSize: 22)),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Registration step 1 of 2".tr,
                            style: Get.textTheme.caption.merge(
                                TextStyle(color: Get.theme.primaryColor)),
                            textAlign: TextAlign.center,
                          ),
                          // Text("Fill the following credentials to login your account", style: Get.textTheme.caption.merge(TextStyle(color: Get.theme.primaryColor))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              TextFieldWidget(
                labelText: "Fullname".tr,
                hintText: "Enter your fullname".tr,
                initialValue: controller.user.value.name,
                onSaved: (val) => controller.user.value.name = val,
                validator: (val) =>
                    val.length == 0 ? "Fullname error".tr : null,
                iconData: Icons.people_alt,
                isLast: false,
              ),
              TextFieldWidget(
                labelText: "Phone Number".tr,
                hintText: "+99899 1234567".tr,
                iconData: Icons.phone_android_outlined,
                keyboardType: TextInputType.phone,
                initialValue: controller.user.value.phone_number,
                onSaved: (val) => controller.user.value.phone_number = val,
                validator: (val) =>
                    val.startsWith("+") ? null : "Phone error".tr,
              ),
              TextFieldWidget(
                labelText: "Email Address".tr,
                hintText: "johndoe@gmail.com".tr,
                initialValue: controller.user.value.email,
                iconData: Icons.alternate_email,
                onSaved: (val) => controller.user.value.email = val,
                validator: (val) =>
                    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val)
                        ? null
                        : "Email error".tr,
                isFirst: true,
                isLast: false,
              ),
              Obx(() {
                return TextFieldWidget(
                  labelText: "Password".tr,
                  hintText: "••••••••••••".tr,
                  initialValue: null,
                  obscureText: controller.hidePassword.value,
                  iconData: Icons.lock_outline,
                  keyboardType: TextInputType.visiblePassword,
                  onSaved: (val) => controller.user.value.password = val,
                  validator: (val) => val.length < 8 ? "Error password" : null,
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.hidePassword.value =
                          !controller.hidePassword.value;
                    },
                    color: Theme.of(context).focusColor,
                    icon: Icon(controller.hidePassword.value
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined),
                  ),
                );
              }),
            ],
          ),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.vertical,
              children: [
                SizedBox(
                  width: Get.width,
                  child: BlockButtonWidget(
                    onPressed: () {
                      controller.step2(signupForm);
                    },
                    color: Get.theme.accentColor,
                    text: Text(
                      "Register".tr,
                      style: Get.textTheme.headline6
                          .merge(TextStyle(color: Get.theme.primaryColor)),
                    ),
                  ).paddingOnly(top: 15, bottom: 5, right: 20, left: 20),
                ),
                TextButton(
                  onPressed: () {
                    Get.offAllNamed(Routes.LOGIN);
                  },
                  child: Text("You already have an account?".tr),
                ).paddingOnly(bottom: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
