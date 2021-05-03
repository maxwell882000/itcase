/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/global_widgets/filter_bottom_sheet_widget.dart';
import 'package:itcase/app/global_widgets/text_field_widget.dart';

import 'package:itcase/app/modules/tasks/controllers/tender_view_controller.dart';


class DeleteTender extends GetView<TenderViewController> {
  final GlobalKey<FormState> _key = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Get.theme.primaryColor,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
              color: Get.theme.focusColor.withOpacity(0.4),
              blurRadius: 30,
              offset: Offset(0, -30)),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 50,bottom: 100),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  SizedBox(
                    height: 120,
                    child: TextFieldWidget(
                      labelText: "Reason".tr,
                      hintText: "Enter reason for deleting".tr,
                      initialValue: controller.tender.value.delete_reason,
                      onSaved: (val) => controller.tender.update((elem) {
                        elem.delete_reason = val;
                      }),
                      validator: (val) => val.length == 0
                          ? "Enter reason for deleting tender".tr
                          : null,
                      iconData: Icons.people_alt,
                      isLast: false,

                      isFirst: false,
                      maxLine: 3,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: FilterBottomSheetWidget().buttonInRowAbove(
                hintText: "Tender".tr,
                buttonName: "Delete".tr,
                onPressed: () async {
                  if(_key.currentState.validate()) {
                    _key.currentState.save();
                    controller.deleteTender();
                  }
                }),
          ),
          Container(
            height: 30,
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                vertical: 13, horizontal: (Get.width / 2) - 30),
            decoration: BoxDecoration(
              color: Get.theme.focusColor.withOpacity(0.1),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Get.theme.focusColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(3),
              ),
              //child: SizedBox(height: 1,),
            ),
          ),
        ],
      ),
    );
  }
}
