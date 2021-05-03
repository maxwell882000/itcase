import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/modules/account/controllers/guest_controller.dart';
import 'package:itcase/app/modules/tasks/views/my_task.dart';
import 'package:itcase/app/modules/tasks/views/requested_tasks.dart';

class GuestRequestedTasks extends GetView<GuestController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Accomplished tasks of".tr  + " " + controller.accountSee.value.name.value,
          style: Get.textTheme.headline6,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Get.theme.hintColor),
          onPressed: () => {Get.back()},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: RefreshIndicator(
          onRefresh: () async {
            controller.paginationHelper.update();
            await controller.showMore(refresh:true);
          },
          child: Obx(() => RequestedTasks().list_task_requested(
              controller,
              tenders: controller.acceptedTasks,
              child: RequestedTasks().acceptTenders)),
        ),
      ),
    );
  }
}
