import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/global_widgets/home_search_bar_widget.dart';
import 'package:itcase/app/modules/search/controllers/search_controller.dart';
import 'package:itcase/app/modules/search/views/search_view.dart';
import 'package:itcase/app/modules/tasks/controllers/tender_controller.dart';
import 'package:itcase/app/routes/app_pages.dart';

import '../widgets/tasks_list_widget.dart';

class TasksView extends GetView<TenderController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.theme.accentColor),
            tabs: [
              Tab(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Get.theme.accentColor.withOpacity(0.2)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("All".tr,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Get.theme.accentColor.withOpacity(0.2)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Available".tr,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade),
                  ),
                ),
              ),
            ],
            onTap: (index) async {
              switch (index) {
                case 0:
                  controller.paginationHelper.removeListener();
                  controller.paginationHelper.update();
                  await controller.getTenders();
                  controller.setShowMore(controller.getTenders);
                  break;
                case 1:
                  controller.paginationHelper.removeListener();
                  controller.paginationHelper.update();
                  await controller.getAvailableTenders();
                  controller.setShowMore(controller.getAvailableTenders);
                  break;
              }
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              HomeSearchBarWidget().buildSearchBar(
                  heroTag: 'tender_search',
                  onSubmit: (SearchController controller) {
                    controller.tenders.value =
                        this.controller.currentTasks.value;
                    controller.setShowMore(controller.searchTenders);
                    controller.paginationTasks
                        .addingListener(controller: controller);
                    Get.toNamed(Routes.TENDER_SEARCH);
                  }),
              Expanded(
                child: TabBarView(
                  children: [
                    RefreshIndicator(
                      onRefresh: () async {
                        controller.paginationHelper.update();
                        await controller.getTenders(showMessage: true);

                        controller.currentTasks.value =
                            controller.allTasks.value;
                      },
                      child: TasksListWidget(tasks: controller.allTasks),
                    ),
                    RefreshIndicator(
                      onRefresh: () async {
                        controller.paginationHelper.update();
                        await controller.getAvailableTenders(showMessage: true);
                        controller.currentTasks.value =
                            controller.availableTasks.value;
                      },
                      child: TasksListWidget(tasks: controller.availableTasks),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
