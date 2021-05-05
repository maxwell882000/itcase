import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:get/get.dart';
import 'package:itcase/app/global_widgets/format.dart';

import 'package:itcase/app/modules/account/widgets/account_link_widget.dart';
import 'package:itcase/app/modules/tasks/controllers/create_task_controller.dart';
import 'package:itcase/app/modules/tasks/views/images.dart';

import 'package:itcase/common/ui.dart';

import '../../../global_widgets/text_field_widget.dart';

class TaskCreate extends GetView<CreateTasksController> {
  final GlobalKey<FormState> _profileForm = new GlobalKey<FormState>();

  File file;
  final length_valid = 5;

  next() {
    var data = {};
  }

  storeCategories(String text) {
    controller.categoriesDropDown.id.clear();
    controller.categoriesDropDown.subCategoriesList.clear();
    controller.categoriesDropDown.categories.value = text;
    controller.categoriesDropDown.categoriesList
        .where((element) => element[0][0] == text)
        .forEach((e) => e[1].forEach((e) {
              controller.categoriesDropDown.id.add(e[1]);
              controller.categoriesDropDown.subCategoriesList.add(e[0]);
            }));
    controller.categoriesDropDown.subCategories.value = "";
    controller.tenders.value.categories = [];
  }

  storeSubCategories(String text) {
    int index = getChoosen(text);
    if (!checkChoosen(text)) {
      controller.tenders.value.categories.add(index);
    } else {
      controller.tenders.value.categories.remove(index);
    }
    controller.categoriesDropDown.subCategories.value =
        controller.tenders.value.categories.length.toString();
  }

  int getChoosen(String text) {
    int index = controller.categoriesDropDown.subCategoriesList.indexOf(text);
    if (index == -1) {
      return index;
    }
    return controller.categoriesDropDown.id[index];
  }

  bool checkChoosen(String text) {
    return controller.tenders.value.categories.indexOf(getChoosen(text)) == -1
        ? false
        : true;
  }

  Widget getCategories(
      String text, List<String> input, Function onChanged, final controller, context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            text,
            style: Get.textTheme.bodyText2,
          ),
          DropdownButton<String>(
            style: Get.textTheme.bodyText1,
            icon: Icon(Icons.arrow_drop_down),
            isExpanded: true,
            hint: Text(controller.value),
            onChanged: (v) {
              // controller.te.value = v;
              onChanged(v);
            },
            items: input.map((String value) {
              bool choosen = checkChoosen(value);
              return new DropdownMenuItem<String>(
                value: value,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: Text(
                      value,
                      style: Get.textTheme.bodyText1,
                    )),
                    Visibility(
                      visible: choosen,
                      child: Icon(
                        Icons.check_circle_outline,
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget subCategories(
      String text, List<String> input, Function onChanged, final controller) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            text,
            style: Get.textTheme.bodyText1,
          ),
          DropdownButton<String>(
            style: Get.textTheme.bodyText2,
            icon: Icon(Icons.arrow_drop_down),
            isExpanded: true,
            value: controller.value.isEmpty ? null : controller.value,
            onChanged: (v) {
              // controller.te.value = v;
              FocusScope.of(Get.context).unfocus();
              onChanged(v);
            },
            items: input.map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          appBar: AppBar(
            title: Text(
              "Create a task".tr,
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
                                keyboardType : TextInputType.text,
                                initialValue:
                                    controller.tenders.value.description,
                                decoration: Ui.getInputDecoration(
                                  hintText: "Write description".tr,
                                  iconData: Icons.description,
                                ),

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
                                keyboardType : TextInputType.text,
                                initialValue:
                                    controller.tenders.value.additional_info,
                                decoration: Ui.getInputDecoration(
                                  hintText:
                                      "Please enter additional information".tr,
                                  iconData: Icons.info,
                                ),
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
                                keyboardType : TextInputType.text,
                                initialValue:
                                    controller.tenders.value.other_info,
                                decoration: Ui.getInputDecoration(
                                  hintText:
                                      "Please enter ways of communication".tr,
                                  iconData: Icons.info,
                                ),
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
                              print(controller.tenders.value.files.length);
                              print(controller.tenders.value.files);
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
                              "Work, which can be accomplished from distance".tr
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
                  box(Row(
                    children: [
                      getCategories(
                          "Categories".tr,
                          controller.categoriesDropDown.categoriesList
                              .map<String>((e) => e[0][0])
                              .toList(),
                          storeCategories,
                          controller.categoriesDropDown.categories,context),
                      getCategories(
                          "SubCategories".tr,
                          controller.categoriesDropDown.subCategoriesList,
                          storeSubCategories,
                          controller.categoriesDropDown.subCategories,context)
                    ],
                  )),
                  box(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Date".tr,
                          style: Get.textTheme.bodyText1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  DatePicker.showDateTimePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(2018, 3, 5),
                                      maxTime: DateTime(2030, 6, 7),
                                       onChanged: (date) {

                                      }, onConfirm: (date) {
                                        controller.tenders.update((val) {
                                          val.work_start_at = Format.parseDate(
                                              date.toString(),
                                              Format.outputFormat);
                                        });

                                        return date;
                                      },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.ru);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: Get.theme.primaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Get.theme.focusColor
                                                .withOpacity(0.1),
                                            blurRadius: 10,
                                            offset: Offset(0, 5)),
                                      ],
                                      border: Border.all(
                                          color: Get.theme.focusColor
                                              .withOpacity(0.05))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        'Start Date'.tr,
                                        style: Get.textTheme.bodyText1,
                                        textAlign: TextAlign.start,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.event_available,
                                            color: Get.theme.focusColor,
                                          ).paddingOnly(right: 15),
                                          Text(controller.tenders.value.work_start_at,
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),),
                                        ],
                                      ).marginSymmetric(vertical: 10),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  DatePicker.showDateTimePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(2018, 3, 5),
                                      maxTime: DateTime(2030, 6, 7),
                                      onChanged: (date) {

                                      }, onConfirm: (date) {
                                        controller.tenders.update((val) {
                                          val.work_end_at = Format.parseDate(
                                              date.toString(),
                                              Format.outputFormat);
                                        });
                                      },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.ru);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: Get.theme.primaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Get.theme.focusColor
                                                .withOpacity(0.1),
                                            blurRadius: 10,
                                            offset: Offset(0, 5)),
                                      ],
                                      border: Border.all(
                                          color: Get.theme.focusColor
                                              .withOpacity(0.05))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        'End Date'.tr,
                                        style: Get.textTheme.bodyText1,
                                        textAlign: TextAlign.start,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.event_available,
                                            color: Get.theme.focusColor,
                                          ).paddingOnly(right: 15),
                                          Text(controller.tenders.value.work_end_at,
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ).marginSymmetric(vertical: 10),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  DatePicker.showDateTimePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(2018, 3, 5),
                                      maxTime: DateTime(2030, 6, 7),
                                      onChanged: (date) {

                                      }, onConfirm: (date) {
                                        controller.tenders.update((val) {
                                          val.deadline = Format.parseDate(
                                              date.toString(),
                                              Format.outputFormatDeadline);
                                        });
                                      },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.ru);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: Get.theme.primaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Get.theme.focusColor
                                                .withOpacity(0.1),
                                            blurRadius: 10,
                                            offset: Offset(0, 5)),
                                      ],
                                      border: Border.all(
                                          color: Get.theme.focusColor
                                              .withOpacity(0.05))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        'Deadline of accepting applications'.tr,
                                        style: Get.textTheme.bodyText1,
                                        textAlign: TextAlign.start,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.event_available,
                                            color: Get.theme.focusColor,
                                          ).paddingOnly(right: 15),
                                          Text(controller
                                              .tenders.value.deadline,
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                          ),
                                        ],
                                      ).marginSymmetric(vertical: 10),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Last(
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: DropdownButton<String>(
                            hint: Text(
                              "Choose cost of work".tr,
                              style: Get.textTheme.bodyText1.merge(TextStyle(
                                fontSize: 12,
                              )),
                            ),
                            style: Get.textTheme.bodyText2,
                            icon: Icon(Icons.arrow_drop_down),
                            isExpanded: true,
                            value: controller.amount.value.isEmpty
                                ? null
                                : controller.amount.value,
                            onChanged: (v) {
                              controller.amount.value = v;
                              controller.tenders.value.budget =
                                  controller.amount.value;
                              controller.textEditingController.value.clear();
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
                          width: 100,
                          height: 50,
                        ),
                        Expanded(
                          child: TextFieldWidget(
                            controller: controller.textEditingController.value,
                            onSaved: (input) {
                              if (input.isNotEmpty)
                                controller.tenders.value.budget = input;
                            },
                            hintText: "Enter cost".tr,
                            keyboardType: TextInputType.number,
                            labelText: "Cost of work".tr,
                            iconData: Icons.phone_iphone,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextFieldWidget(
                    onSaved: (input) =>
                        controller.tenders.value.client_phone_number = input,
                    validator: (input) {
                      bool reg = new RegExp(r'^\+[0-9]{12}$').hasMatch(input);
                      print("THERE US");
                      print(reg);
                      return !reg
                          ? "Please enter a valid phone number.".tr
                          : null;
                    },
                    initialValue: controller.tenders.value.client_phone_number,
                    hintText: "+998 99 1234567",
                    keyboardType: TextInputType.phone,
                    labelText: "Phone".tr,
                    iconData: Icons.phone_iphone,
                  ),
                ],
              ),
            ),
          )),
    );
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
