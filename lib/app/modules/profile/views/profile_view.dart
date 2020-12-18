import 'dart:convert';
import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../../global_widgets/text_field_widget.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final bool hideAppBar;
  final GlobalKey<FormState> _profileForm = new GlobalKey<FormState>();

  ProfileView({this.hideAppBar = false}) {
    // controller.profileForm = new GlobalKey<FormState>();
  }
  File image;

  _imgFromCamera() async {
    // ignore: deprecated_member_use
    image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 70);
    final img = image.readAsBytesSync();
    controller.user.value.image = "data:image/jpeg;base64," + base64Encode(img);

    // Get.showSnackbar(Ui.SuccessSnackBar(message: "Image selected.".tr));
  }

  _imgFromGallery() async {
    // ignore: deprecated_member_use
    image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 70);
    // controller.avatar = image;
    _cropImage(image);

    // Get.showSnackbar(Ui.SuccessSnackBar(message: "Image selected.".tr));
  }

  _cropImage(filePath) async {
    File croppedImage = await ImageCropper.cropImage(
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
    );
    final img = croppedImage.readAsBytesSync();
    controller.user.value.image = "data:image/jpeg;base64," + base64Encode(img);
    controller.avatar.value = base64Encode(img);
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        _imgFromGallery();
                        Get.back();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                leading: new IconButton(
                  icon: new Icon(Icons.arrow_back_ios,
                      color: Get.theme.hintColor),
                  onPressed: () => Get.back(),
                ),
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
                    controller.saveProfileForm(_profileForm);
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
                  controller.resetProfileForm(_profileForm);
                },
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Get.theme.hintColor.withOpacity(0.1),
                child: Text("Reset".tr, style: Get.textTheme.bodyText2),
              ),
            ],
          ).paddingSymmetric(vertical: 10, horizontal: 20),
        ),
        body: Form(
          key: _profileForm,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Profile details".tr, style: Get.textTheme.headline5)
                    .paddingOnly(top: 25, bottom: 0, right: 22, left: 22),
                Text("Change the following details and save them".tr,
                        style: Get.textTheme.caption)
                    .paddingSymmetric(horizontal: 22, vertical: 5),
                InkWell(
                  onTap: () {
                    showPicker(context);
                  },
                  child: CircleAvatar(
                    radius: 75,
                    child: controller.avatar == null
                        ? Icon(Icons.camera)
                        : Obx(() {
                            return Image.memory(
                              base64Decode(controller.avatar.value),
                              fit: BoxFit.cover,
                              // height: MediaQuery.of(context).size.height * 0.3,
                            );
                          }),
                  ),
                ),
                TextFieldWidget(
                  onSaved: (input) => controller.user.value.name = input,
                  validator: (input) => input.length < 3
                      ? "Should be more than 3 letters".tr
                      : null,
                  initialValue: controller.user.value.name,
                  hintText: "Enter your fullname".tr,
                  labelText: "Full Name".tr,
                  iconData: Icons.person_outline,
                ),
                TextFieldWidget(
                  onSaved: (input) => controller.user.value.email = input,
                  validator: (input) =>
                      !input.contains('@') ? "Should be a valid email" : null,
                  initialValue: controller.user.value.email,
                  hintText: "example@gmail.com",
                  labelText: "Email".tr,
                  iconData: Icons.alternate_email,
                ),
                TextFieldWidget(
                  keyboardType: TextInputType.phone,
                  onSaved: (input) =>
                      controller.user.value.phone_number = input,
                  validator: (input) => !input.startsWith('+')
                      ? "Phone number must start with country code!".tr
                      : null,
                  initialValue: controller.user.value.phone_number,
                  hintText: "+1 565 6899 659",
                  labelText: "Phone number".tr,
                  iconData: Icons.phone_android_outlined,
                ),
                InkWell(
                  onTap: () async {
                    var datePicked = await DatePicker.showSimpleDatePicker(
                      context,
                      initialDate: DateTime(1994),
                      firstDate: DateTime(1960),
                      lastDate: DateTime(2012),
                      dateFormat: "dd-MMMM-yyyy",
                      locale: DateTimePickerLocale.en_us,
                      looping: true,
                    );
                    controller.birthday.value =
                        DateFormat('d.MM.yyyy').format(datePicked);
                    controller.user.value.birthday_date =
                        DateFormat('dd.MM.yyyy').format(datePicked);
                  },
                  child: Obx(
                    () {
                      return Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            color: Get.theme.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Get.theme.focusColor.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: Offset(0, 5)),
                            ],
                            border: Border.all(
                                color: Get.theme.focusColor.withOpacity(0.05))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Date of birthday",
                              style: Get.textTheme.bodyText1,
                              textAlign: TextAlign.start,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.event_available,
                                  color: Get.theme.focusColor,
                                ).paddingOnly(right: 15),
                                Text(controller.birthday.value.toString()),
                              ],
                            ).marginSymmetric(vertical: 10),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                TextFieldWidget(
                  onSaved: (input) => controller.user.value.city = input,
                  validator: (input) => input.length < 3
                      ? "Should be more than 3 letters".tr
                      : null,
                  initialValue: controller.user.value.city,
                  hintText: "123 Street, City 136, State, Country".tr,
                  labelText: "Address".tr,
                  iconData: Icons.map_outlined,
                ),
                Row(
                  children: [
                    Text(
                      "Personal data processing agreement".tr,
                      style:
                          TextStyle(color: Get.theme.focusColor, fontSize: 12),
                    ),
                    Obx(() {
                      return Switch(
                        onChanged: (val) {
                          controller.agree.value = val;
                        },
                        value: controller.agree.value,
                      );
                    }),
                  ],
                ).paddingOnly(left: 30),
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
                    isFirst: true,
                    isLast: false,
                  );
                }),
                Obx(() {
                  return TextFieldWidget(
                    labelText: "New Password".tr,
                    hintText: "••••••••••••".tr,
                    obscureText: controller.hidePassword.value,
                    iconData: Icons.lock_outline,
                    keyboardType: TextInputType.visiblePassword,
                    isFirst: false,
                    isLast: false,
                  );
                }),
                Obx(() {
                  return TextFieldWidget(
                    labelText: "Confirm New Password".tr,
                    hintText: "••••••••••••".tr,
                    obscureText: controller.hidePassword.value,
                    iconData: Icons.lock_outline,
                    keyboardType: TextInputType.visiblePassword,
                    isFirst: false,
                    isLast: true,
                  );
                }),
              ],
            ),
          ),
        ));
  }
}
