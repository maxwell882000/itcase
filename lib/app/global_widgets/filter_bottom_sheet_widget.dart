/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/routes/app_pages.dart';

import '../modules/search/controllers/search_controller.dart';
import 'circular_loading_widget.dart';

class FilterBottomSheetWidget extends GetView<SearchController> {
  Widget buttonInRowAbove(
      {String hintText, Function onPressed, String buttonName}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 45),
      child: Row(
        children: [
          Expanded(child: Text(hintText, style: Get.textTheme.headline5)),
          FlatButton(
            onPressed: () => onPressed(),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Get.theme.accentColor.withOpacity(0.15),
            child: Text(buttonName, style: Get.textTheme.subtitle1),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height - 90,
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
            padding: const EdgeInsets.only(top: 100, bottom: 100),
            child: ListView(
              padding: EdgeInsets.only(top: 20, bottom: 25, left: 4, right: 4),
              children: [
                ExpansionTile(
                  title: Text("Available Provider".tr,
                      style: Get.textTheme.bodyText2),
                  children: [
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: true,
                      onChanged: (value) {
                        // setState(() {
                        //   _con.filter?.open = value;
                        // });
                      },
                      title: Text(
                        "Only Available".tr,
                        style: Get.textTheme.bodyText1,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        maxLines: 1,
                      ),
                    ),
                  ],
                  initiallyExpanded: true,
                ),
                Obx(() {
                  if (controller.categories.isEmpty) {
                    return CircularLoadingWidget(height: 100);
                  }
                  return ExpansionTile(
                    title:
                        Text("Categories".tr, style: Get.textTheme.bodyText2),
                    children:
                        List.generate(controller.categories.length, (index) {
                      var _category = controller.categories.elementAt(index);
                      return CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.trailing,
                        value: _category.choose.value,
                        onChanged: (value) {
                          _category.choose.value = value;
                        },
                        title: Text(
                          _category.title,
                          style: Get.textTheme.bodyText1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          maxLines: 1,
                        ),
                      );
                    }),
                    initiallyExpanded: true,
                  );
                }),
              ],
            ),
          ),
          buttonInRowAbove(
              hintText: "Filter".tr,
              buttonName: "Apply".tr,
              onPressed: () async {
                controller.onSubmit(refresh: true);
                Get.back();
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: buttonInRowAbove(
                hintText: "Search in map".tr,
                buttonName: "Go".tr,
                onPressed: () async {
                  Get.back();
                  Get.toNamed(Routes.TENDER_SEARCH_MAP,
                      arguments: controller.choosenCategories().isEmpty
                          ? controller.allIdCategories()
                          : controller.choosenCategories());
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
