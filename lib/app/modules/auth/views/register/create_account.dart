import 'dart:convert';
import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
// import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itcase/app/global_widgets/block_button_widget.dart';
import 'package:itcase/app/global_widgets/text_field_widget.dart';

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:itcase/app/modules/auth/controllers/auth_controller.dart';

// ignore: must_be_immutable
class CreateAccount extends GetView<AuthController> {
  // final _currentUser = Get.find<AuthService>().user;
  final GlobalKey<FormState> signupCustomer = new GlobalKey<FormState>();
  final GlobalKey<FormState> signupContractor = new GlobalKey<FormState>();

  File image;

  _imgFromCamera(id) async {
    // ignore: deprecated_member_use
    image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 70);
    final img = image.readAsBytesSync();
    controller.avatar.value = base64Encode(img);
    id == 0
        ? controller.contractor.value.image =
            "data:image/jpeg;base64," + base64Encode(img)
        : controller.customer.value.image =
            "data:image/jpeg;base64," + base64Encode(img);
  }

  _imgFromGallery(id) async {
    // ignore: deprecated_member_use
    image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 70);
    final img = image.readAsBytesSync();
    controller.avatar.value = base64Encode(img);

    id == 0
        ? controller.contractor.value.image =
            "data:image/jpeg;base64," + base64Encode(img)
        : controller.customer.value.image =
            "data:image/jpeg;base64," + base64Encode(img);
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
                      title: new Text('Gallery'),
                      onTap: () {
                        _imgFromGallery(ind);
                        Get.back();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera(ind);
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
      appBar: AppBar(
        title: Text(
          "Create an acount".tr,
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
              'Contractor',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('Customer'),
          )
        ],
        views: [
          contractor(context),
          customer(context),
        ],
        onChange: (index) {
          if (index == 0) {
            controller.user.value.user_role = "contractor";
            controller.role.value = "contractor";
          } else {
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
              SizedBox(
                width: Get.width,
                child: BlockButtonWidget(
                  onPressed: () async {
                    // Get.offAllNamed(Routes.PHONE_VERIFICATION);
                    // controller.deviceName = await deviceInfo();
                    // controller.signup(signupForm);
                    controller.role.value == "contractor"
                        ? controller.signup(
                            signupContractor, controller.role.value)
                        : controller.signup(
                            signupCustomer, controller.role.value);
                    print(controller.role.value);
                  },
                  color: Get.theme.accentColor,
                  text: Text(
                    "Register".tr,
                    style: Get.textTheme.headline6
                        .merge(TextStyle(color: Get.theme.primaryColor)),
                  ),
                ).paddingOnly(top: 15, bottom: 5, right: 20, left: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget contractor(context) {
    return Obx(() {
      return Form(
        key: signupContractor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Select your role and enter details. Without this, you will not be able to perform any actions.",
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
                      child: controller.avatar.value == "noavatar"
                          ? Icon(
                              Icons.add_a_photo,
                              size: 40,
                              color: Colors.white,
                            )
                          : ClipOval(
                              child: Image.memory(
                                base64Decode(controller.avatar.value),
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
                labelText: "Fullname".tr,
                hintText: "Enter your fullname".tr,
                onSaved: (val) {
                  controller.contractor.value.name = val;
                },
                validator: (val) =>
                    val.length == 0 ? "Fullname error".tr : null,
                initialValue: controller.user.value.name,
                iconData: Icons.person_outline,
                isLast: false,
                isFirst: false,
              ),
              TextFieldWidget(
                labelText: "Phone Number".tr,
                hintText: "+99899 1234567".tr,
                iconData: Icons.phone_android_outlined,
                keyboardType: TextInputType.phone,
                onSaved: (val) =>
                    controller.contractor.value.phone_number = val,
                validator: (val) => val.length == 0 ? "Phone error".tr : null,
                initialValue: controller.user.value.phone_number,
                isLast: false,
                isFirst: false,
              ),
              TextFieldWidget(
                labelText: "Email Address".tr,
                hintText: "johndoe@gmail.com".tr,
                iconData: Icons.alternate_email,
                initialValue: controller.user.value.email,
                onSaved: (val) => controller.contractor.value.email = val,
                validator: (val) =>
                    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val)
                        ? null
                        : "Email error".tr,
                isFirst: false,
                isLast: false,
              ),
              box(Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("You are:"),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          title: Text("Individual",
                              style: TextStyle(color: Colors.black)),
                          value: "individual",
                          groupValue: controller.type.value,
                          onChanged: (val) {
                            controller.contractor.value.contractor_type = val;
                            controller.type.value = val;
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          title: Text(
                            "Entity",
                            style: TextStyle(color: Colors.black),
                          ),
                          value: "legal_entity",
                          groupValue: controller.type.value,
                          onChanged: (val) {
                            controller.type.value = val;
                            controller.contractor.value.contractor_type = val;
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
                            Text("Gender:"),
                            Row(
                              children: [
                                Expanded(
                                  child: RadioListTile(
                                    title: Text(
                                      "Male",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    value: "male",
                                    groupValue: controller.gender.value,
                                    onChanged: (val) {
                                      controller.gender.value = val;
                                      controller.contractor.value.gender = val;
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile(
                                    title: Text(
                                      "Female",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    value: "female",
                                    groupValue: controller.gender.value,
                                    onChanged: (val) {
                                      controller.gender.value = val;
                                      controller.contractor.value.gender = val;
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
                              lastDate: DateTime(2012),
                              dateFormat: "dd-MMMM-yyyy",
                              locale: DateTimePickerLocale.en_us,
                              looping: true,
                            );
                            controller.birthday.value =
                                DateFormat('dd.MM.yyyy').format(datePicked);
                            controller.contractor.value.birthday =
                                DateFormat('d.m.y').format(datePicked);
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
                        labelText: "City".tr,
                        hintText: "Enter your address".tr,
                        iconData: Icons.map,
                        initialValue: controller.user.value.city,
                        validator: (val) =>
                            val.length == 0 ? "Fullname error".tr : null,
                        isLast: false,
                        isFirst: false,
                        onSaved: (val) => controller.user.value.city = val,
                      ),
                      TextFieldWidget(
                        labelText: "Company".tr,
                        hintText: "Enter your company name".tr,
                        iconData: Icons.home_repair_service,
                        initialValue: controller.contractor.value.company_name,
                        validator: (val) =>
                            val.length == 0 ? "Fullname error".tr : null,
                        isLast: false,
                        isFirst: false,
                        onSaved: (val) =>
                            controller.contractor.value.company_name = val,
                      ),
                    ]),
              TextFieldWidget(
                labelText: controller.type.value == "individual"
                    ? "About myself".tr
                    : "About company".tr,
                hintText: controller.type.value == "individual"
                    ? "About myself".tr
                    : "About company".tr,
                iconData: Icons.info,
                isLast: false,
                isFirst: false,
                keyboardType: TextInputType.multiline,
                initialValue: controller.contractor.value.about_myself,
                maxLine: 3,
                height: 10,
                onSaved: (val) =>
                    controller.contractor.value.about_myself = val,
                validator: (val) => val.length > 6 ? null : "Myself error".tr,
              ),
              Last(Row(
                children: [
                  Expanded(
                    child: Text("I agree to the processing of personal data"),
                  ),
                  Switch(
                    value: controller.agree.value,
                    onChanged: (val) {
                      controller.contractor.value.agree_personal_data = val;
                      controller.agree.value = val;
                    },
                  ),
                ],
              ))
            ],
          ),
        ),
      );
    });
  }

  Widget customer(context) {
    return Obx(() {
      return Form(
        key: signupCustomer,
        child: ListView(
          primary: true,
          children: [
            Text(
              "Select your role and enter details. Without this, you will not be able to perform any actions.",
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
                    backgroundColor: Get.theme.accentColor,
                    radius: 75,
                    child: controller.avatar.value == "noavatar"
                        ? Icon(
                            Icons.add_a_photo,
                            size: 40,
                            color: Colors.white,
                          )
                        : ClipOval(
                            child: Image.memory(
                              base64Decode(controller.avatar.value),
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
              labelText: "Fullname".tr,
              hintText: "Enter your fullname".tr,
              onSaved: (val) => controller.customer.value.name = val,
              initialValue: controller.customer.value.name,
              validator: (val) => val.length == 0 ? "Fullname error".tr : null,
              iconData: Icons.person_outline,
              isLast: false,
              isFirst: false,
            ),
            TextFieldWidget(
              labelText: "Phone Number".tr,
              hintText: "+99899 1234567".tr,
              iconData: Icons.phone_android_outlined,
              keyboardType: TextInputType.phone,
              onSaved: (val) => controller.customer.value.phone_number = val,
              initialValue: controller.user.value.phone_number,
              validator: (val) =>
                  val.length == 0 ? "Enter the phone number" : null,
              isLast: false,
              isFirst: false,
            ),
            TextFieldWidget(
              labelText: "Email Address".tr,
              hintText: "johndoe@gmail.com".tr,
              iconData: Icons.alternate_email,
              initialValue: controller.user.value.email,
              onSaved: (val) => controller.customer.value.email = val,
              validator: (val) =>
                  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(val)
                      ? null
                      : "Email error".tr,
              isFirst: false,
              isLast: false,
            ),
            box(Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("You are:"),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        title: Text(
                          "Individual",
                          style: TextStyle(color: Colors.black),
                        ),
                        value: "individual",
                        groupValue: controller.type.value,
                        onChanged: (val) {
                          controller.customer.value.customer_type = val;
                          controller.type.value = val;
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: Text(
                          "Entity",
                          style: TextStyle(color: Colors.black),
                        ),
                        value: "legal_entity",
                        groupValue: controller.type.value,
                        onChanged: (val) {
                          controller.customer.value.customer_type = val;
                          controller.type.value = val;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            )),
            controller.type.value == "individual"
                ? SizedBox(
                    height: 5,
                  )
                : Column(children: [
                    TextFieldWidget(
                      labelText: "Company".tr,
                      hintText: "Enter your company name".tr,
                      iconData: Icons.home_repair_service,
                      initialValue: controller.customer.value.company_name,
                      isLast: false,
                      isFirst: false,
                      onSaved: (val) =>
                          controller.customer.value.company_name = val,
                      validator: (val) =>
                          val.length == 0 ? "Enter the company name" : null,
                    ),
                    TextFieldWidget(
                      labelText: "City".tr,
                      hintText: "Enter your city".tr,
                      iconData: Icons.map,
                      initialValue: controller.user.value.city,
                      isLast: false,
                      isFirst: false,
                      onSaved: (val) => controller.user.value.city = val,
                      validator: (val) =>
                          val.length == 0 ? "Enter the City" : null,
                    ),
                  ]),
            TextFieldWidget(
              labelText: controller.type.value == "individual"
                  ? "About myself".tr
                  : "About company".tr,
              hintText: controller.type.value == "individual"
                  ? "About myself".tr
                  : "About company".tr,
              iconData: Icons.info,
              isLast: false,
              isFirst: false,
              keyboardType: TextInputType.multiline,
              maxLine: 3,
              height: 10,
              onSaved: (val) => controller.customer.value.about_myself = val,
              initialValue: controller.customer.value.about_myself,
              validator: (val) => val.length == 0 ? "Enter the info" : null,
            ),
            Last(Row(
              children: [
                Expanded(
                  child: Text("I agree to the processing of personal data"),
                ),
                Switch(
                  value: controller.agree.value,
                  onChanged: (val) {
                    controller.agree.value = val;
                    controller.customer.value.agree_personal_data = val;
                  },
                ),
              ],
            ))
          ],
        ),
      );
    });
  }

  // deviceInfo() async {
  //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //   return androidInfo.device;
  // }

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
}
