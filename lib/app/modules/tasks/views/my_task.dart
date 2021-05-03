
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/global_widgets/circular_loading_widget.dart';
import 'package:itcase/app/models/tenders.dart';
import 'package:itcase/app/modules/account/controllers/account_controller.dart';
import 'package:itcase/app/modules/tasks/widgets/tasks_list_widget.dart';
import '../../../routes/app_pages.dart';

import '../../../../common/ui.dart';


class MyTasks extends GetWidget<AccountController> {
  GlobalKey _scaffold = GlobalKey();
 Widget list_my_tasks(var controller, {tenders , Function child}){

   var length = tenders.value.length;
    return Container(
      color: Get.theme.primaryColor,
      child: ListView.builder(
        controller: controller.paginationHelper.scrollController.value,
        padding: EdgeInsets.only(bottom: 10),
        primary: false,
        shrinkWrap: false,
        scrollDirection: Axis.vertical,
        itemCount: (tenders.value?.length ?? 0) + 1,
        itemBuilder: (_, index) {
          if (length == index){

            return Obx(
              ()=> Visibility(
                child: CircularLoadingWidget(
                  height: 50,
                ),
                visible: !controller.paginationHelper.isLast.value,
              ),
            );
          }
          else {
            try{
              final  _tender =  new Tenders().obs;
            _tender.value = tenders.value.elementAt(index);
            return Obx(
              ()=> SizedBox(
                width: 400,
                child: child(task:_tender, tenders: tenders)
              ),
            );
          }
          catch(e){
              return SizedBox();
          }
          }
        })
    );
  }

  // Widget OnModififcation({task, tenders}){
  //  return Visibility(
  //    visible: task.value.delete_reason == null || task.value.delete_reason == "",
  //    child: TasksListWidget().list_tinders(task.value, controller: (tender) {
  //      tenders.value.where((elem) => elem.id == tender.id).forEach((elem){
  //        int index = tenders.value.indexOf(elem);
  //        tenders.value.removeAt(index);
  //          tenders.value.insert(index, tender);
  //          task(tender);
  //      });
  //    }),
  //  );
  // }

  Widget Archive({task, tenders}){
    return TasksListWidget().list_tinders(task.value, controller: (tender) {
      tenders.value.where((elem) => elem.id == tender.id).forEach((elem){
        int index = tenders.value.indexOf(elem);
        tenders.value.removeAt(index);
        tenders.value.insert(index, tender);
        task(tender);
      });
    });
  }

  Widget Published({task, tenders}){
    return Visibility(
      visible: task.value.delete_reason == null || task.value.delete_reason == "",
      child: TasksListWidget().list_tinders(task.value, controller: (tender) {
        tenders.value.where((elem) => elem.id == tender.id).forEach((elem){
          int index = tenders.value.indexOf(elem);
          tenders.value.removeAt(index);
          tenders.value.insert(index, tender);
          task(tender);
        });
      }),
    );
  }
  @override
  Widget build(BuildContext context) {

    // controller.refreshTasks();
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Tasks".tr,
            style: Get.textTheme.headline6,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
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
                    child: Text("Opened".tr, maxLines: 1, textAlign: TextAlign.center, overflow: TextOverflow.fade),
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
              // Tab(
              //   child: Container(
              //     padding: EdgeInsets.symmetric(horizontal: 5),
              //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Get.theme.accentColor.withOpacity(0.2)),
              //     child: Align(
              //       alignment: Alignment.center,
              //       child: Text("On modification".tr, maxLines: 1, textAlign: TextAlign.center, overflow: TextOverflow.fade),
              //     ),
              //   ),
              // ),
            ],
            onTap: (index) async {
              switch (index) {
                case 0:
                  controller.paginationHelper.removeListener();
                  controller.paginationHelper.update();
                  controller.setShowMore(controller.getOpenedTasks);
                  await controller.getOpenedTasks();
                  break;
                case 1:
                  controller.paginationHelper.removeListener();
                  controller.paginationHelper.update();
                  controller.setShowMore(controller.getArchivedTasks);
                  await controller.getArchivedTasks();

                  break;
                // case 2:
                //   controller.paginationHelper.update();
                //   controller.setShowMore(controller.getModificationTasks);
                //   await controller.getModificationTasks();
                //   break;
              }
            },
          ),
          automaticallyImplyLeading: false,
          leading: new IconButton(
            key: _scaffold,
            icon: new Icon(Icons.arrow_back, color: Get.theme.hintColor),
            onPressed: () => {Get.back()},
          ),
        ),

        body: Obx(
            () => Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TabBarView(
              children: [
                RefreshIndicator(
                  onRefresh: () async {
                    controller.paginationHelper.update();
                    await controller.showMore(refresh: true);
                  },
                  child: list_my_tasks(controller, tenders: controller.currentTasks, child: Published),
                ),
                RefreshIndicator(
                  onRefresh: () async {
                    controller.paginationHelper.update();
                    await controller.showMore(refresh: true);
                  },
                  child: list_my_tasks(controller, tenders: controller.archivedTasks , child: Archive),
                ),
                // RefreshIndicator(
                //   onRefresh: () async {
                //     controller.paginationHelper.update();
                //     await controller.showMore(refresh: true);
                //   },
                //   child: list_my_tasks(controller, tenders: controller.onModification, child: OnModififcation),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}