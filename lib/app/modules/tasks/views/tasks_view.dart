import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/modules/tasks/controllers/tender_controller.dart';

import '../controllers/tasks_controller.dart';
import '../widgets/tasks_carousel_widget.dart';
import '../widgets/tasks_list_widget.dart';

class TasksView extends GetView<TenderController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Bookings".tr,
            style: Get.textTheme.headline6,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(Icons.sort, color: Get.theme.hintColor),
            onPressed: () => {Scaffold.of(context).openDrawer()},
          ),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            labelPadding: EdgeInsets.symmetric(horizontal: 15),
            unselectedLabelColor: Get.theme.accentColor,
            labelColor: Get.theme.primaryColor,
            labelStyle: Get.textTheme.bodyText1,
            indicator: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Get.theme.accentColor),
            tabs: [
              Tab(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Get.theme.accentColor.withOpacity(0.2)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Ongoing".tr, maxLines: 1, textAlign: TextAlign.center, overflow: TextOverflow.fade),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Get.theme.accentColor.withOpacity(0.2)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Completed".tr, maxLines: 1, textAlign: TextAlign.center, overflow: TextOverflow.fade),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Get.theme.accentColor.withOpacity(0.2)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Archived".tr, maxLines: 1, textAlign: TextAlign.center, overflow: TextOverflow.fade),
                  ),
                ),
              ),
            ],
            onTap: (index) async {
              switch (index) {
                case 0:
                  await controller.getOngoingTasks();
                  break;
                case 1:
                  await controller.getCompletedTasks();
                  break;
                case 2:
                  await controller.getArchivedTasks();
              }
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: TabBarView(
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  await controller.getOngoingTasks(showMessage: true);
                },
                child: SingleChildScrollView(
                  child: TasksCarouselWidget(tasks: controller.ongoingTasks),
                ),
              ),
              RefreshIndicator(
                onRefresh: () async {
                  await controller.getCompletedTasks(showMessage: true);
                },
                child: TasksListWidget(tasks: controller.completedTasks),
              ),
              RefreshIndicator(
                onRefresh: () async {
                  await controller.getArchivedTasks(showMessage: true);
                },
                child: TasksListWidget(tasks: controller.archivedTasks),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
