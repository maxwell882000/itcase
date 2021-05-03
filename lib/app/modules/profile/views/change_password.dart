import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/global_widgets/circular_loading_widget.dart';
import 'package:itcase/app/modules/auth/views/register/fill_account.dart';
import 'package:itcase/app/modules/auth/widgets/fill_data.dart';
import 'package:itcase/common/ui.dart';
import '../../../global_widgets/text_field_widget.dart';

import '../controllers/change_password_controller.dart';

class ChangePassword extends GetView<ChangePasswordController>{
  final bool hideAppBar;
  final GlobalKey<FormState> _passwordForm = new GlobalKey<FormState>();


  ChangePassword({this.hideAppBar = false}) {
    // controller.profileForm = new GlobalKey<FormState>();
  }
  @override
  Widget build(BuildContext context) {

    return Obx(
          ()=> Stack(
        children: [
          Visibility(
            visible: controller.loading.value,
            child: Scaffold(
              body: CircularLoadingWidget(
                height: Get.height,
                onCompleteText: "".tr,
              ),
            ),
          ),
          Visibility(
            visible: !controller.loading.value,
            maintainState: true,
            child: Scaffold(
                appBar: hideAppBar
                    ? null
                    : AppBar(
                  title: Text(
                    "Profile".tr,
                    style: context.textTheme.headline6,
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,

                  elevation: 0,
                ),
                bottomNavigationBar: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Get.theme.primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                          color: Get.theme.focusColor.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, -5)),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: FlatButton(
                          onPressed: () {
                            controller.changePassword(_passwordForm);
                            // controller.saveProfileForm(_profileForm);
                          },
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Get.theme.accentColor,
                          child: Text("Save".tr,
                              style: Get.textTheme.bodyText2
                                  .merge(TextStyle(color: Get.theme.primaryColor))),
                        ),
                      ),
                      SizedBox(width: 10),
                      FlatButton(
                        onPressed: () {
                          Get.back();
                        },
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Get.theme.hintColor.withOpacity(0.1),
                        child: Text("Back".tr, style: Get.textTheme.bodyText2),
                      ),
                    ],
                  ).paddingSymmetric(vertical: 10, horizontal: 20),
                ),
                body: Form(
                  key: _passwordForm,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text("Change password".tr, style: Get.textTheme.headline5)
                            .paddingOnly(top: 25, bottom: 0, right: 22, left: 22),
                        Text(
                            "Fill your old password and type new password and confirm it"
                                .tr,
                            style: Get.textTheme.caption)
                            .paddingSymmetric(horizontal: 22, vertical: 5),
                        Obx(() {
                          return TextFieldWidget(
                            labelText: "Old Password".tr,
                            hintText: "••••••••••••".tr,
                            obscureText: controller.hidePassword.value,
                            iconData: Icons.lock_outline,
                            keyboardType: TextInputType.visiblePassword,
                            onSaved: (val) => controller.oldPassword.value = val,
                            validator: (val) => val.isEmpty? "Field is required".tr :null,
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
                            isFirst: false,
                            isLast: false,
                          );
                        }),
                        Obx(() {
                          return TextFieldWidget(
                            labelText: "New Password".tr,
                            hintText: "••••••••••••".tr,
                            obscureText: controller.hideNewPassword.value,
                            onSaved: (val) => controller.newPassword.value = val,
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.hideNewPassword.value =
                                !controller.hideNewPassword.value;
                              },
                              color: Theme.of(context).focusColor,
                              icon: Icon(controller.hideNewPassword.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
                            ),
                            iconData: Icons.lock_outline,
                            validator: (val) => val.isEmpty? "Field is required".tr :null,
                            keyboardType: TextInputType.visiblePassword,
                            isFirst: false,
                            isLast: false,
                          );
                        }),

                        Obx(() {
                          return TextFieldWidget(
                            labelText: "Repeat Password".tr,
                            hintText: "••••••••••••".tr,
                            obscureText: controller.hideRepeatPassword.value,
                            onSaved: (val) => controller.repeatPassword.value = val,
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.hideRepeatPassword.value =
                                !controller.hideRepeatPassword.value;
                              },
                              color: Theme.of(context).focusColor,
                              icon: Icon(controller.hideRepeatPassword.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
                            ),
                            iconData: Icons.lock_outline,
                            validator: (val) => val.isEmpty? "Field is required".tr :null,
                            keyboardType: TextInputType.visiblePassword,
                            isFirst: false,
                            isLast: false,
                          );
                        }),


                      ],
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }

}