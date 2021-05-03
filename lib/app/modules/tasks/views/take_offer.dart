import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/global_widgets/circular_loading_widget.dart';
import 'package:itcase/app/modules/tasks/controllers/take_offer_controller.dart';

import '../../../global_widgets/block_button_widget.dart';
import '../../../global_widgets/text_field_widget.dart';
import '../../../models/setting_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/settings_service.dart';

class TakeOffer extends GetView<TakeOfferController> {
  // final _currentUser = Get.find<AuthService>().user;
  final Setting _settings = Get.find<SettingsService>().setting.value;
  final GlobalKey<FormState> offerController = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Stack(
        children: [
          Visibility(
              child: Scaffold(
                body: CircularLoadingWidget(
            height: Get.height,
          ),
              ),
            visible: controller.loading.value,
          ),
          Visibility(
            visible: !controller.loading.value,
              child: Scaffold(
            appBar: AppBar(
              leading: new IconButton(
                icon:
                    new Icon(Icons.arrow_back_ios, color: Get.theme.primaryColor),
                onPressed: () => Get.back(),
              ),
              title: Text(
                "Your application".tr,
                style: Get.textTheme.headline6
                    .merge(TextStyle(color: context.theme.primaryColor)),
              ),
              centerTitle: true,
              backgroundColor: Get.theme.accentColor,
              automaticallyImplyLeading: false,
              elevation: 0,
            ),
            body: Form(
              key: offerController,
              child: ListView(
                primary: true,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Container(
                          height: 120,
                          width: Get.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/icon/itcase.jpg"),
                              fit: BoxFit.cover,
                            ),
                            color: Get.theme.accentColor,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Get.theme.focusColor.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: Offset(0, 5)),
                            ],
                          ),
                          margin: EdgeInsets.only(bottom: 10),
                          child: SizedBox()),
                    ],
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            "Offer".tr,
                            style: Get.textTheme.headline6.merge(TextStyle(
                                color: Get.theme.accentColor, fontSize: 22)),
                          ),
                          SizedBox(height: 5),

                          // Text("Fill the following credentials to login your account", style: Get.textTheme.caption.merge(TextStyle(color: Get.theme.primaryColor))),
                        ],
                      ),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 0.0),
                  ),
                  TextFieldWidget(
                    labelText: "Comment".tr,
                    hintText: "Enter your comment".tr,
                    // initialValue: controller.user.value.name,
                    onSaved: (val) => controller.comment.value = val,
                    isLast: false,
                    maxLine: 10,
                    validator: (val) =>
                        val.isNotEmpty ? null : "Fill the field".tr,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Text("Cost of work".tr),
                      Row(
                        children: [
                          Expanded(
                            child: TextFieldWidget(
                              labelText: "Price from".tr,
                              hintText: "50 000".tr,
                              iconData: Icons.monetization_on,
                              keyboardType: TextInputType.phone,
                              onSaved: (val) => controller.priceFrom.value = val,
                              validator: (val) =>
                                  val.isNotEmpty ? null : "Fill the field".tr,
                              // initialValue: controller.user.value.phone_number,
                              // onSaved: (val) => controller.user.value.phone_number = val,
                            ),
                          ),
                          Expanded(
                            child: TextFieldWidget(
                              labelText: "Price to".tr,
                              iconData: Icons.monetization_on_outlined,
                              hintText: "100 000".tr,
                              keyboardType: TextInputType.phone,
                              onSaved: (val) => controller.priceTo.value = val,
                              validator: (val) =>
                                  val.isNotEmpty ? null : "Fill the field".tr,
                              // initialValue: controller.user.value.email,
                              // iconData: Icons.alternate_email,
                              // onSaved: (val) => controller.user.value.email = val,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Date".tr),
                      Row(
                        children: [
                          Expanded(
                            child: TextFieldWidget(
                              labelText: "From this date".tr,
                              hintText: "2 days".tr,
                              iconData: Icons.date_range,
                              keyboardType: TextInputType.phone,
                              // initialValue: controller.user.value.phone_number,
                              onSaved: (val) => controller.dayFrom.value = val,
                              validator: (val) =>
                                  val.isNotEmpty ? null : "Fill the field".tr,
                            ),
                          ),
                          Expanded(
                            child: TextFieldWidget(
                              labelText: "To this date".tr,
                              hintText: "3 days".tr,
                              iconData: Icons.date_range_outlined,
                              // initialValue: controller.user.value.email,
                              // iconData: Icons.alternate_email,
                              keyboardType: TextInputType.phone,
                              onSaved: (val) => controller.dayTo.value = val,
                              validator: (val) =>
                                  val.isNotEmpty ? null : "Fill the field".tr,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            bottomNavigationBar: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  direction: Axis.vertical,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: Get.height*0.02),
                      width: Get.width,
                      child: BlockButtonWidget(
                        onPressed: () {
                          // controller.register_account(offerController);
                          controller.send(offerController);
                        },
                        color: Get.theme.accentColor,
                        text: Text(
                          "Send".tr,
                          style: Get.textTheme.headline6
                              .merge(TextStyle(color: Get.theme.primaryColor)),
                        ),
                      ).paddingOnly(top: 15, bottom: 5, right: 20, left: 20),
                    ),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
