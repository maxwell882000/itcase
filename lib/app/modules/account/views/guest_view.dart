import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/modules/account/controllers/guest_controller.dart';
import 'package:itcase/app/modules/account/views/account_view.dart';
import 'package:itcase/app/routes/app_pages.dart';

class GuestView extends GetView<GuestController> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.refreshAccount(showMessage: true);
      },
      child: Obx(
        () => Scaffold(
          appBar: AppBar(
            title: Text(
              "Guest".tr,
              style: Get.textTheme.headline6
                  .merge(TextStyle(color: context.theme.primaryColor)),
            ),
            centerTitle: true,
            backgroundColor: Get.theme.accentColor,
            automaticallyImplyLeading: false,
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back, color: Get.theme.primaryColor),
              onPressed: () => {Get.back()},
            ),
            elevation: 0,
          ),
          body: AccountView().account(
            controller,
            child: Obx(() => AccountView().validated(controller.user)),
            tasks: () async => {
              controller.paginationHelper.update(),
              controller.getTenders(),
              controller.setShowMore(controller.getTenders),
              Get.toNamed(Routes.GUEST_TASKS)
            },
            takenTasks: () async => {
              controller.paginationHelper.update(),
              controller.getAcceptedTenders(),
              controller.setShowMore(controller.getAcceptedTenders),
              Get.toNamed(Routes.GUEST_REQUESTED_TASKS),
            },
          ),
        ),
      ),
    );
  }
}
