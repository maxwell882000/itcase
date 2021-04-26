import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/global_widgets/block_button_widget.dart';
import 'package:itcase/app/global_widgets/circular_loading_widget.dart';
import 'package:itcase/app/modules/auth/views/register/fill_account.dart';

class BecomeConsumer extends CreateAccount {
  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Stack(
        children: [
          Visibility(
            visible: controller.loading.value,
            child: Scaffold(
              body: CircularLoadingWidget(
                height: Get.height,
                onCompleteText: "".tr,
              ),
            ),
          ),
          Visibility(
            visible: !controller.loading.value,
            child: Scaffold(
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
                    child: Text('Consumer'),
                  )
                ],
                views: [
                  customer(context),
                ],
                onChange: (index) {
                  controller.tempUser.value.user_role = "customer";
                  controller.user.value.user_role = "customer";
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
                            controller.tempUser.value.user_role = "customer";
                            controller.user.value.user_role = "customer";

                            controller.fill_data_account(
                                controller.tempUser.value.user_role);
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
            ),
          ),
        ],
      ),
    );
  }
}
