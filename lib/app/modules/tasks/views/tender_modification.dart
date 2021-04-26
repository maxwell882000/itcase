import 'dart:convert';
import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:itcase/app/global_widgets/format.dart';

import 'package:itcase/app/modules/account/widgets/account_link_widget.dart';
import 'package:itcase/app/modules/tasks/controllers/create_task_controller.dart';
import 'package:itcase/app/modules/tasks/views/images.dart';
import 'package:itcase/app/modules/tasks/views/task_page.dart';

import 'package:itcase/common/ui.dart';
import 'package:intl/intl.dart';
import '../../../global_widgets/text_field_widget.dart';

class TaskModification extends GetView<CreateTasksController> {
  final GlobalKey<FormState> _profileForm = new GlobalKey<FormState>();

  File file;
  final length_valid = 5;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          appBar: AppBar(
            title: Text(
              "Modify a task".tr,
              style: TextStyle(color: Get.theme.primaryColor),
            ),
            centerTitle: true,
            backgroundColor: Get.theme.accentColor,
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
                      // print(imgs[0]);

                      controller.submit_task(_profileForm);
                      // Get.toNamed(Routes.MAP);
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
            key: _profileForm,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFieldWidget(
                    onSaved: (input) {
                      controller.tenders.value.title = input;
                    },
                    validator: (input) => input.length < 3
                        ? "Should be more than 3 letters".tr
                        : null,
                    hintText: "Enter title of task".tr,
                    labelText: "Title".tr,
                    iconData: Icons.title,
                    initialValue: controller.tenders.value.title,
                    isFirst: true,
                    isLast: false,
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
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
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
                                  color:
                                      Get.theme.focusColor.withOpacity(0.2))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                maxLines: 3,
                                onSaved: (input) {
                                  controller.tenders.value.description = input;
                                },
                                validator: (input) =>
                                    input.length < length_valid
                                        ? "Should be more than 25 letters".tr
                                        : null,
                                style: Get.textTheme.bodyText2,
                                initialValue:
                                    controller.tenders.value.description,
                                decoration: Ui.getInputDecoration(
                                  hintText: "Write description".tr,
                                  iconData: Icons.description,
                                ),
                                keyboardType: TextInputType.multiline,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          "Additional information".tr,
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
                                  color:
                                      Get.theme.focusColor.withOpacity(0.2))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                maxLines: 2,
                                onSaved: (input) {
                                  controller.tenders.value.additional_info =
                                      input;
                                },
                                validator: (input) =>
                                    input.length < length_valid
                                        ? "Should be more than 25 letters".tr
                                        : null,
                                style: Get.textTheme.bodyText2,
                                initialValue:
                                    controller.tenders.value.additional_info,
                                decoration: Ui.getInputDecoration(
                                  hintText:
                                      "Please enter additional information".tr,
                                  iconData: Icons.info,
                                ),
                                keyboardType: TextInputType.multiline,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          "Ways of communication".tr,
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
                                  color:
                                      Get.theme.focusColor.withOpacity(0.2))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                maxLines: 2,
                                onSaved: (input) {
                                  controller.tenders.value.other_info = input;
                                },
                                validator: (input) =>
                                    input.length < length_valid
                                        ? "Should be more than 25 letters".tr
                                        : null,
                                style: Get.textTheme.bodyText2,
                                initialValue:
                                    controller.tenders.value.other_info,
                                decoration: Ui.getInputDecoration(
                                  hintText:
                                      "Please enter ways of communication".tr,
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
                                  color:
                                      Get.theme.focusColor.withOpacity(0.05))),
                          child: AccountLinkWidget(
                            icon:
                                Icon(Icons.album, color: Get.theme.accentColor),
                            text: Text("Pictures".tr),
                            onTap: (e) async {
                              controller.tenders.value.files = (await Get.to(
                                      Img(),
                                      fullscreenDialog: true)) ??
                                  [];
                            },
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          "Remote work".tr,
                          style: Get.textTheme.bodyText1,
                        ),
                        Row(children: [
                          Expanded(
                            child: Text(
                              "Task can see only special people, after finish only you and he"
                                  .tr,
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.w100,
                                  fontSize: 12),
                            ),
                          ),
                          Switch(
                            value: controller.remote.value,
                            onChanged: (val) {
                              print(val);
                              print(controller.tenders.value.remote);
                              controller.remote.value =
                                  !controller.remote.value;
                              controller.tenders.value.remote =
                                  controller.remote.value;
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
                          value: controller.place.value.isEmpty
                              ? null
                              : controller.place.value,
                          onChanged: (v) {
                            print(v);
                            controller.place.value = v;
                          },
                          items: controller.placeItems
                              .map<DropdownMenuItem<String>>((value) {
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
                                onSaved: (val) {
                                  controller.tenders.value.work_start_at =
                                      Format.parseDate(
                                          val, Format.outputFormat);
                                },
                                dateMask: 'd MMM, yyyy',
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                                icon: Icon(Icons.event_available),
                                dateLabelText: 'Start Date'.tr,
                                style: Get.textTheme.bodyText1,
                                use24HourFormat: true,
                                //locale: Locale('pt', 'BR'),
                              ),
                            ),
                            Expanded(
                              child: DateTimePicker(
                                type: DateTimePickerType.dateTime,
                                onSaved: (val) {
                                  controller.tenders.value.work_end_at =
                                      Format.parseDate(
                                          val, Format.outputFormat);
                                },
                                dateMask: 'd MMM, yyyy',
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                                icon: Icon(Icons.event),
                                dateLabelText: 'End Date'.tr,
                                style: Get.textTheme.bodyText1,
                                timeLabelText: "Hour".tr,
                                use24HourFormat: true,
                                //locale: Locale('pt', 'BR'),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: DateTimePicker(
                                type: DateTimePickerType.dateTime,
                                onSaved: (val) {
                                  if (val.isNotEmpty) {
                                    controller.tenders.value.deadline =
                                        Format.parseDate(
                                            val, Format.outputFormatDeadline);
                                  }
                                },
                                dateMask: 'd.M.yyyy',
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                                initialValue:"",
                                icon: Icon(Icons.event),
                                validator: (val) {
                                  print(val);
                                  return null;
                                },
                                dateLabelText:
                                    'Deadline of accepting applications'.tr,
                                style: Get.textTheme.bodyText1,
                                timeLabelText: "Hour".tr,
                                use24HourFormat: true,
                                //locale: Locale('pt', 'BR'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
