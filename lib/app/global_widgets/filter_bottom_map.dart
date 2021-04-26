/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/global_widgets/text_field_widget.dart';
import 'package:itcase/app/modules/search/controllers/search_controller_map.dart';

import '../modules/search/controllers/search_controller.dart';
import 'circular_loading_widget.dart';
import 'filter_bottom_sheet_widget.dart';

class FilterBottomMap extends GetView<SearchMapController> {
  GlobalKey<FormState> _key = new GlobalKey<FormState>();
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
            child: SizedBox(
              height: 100,
              child: Form(
                key: _key,
                child: TextFieldWidget(
                  labelText: "Radius".tr,
                  hintText: "Enter radius".tr,
                  keyboardType: TextInputType.number,
                  initialValue: controller.radius.value.toString(),
                  onSaved: (val) => controller.radius.value = int.parse(val),
                  validator: (val) => val.length == 0 || !(new RegExp(r"^[0-9]*$").hasMatch(val))
                      ? "Enter correct radius".tr
                      : null,
                  iconData: Icons.people_alt,
                  isLast: false,
                  isFirst: false,
                ),
              ),
            )
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: FilterBottomSheetWidget().buttonInRowAbove(
                hintText: "Enter radius".tr,
                buttonName: "Apply".tr,
                onPressed: () async {
                    if(_key.currentState.validate()) {
                      _key.currentState.save();
                      controller.searchMap();
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
