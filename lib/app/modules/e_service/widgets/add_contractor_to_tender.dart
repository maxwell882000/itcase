/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/global_widgets/circular_loading_widget.dart';
import 'package:itcase/app/modules/e_service/controllers/e_service_controller.dart';
import 'package:itcase/app/routes/app_pages.dart';

class AddContractorToTender extends GetView<EServiceController> {
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
            padding: const EdgeInsets.only(top: 10, bottom: 100),
            child: ListView(
              padding: EdgeInsets.only(top: 20, bottom: 25, left: 4, right: 4),
              children: [
                Obx(() {
                  if (controller.isLoadingTenders.value) {
                    return CircularLoadingWidget(height: 100);
                  }
                  return ExpansionTile(
                    title: Text("Add to tender".tr,
                        style: Get.textTheme.bodyText2),
                    children: List.generate(controller.tenders.length, (index) {
                      var _category = controller.tenders.elementAt(index);
                      return CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.trailing,
                        value: _category.choose.value,
                        onChanged: (value) async{
                          if(!_category.choose.value) {
                            _category.choose.value = value;
                            controller.inviteContractor(
                                tenderId: _category.id.toString());
                          }
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
          Align(
            alignment: Alignment.bottomCenter,
            child: buttonInRowAbove(
                hintText: "Click to tender to invite contractor".tr,
                buttonName: "Back".tr,
                onPressed: () async {
                  Get.back();
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
