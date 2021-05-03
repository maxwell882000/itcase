/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/global_widgets/filter_bottom_sheet_widget.dart';
import 'package:itcase/app/global_widgets/text_field_widget.dart';
import 'package:itcase/app/modules/e_service/controllers/e_service_controller.dart';
import 'package:itcase/app/modules/search/controllers/search_controller_map.dart';


class RemainComment extends GetView<EServiceController> {
  final GlobalKey<FormState> _key = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
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
                      labelText: "Comment".tr,
                      hintText: "Enter comment".tr,
                        initialValue: controller.comment.value.comment,
                        onSaved: (val) => controller.comment.value.comment = val,
                      validator: (val) => val.length == 0
                          ? "Enter comments please".tr
                          : null,
                      iconData: Icons.people_alt,
                      isLast: false,

                      isFirst: false,
                      maxLine: 3,
                    ),
                  ),
                  SizedBox(
                    height: 120,
                    child: TextFieldWidget(
                      labelText: "Assessment".tr,
                      hintText: "Enter assessment from 0 to 5".tr,
                      initialValue: controller.comment.value.assessment,
                      onSaved: (val) => controller.comment.value.assessment = val,
                      validator: (val) => val.length == 0 || !(new RegExp(r"^[0-5]$").hasMatch(val))
                          ? "Enter correct assessment from 0 to 5".tr
                          : null,
                      keyboardType: TextInputType.number,
                      iconData: Icons.people_alt,
                      isLast: false,
                      isFirst: false,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: FilterBottomSheetWidget().buttonInRowAbove(
                hintText: "Remain Comment".tr,
                buttonName: "Apply".tr,
                onPressed: () async {
                  if(_key.currentState.validate()) {
                    _key.currentState.save();
                    controller.createComment();
                    Get.back();
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
