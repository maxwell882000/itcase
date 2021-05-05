import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:itcase/app/global_widgets/block_button_widget.dart';
import 'package:itcase/app/global_widgets/circular_loading_widget.dart';
import 'package:itcase/app/global_widgets/text_field_widget.dart';
import 'package:itcase/app/models/setting_model.dart';
import 'package:itcase/app/modules/auth/controllers/register_controller.dart';
import 'package:itcase/app/routes/app_pages.dart';
import 'package:itcase/app/services/settings_service.dart';

class RegisterView extends GetView<RegisterController> {
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
                content: Text('Are you sure you want to exit?'.tr),
                actions: <Widget>[
                  FlatButton(
                    child: Text('No'.tr),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  FlatButton(
                    child: Text('Yes, exit'.tr),
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
        body: Stack(
          children: [
            Obx(() {
              print("INSIDE");
              print(controller.loading.value);
              return Visibility(
                visible: controller.loading.value,
                child: CircularLoadingWidget(
                  height: Get.height,
                  onCompleteText: "".tr,
                ),
              );
            }),
            Obx(
              () => Visibility(
                visible: !controller.loading.value,
                child: Form(
                  key: signupForm,
                  child: ListView(
                    primary: true,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Container(
                            height: 80,
                            width: Get.width,
                            // decoration: BoxDecoration(
                            //   color: Get.theme.accentColor,
                            //   image: DecorationImage(
                            //     image: AssetImage("assets/icon/itcase.jpg"),
                            //     fit: BoxFit.cover,
                            //   ),
                            //   borderRadius:
                            //       BorderRadius.vertical(bottom: Radius.circular(10)),
                            //   boxShadow: [
                            //     BoxShadow(
                            //         color: Get.theme.focusColor.withOpacity(0.2),
                            //         blurRadius: 10,
                            //         offset: Offset(0, 5)),
                            //   ],
                            // ),
                            margin: EdgeInsets.only(bottom: 50),
                            child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: SizedBox()
                            ),
                          ),
                          Container(
                            // decoration: Ui.getBoxDecoration(
                            //   radius: 100,
                            //   border:
                            //       Border.all(width: 5, color: Get.theme.primaryColor),
                            // ),
                            child: ClipRRect(
                              // borderRadius: BorderRadius.all(Radius.circular(100000000)),
                              child: SvgPicture.asset(
                                'assets/icon/logo_itcase_svg.svg',
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                "Let`s create account".tr,
                                style: Get.textTheme.headline6.merge(TextStyle(
                                    color: Get.theme.accentColor,
                                    fontSize: 22)),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Registrations step 1 out of 2".tr,
                                style: Get.textTheme.caption.merge(
                                    TextStyle(color: Get.theme.accentColor)),
                                textAlign: TextAlign.center,
                              ),
                              // Text("Fill the following credentials to login your account", style: Get.textTheme.caption.merge(TextStyle(color: Get.theme.primaryColor))),
                            ],
                          ),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 0.0),
                      ),
                      TextFieldWidget(
                        labelText: "Name and surname".tr,
                        hintText: "Enter name and surname".tr,
                        initialValue: controller.user.value.name,
                        onSaved: (val) => controller.user.value.name = val,
                        validator: (val) {
                          List list = val.split(RegExp(r"\s"));
                          list.removeWhere((element) => element==null|| element=="");
                          return val.length == 0
                              ? "Please, fill the field".tr
                              : list.length != 2
                              ? "Enter your surname and name separated by a space".tr
                              : null;},
                        iconData: Icons.people_alt,
                        isLast: false,
                      ),

                      TextFieldWidget(
                        labelText: "Phone number".tr,
                        hintText: "+99899 1234567".tr,
                        iconData: Icons.phone_android_outlined,
                        keyboardType: TextInputType.phone,
                        initialValue: controller.user.value.phone_number,
                        onSaved: (val) =>
                            controller.user.value.phone_number = val,
                        validator: (val) => val.startsWith("+")
                            ? null
                            : "Enter phone number".tr,
                      ),
                      TextFieldWidget(
                        labelText: "Email".tr,
                        hintText: "johndoe@gmail.com".tr,
                        initialValue: controller.user.value.email,
                        iconData: Icons.alternate_email,
                        onSaved: (val) => controller.user.value.email = val,
                        validator: (val) =>
                            RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val)
                                ? null
                                : "Enter e-mail".tr,
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
                          onSaved: (val) =>
                              controller.user.value.password = val,
                          validator: (val) =>
                              val.length < 8 ? "Error password" : null,
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
              ),
            ),
          ],
        ),
        bottomNavigationBar: Obx(
          () => Visibility(
            visible: !controller.loading.value,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  direction: Axis.vertical,
                  children: [
                    SizedBox(
                      width: Get.width,
                      child: BlockButtonWidget(
                        onPressed: () async {
                          await controller.register_account(signupForm);
                        },
                        color: Get.theme.accentColor,
                        text: Text(
                          "Register".tr,
                          style: Get.textTheme.headline6
                              .merge(TextStyle(color: Get.theme.primaryColor)),
                        ),
                      ).paddingOnly(top: 15, bottom: 20, right: 20, left: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            "You already have an account?".tr,
                            style: Get.textTheme.button,
                          ),
                        ),
                      SizedBox(
                        width: Get.width*0.2,
                      ),
                        TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.SETTINGS_LANGUAGE);
                          },
                          child: Text("Change language".tr, style: Get.textTheme.button,),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
