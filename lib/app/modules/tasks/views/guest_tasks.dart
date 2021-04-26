import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/modules/account/controllers/guest_controller.dart';
import 'package:itcase/app/modules/tasks/views/my_task.dart';
class GuestTasks extends GetView<GuestController> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(
          "Задания от ${controller.accountSee.value.name.value}".tr,
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
            await controller.refreshAccount(showMessage: true);
          },
          child: Obx(()=> MyTasks().list_my_tasks(controller,tenders: controller.guestTenders)),
        ),
      ),
    );
  }
}
