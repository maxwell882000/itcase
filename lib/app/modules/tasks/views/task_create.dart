import 'dart:convert';
import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itcase/app/modules/account/widgets/account_link_widget.dart';
import 'package:itcase/app/modules/tasks/views/images.dart';
import 'package:itcase/app/modules/tasks/views/map.dart';
import 'package:itcase/common/ui.dart';
import '../../../global_widgets/text_field_widget.dart';

class TaskCreate extends StatefulWidget {
  @override
  _TaskCreateState createState() => _TaskCreateState();
}

class _TaskCreateState extends State<TaskCreate> {
  String title,
      description,
      placeLoc = 'город',
      dateStart,
      dateEnd,
      amount,
      detail,
      privateInfo,
      photo,
      phone;
  var place = 'У меня';
  bool private = false;
  var imgs;

  final GlobalKey<FormState> _profileForm = new GlobalKey<FormState>();

  File file;
  String img, base64, imgName;
  fromGallery() async {
    file = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 70);
    if (file != null) {
      setState(() {
        final img = file.readAsBytesSync();
        base64 = base64Encode(img);
        imgName = file.path.split('/').last;
        print(img);
      });
    }
  }

  fromCamera() async {
    file = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 70);
    if (file != null) {
      setState(() {
        final img = file.readAsBytesSync();
        base64 = base64Encode(img);
        imgName = file.path.split('/').last;
      });
    }
  }

  next() {
    var data = {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Create a task".tr,
            style: TextStyle(color: Get.theme.primaryColor),
          ),
          centerTitle: true,
          backgroundColor: Get.theme.accentColor,
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Get.theme.primaryColor),
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
                  onPressed: () async {
                    // print(imgs[0]);
                    Get.to(SearchMap());
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
                onPressed: () {},
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
                TextFieldWidget(
                  onSaved: (input) => setState(() {
                    title = input;
                  }),
                  validator: (input) => input.length < 3
                      ? "Should be more than 3 letters".tr
                      : null,
                  hintText: "Enter title of task".tr,
                  labelText: "Title".tr,
                  iconData: Icons.title,
                  isFirst: true,
                  isLast: false,
                ),
                TextFieldWidget(
                  onSaved: (input) => setState(() {
                    description = input;
                  }),
                  validator: (input) => input.length < 100
                      ? "Should be more than 100 letters"
                      : null,
                  hintText: "Write something",
                  keyboardType: TextInputType.multiline,
                  isFirst: false,
                  isLast: true,
                  maxLine: 5,
                  height: 10,
                  labelText: "Description".tr,
                  iconData: Icons.description,
                ),
                box(
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListTile(
                        dense: true,
                        title: Text(
                          "Work details".tr,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.info_outline,
                          color: Get.theme.focusColor.withOpacity(0.5),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Work description".tr,
                        style: Get.textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Get.theme.primaryColor,
                            border: Border.all(
                                color: Get.theme.focusColor.withOpacity(0.2))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              maxLines: 3,
                              onSaved: (input) => setState(() {
                                detail = input;
                              }),
                              validator: (input) => input.length < 25
                                  ? "Should be more than 25 letters"
                                  : null,
                              style: Get.textTheme.bodyText2,
                              decoration: Ui.getInputDecoration(
                                hintText: "Write description",
                                iconData: Icons.description,
                              ),
                              keyboardType: TextInputType.multiline,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Private information".tr,
                        style: Get.textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Get.theme.primaryColor,
                            border: Border.all(
                                color: Get.theme.focusColor.withOpacity(0.2))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              maxLines: 2,
                              onSaved: (input) => setState(() {
                                detail = input;
                              }),
                              validator: (input) => input.length < 25
                                  ? "Should be more than 25 letters"
                                  : null,
                              style: Get.textTheme.bodyText2,
                              decoration: Ui.getInputDecoration(
                                hintText: "apartment number, intercom code",
                                iconData: Icons.info,
                              ),
                              keyboardType: TextInputType.multiline,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Get.theme.primaryColor,
                            border: Border.all(
                                color: Get.theme.focusColor.withOpacity(0.05))),
                        child: AccountLinkWidget(
                          icon: Icon(Icons.album, color: Get.theme.accentColor),
                          text: Text("Pictures".tr),
                          onTap: (e) async {
                            imgs = await Get.to(Img(), fullscreenDialog: true);
                            print(imgs.length);
                          },
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Privacy".tr,
                        style: Get.textTheme.bodyText1,
                      ),
                      Row(children: [
                        Expanded(
                          child: Text(
                            "Task can see only special people, after finish only you and he",
                            style: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.w100,
                                fontSize: 12),
                          ),
                        ),
                        Switch(
                          value: private,
                          onChanged: (val) {
                            setState(() {
                              private = val;
                            });
                          },
                          // activeTrackColor: Colors.yellow,
                          // activeColor: Colors.orangeAccent,
                        ),
                      ]),
                    ],
                  ),
                ),
                box(
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Place of indication of service".tr,
                        style: Get.textTheme.bodyText1,
                      ),
                      DropdownButton<String>(
                        style: Get.textTheme.bodyText2,
                        icon: Icon(Icons.arrow_drop_down),
                        isExpanded: true,
                        value: place,
                        onChanged: (v) {
                          setState(() {
                            place = v;
                          });
                        },
                        items: <String>['У меня', 'У исполнителя', 'Неважно']
                            .map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      DropdownButton<String>(
                        style: Get.textTheme.bodyText2,
                        icon: Icon(Icons.arrow_drop_down),
                        isExpanded: true,
                        value: placeLoc,
                        onChanged: (v) {
                          setState(() {
                            placeLoc = v;
                          });
                        },
                        items: <String>[
                          'город',
                          'район',
                          'станция метро',
                          'улица'
                        ].map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                box(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date".tr,
                        style: Get.textTheme.bodyText1,
                      ),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: DateTimePicker(
                              type: DateTimePickerType.dateTime,
                              onChanged: (val) => dateStart = val,
                              dateMask: 'd MMM, yyyy',
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              icon: Icon(Icons.event_available),
                              dateLabelText: 'Start Date',
                              style: Get.textTheme.bodyText1,
                              use24HourFormat: true,
                              //locale: Locale('pt', 'BR'),
                            ),
                          ),
                          Expanded(
                            child: DateTimePicker(
                              type: DateTimePickerType.dateTime,
                              onChanged: (val) => dateEnd = val,
                              dateMask: 'd MMM, yyyy',
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              icon: Icon(Icons.event),
                              dateLabelText: 'End Date',
                              style: Get.textTheme.bodyText1,
                              timeLabelText: "Hour",
                              use24HourFormat: true,
                              //locale: Locale('pt', 'BR'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Last(
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Cost of work".tr,
                        style: Get.textTheme.bodyText1,
                      ),
                      DropdownButton<String>(
                        style: Get.textTheme.bodyText2,
                        icon: Icon(Icons.arrow_drop_down),
                        isExpanded: true,
                        value: amount,
                        onChanged: (v) {
                          setState(() {
                            amount = v;
                          });
                        },
                        items: <String>[
                          '500 000',
                          '1 000 000',
                          '1 500 000',
                          '2 000 000'
                        ].map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                TextFieldWidget(
                  onSaved: (input) => setState(() {
                    phone = input;
                  }),
                  validator: (input) => input == null
                      ? "Please enter a valid phone number."
                      : null,
                  hintText: "+998 99 1234567",
                  keyboardType: TextInputType.phone,
                  labelText: "Phone".tr,
                  iconData: Icons.phone_iphone,
                ),
                /*InkWell(
                  onTap: () async {
                    final List<DateTime> picked =
                        await DateRagePicker.showDatePicker(
                            context: context,
                            initialFirstDate: new DateTime.now(),
                            initialLastDate:
                                (new DateTime.now()).add(new Duration(days: 7)),
                            firstDate: new DateTime(2015),
                            lastDate: new DateTime(2070));
                    if (picked != null && picked.length == 2) {
                      date = picked.toString();
                    }
                  },
                  child: AbsorbPointer(
                    child: TextFieldWidget(
                        // keyboardType: TextInputType.phone,
                        // onSaved: (input) =>

                        // validator: (input) =>,
                        initialValue: date,
                        // hintText: "+1 565 6899 659",
                        labelText: "Date".tr,
                        iconData: Icons.calendar_today),
                  ),
                ),*/
              ],
            ),
          ),
        ));
  }
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
