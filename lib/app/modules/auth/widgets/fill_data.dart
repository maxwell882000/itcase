import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itcase/app/global_widgets/circular_loading_widget.dart';
import 'package:itcase/app/global_widgets/text_field_widget.dart';
import 'package:itcase/app/modules/auth/controllers/account_fill_controller.dart';
import 'package:itcase/app/modules/auth/controllers/auth_controller.dart';
import 'package:itcase/app/modules/auth/views/register/fill_account.dart';

class FillData extends StatelessWidget {
  final controller = Get.find<AuthFillController>();
  final String role;

  FillData({Key key, this.role}) : super(key: key);

  // user = Get.find<AuthService>().user;
  Last(child) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
      decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
          boxShadow: [
            BoxShadow(
                color: Get.theme.focusColor.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 5)),
          ],
          border: Border.all(color: Get.theme.focusColor.withOpacity(0.1))),
      child: child,
    );
  }

  imgFromCamera(id) async {
    // ignore: deprecated_member_use
    final image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 70);
    final img = image;
    controller.avatar.value = image.path;
    controller.user.value.image = image;
    controller.tempUser.value.image = image;
    controller.initialAvatar.value = false;
  }

  imgFromGallery(id) async {
    final image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 70);
    final img = image.readAsBytesSync();
    controller.avatar.value = image.path;
    controller.user.value.image = image;
    controller.tempUser.value.image = image;
    controller.initialAvatar.value = false;
    print("PATH IMAGES");
    print(controller.tempUser.value.image.path);
  }

  First(child) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
      decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
          boxShadow: [
            BoxShadow(
                color: Get.theme.focusColor.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 5)),
          ],
          border: Border.all(color: Get.theme.focusColor.withOpacity(0.1))),
      child: child,
    );
  }

  void showPicker(context, ind) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'.tr),
                      onTap: () {
                        imgFromGallery(ind);
                        Get.back();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.camera),
                    title: new Text('Camera'.tr),
                    onTap: () {
                      imgFromCamera(ind);
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  box(child) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      margin: EdgeInsets.only(top: 0, left: 20, right: 20),
      decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          boxShadow: [
            BoxShadow(
                color: Get.theme.focusColor.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 5)),
          ],
          border: Border.all(color: Get.theme.focusColor.withOpacity(0.1))),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> temp = GlobalKey<FormState>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.formKey.value = temp;
    });
    return Obx(
      () => Form(
        key: temp,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Fill Form".tr,
                style: TextStyle(
                    fontSize: 14,
                    color: Get.theme.focusColor,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ).paddingAll(20),
              First(
                Center(
                  child: InkWell(
                    onTap: () {
                      showPicker(context, 0);
                    },
                    child: CircleAvatar(
                      radius: 75,
                      backgroundColor: Get.theme.accentColor,
                      child: controller.avatar.value.isEmpty &&
                              controller.user.value.image_gotten == null
                          ? Icon(
                              Icons.add_a_photo,
                              size: 40,
                              color: Colors.white,
                            )
                          : controller.initialAvatar.value
                              ? ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(75)),
                                  child: CachedNetworkImage(
                                    height: 140,
                                    width: 140,
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        controller.user.value.image_gotten,
                                    placeholder: (context, url) => Image.asset(
                                      'assets/img/loading.gif',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 100,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error_outline),
                                  ),
                                )
                              : ClipOval(
                                  child: Image.file(
                                    controller.user.value.image,
                                    scale: 3,
                                    fit: BoxFit.cover,
                                    height: 140,
                                    width: 140,
                                  ),
                                ),
                    ),
                  ),
                ),
              ),
              TextFieldWidget(
                labelText: "Full name".tr,
                hintText: "Enter name".tr,
                onSaved: (val) {
                  controller.tempUser.value.name = val;
                },
                validator: (val) {
                 List list = val.split(RegExp(r"\s"));
                 list.removeWhere((element) => element==null|| element=="");
                  return val.length == 0
                    ? "Please, fill the field".tr
                    : list.length != 2
                        ? "Enter your surname and name separated by a space".tr
                        : null;},
                initialValue: controller.user.value.name,
                iconData: Icons.person_outline,
                isLast: false,
                isFirst: false,
              ),
              TextFieldWidget(
                labelText: "Phone number".tr,
                hintText: "+99899 1234567".tr,
                iconData: Icons.phone_android_outlined,
                keyboardType: TextInputType.phone,
                onSaved: (val) => controller.tempUser.value.phone_number = val,
                validator: (val) =>
                    val.length == 0 ? "Enter phone number".tr : null,
                initialValue: controller.user.value.phone_number,
                isLast: false,
                isFirst: false,
              ),
              TextFieldWidget(
                labelText: "Email".tr,
                hintText: "johndoe@gmail.com".tr,
                iconData: Icons.alternate_email,
                initialValue: controller.user.value.email,
                onSaved: (val) => controller.tempUser.value.email = val,
                validator: (val) =>
                    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val)
                        ? null
                        : "Enter email".tr,
                isFirst: false,
                isLast: false,
              ),
              TextFieldWidget(
                labelText: "City".tr,
                hintText: "Enter city".tr,
                iconData: Icons.map,
                initialValue: controller.user.value.city,
                validator: (val) => val.length == 0 ? "Enter city".tr : null,
                isLast: false,
                isFirst: false,
                onSaved: (val) => controller.tempUser.value.city = val,
              ),
              box(Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("You are".tr + ":"),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          title: Text("Individual".tr,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize:12
                              )),
                          value: "individual",
                          groupValue: controller.type.value,
                          onChanged: (val) {
                            controller.tempUser.value.type = val;
                            controller.type.value = val;
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          title: Text(
                            "Legal Entity".tr,
                            style: TextStyle(color: Colors.black,
                                fontSize: 12),
                          ),
                          value: "legal_entity",
                          groupValue: controller.type.value,
                          onChanged: (val) {
                            controller.type.value = val;
                            controller.tempUser.value.type = val;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              )),
              controller.type.value == "individual"
                  ? Column(
                      children: [
                        box(Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Gender".tr + ":"),
                            Row(
                              children: [
                                Expanded(
                                  child: RadioListTile(
                                    title: Text(
                                      "Male".tr,
                                      style: TextStyle(color: Colors.black,
                                          fontSize: 12),
                                    ),
                                    value: "male",
                                    groupValue: controller.gender.value,
                                    onChanged: (val) {
                                      controller.gender.value = val;
                                      controller.tempUser.value.gender = val;
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile(
                                    title: Text(
                                      "Female".tr,
                                      style: TextStyle(color: Colors.black,
                                          fontSize:12),
                                    ),
                                    value: "female",
                                    groupValue: controller.gender.value,
                                    onChanged: (val) {
                                      controller.gender.value = val;
                                      controller.tempUser.value.gender = val;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                        InkWell(
                          onTap: () async {
                            var datePicked =
                                await DatePicker.showSimpleDatePicker(
                              context,
                              initialDate: DateTime(1994),
                              firstDate: DateTime(1960),
                              lastDate: DateTime.now(),
                              dateFormat: "dd-MMMM-yyyy",
                              locale: DateTimePickerLocale.ru,
                              looping: true,
                            );
                            if (datePicked != null) {
                              controller.birthday.value =
                                  DateFormat('dd.MM.yyyy').format(datePicked);
                              controller.tempUser.value.birthday =
                                  DateFormat('dd.MM.yyyy').format(datePicked);
                            }
                            print(controller.tempUser.value.birthday);
                          },
                          child: Container(
                            padding: EdgeInsets.all(20),
                            margin: EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                color: Get.theme.primaryColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          Get.theme.focusColor.withOpacity(0.1),
                                      blurRadius: 10,
                                      offset: Offset(0, 5)),
                                ],
                                border: Border.all(
                                    color: Get.theme.focusColor
                                        .withOpacity(0.05))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "Date of birth".tr,
                                  style: Get.textTheme.bodyText1,
                                  textAlign: TextAlign.start,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.event_available,
                                      color: Get.theme.focusColor,
                                    ).paddingOnly(right: 15),
                                    Text(controller.birthday.value),
                                  ],
                                ).marginSymmetric(vertical: 10),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(children: [
                      TextFieldWidget(
                        labelText: "Company".tr,
                        hintText: "Name of company".tr,
                        iconData: Icons.home_repair_service,
                        initialValue: controller.user.value.company_name,
                        validator: (val) =>
                            val.length == 0 ? "Enter name of company".tr : null,
                        isLast: false,
                        isFirst: false,
                        onSaved: (val) =>
                              controller.tempUser.value.company_name = val,
                      ),
                    ]),
              TextFieldWidget(
                labelText: controller.type.value == "individual"
                    ? "About yourself".tr
                    : "About company".tr,
                hintText: controller.type.value == "individual"
                    ? "Write about yourself".tr
                    : "Write about company".tr,
                iconData: Icons.info,
                isLast: false,
                isFirst: false,

                initialValue: controller.user.value.about_myself,
                maxLine: 3,
                height: 10,
                onSaved: (val) => controller.tempUser.value.about_myself = val,
                validator: (val) => val.length > 6 ? null : "Fill the field".tr,
              ),
              Visibility(
                  visible: !controller.accountRegistered.value,
                  child: Last(Row(
                    children: [
                      Expanded(
                        child: Text("I agree to share with my data".tr),
                      ),
                      Switch(
                        value: controller.agree.value,
                        onChanged: (val) {
                          print(val);
                          controller.tempUser.value.agree_personal_data = val;
                          controller.agree.value = val;
                        },
                      ),
                    ],
                  ))),
            ],
          ),
        ),
      ),
    );
  }
}
