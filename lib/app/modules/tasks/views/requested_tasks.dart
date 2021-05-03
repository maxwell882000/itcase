import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/global_widgets/circular_loading_widget.dart';
import 'package:itcase/app/modules/account/controllers/account_controller.dart';

import 'package:itcase/app/modules/tasks/controllers/requested_tenders.dart';
import 'package:itcase/app/modules/tasks/widgets/tasks_list_widget.dart';
import '../../../routes/app_pages.dart';

class RequestedTasks extends GetWidget<AccountController> {
  GlobalKey _scaffold = GlobalKey();

  Widget list_task_requested(var controller, {tenders, Function child}) {
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
              if (length == index) {
                return Obx(
                  () => Visibility(
                    child: CircularLoadingWidget(
                      height: 50,
                    ),
                    visible: !controller.paginationHelper.isLast.value,
                  ),
                );
              } else {
                return child(tenders: tenders, index: index);
              }
            }));
  }

  Widget requestTenders({tenders, index}) {
    try {
      var _tenders = tenders.value.elementAt(index);
      return SizedBox(
        width: 400,
        child: GestureDetector(
          onTap: () {
            Get.toNamed(Routes.TENDER_VIEW, arguments: _tenders);
          },
          child: TasksListWidget().list_tinders(_tenders),
        ),
      );
    } catch (e) {
      return SizedBox();
    }
  }

  Widget acceptTenders({tenders, index}) {
    try {
      var _tenders = tenders.value.elementAt(index);
      return SizedBox(
        width: 400,
        child: GestureDetector(
          onTap: () {
            Get.toNamed(
              Routes.TENDER_VIEW,
              arguments: _tenders,
            );
          },
          child: TasksListWidget().list_tinders(
            _tenders,
          ),
        ),
      );
    } catch (e) {
      return SizedBox();
    }
  }

  Widget invitedTenders({tenders, index}) {
    try {
      var _tenders = tenders.value.elementAt(index);
      final deleted = false.obs;
      return SizedBox(
        width: 400,
        child: GestureDetector(
          onTap: () {
            // Get.toNamed(Routes.TENDER_VIEW, arguments: _tenders);
          },
          child: TasksListWidget().list_tinders(
            _tenders,
            child: acceptDecline(
                onAccept: () async => deleted.value =
                    await controller.acceptInvitation(tender: _tenders),
                onDecline: () async => deleted.value =
                    await controller.declineInvitation(tender: _tenders)),
          ),
        ),
      );
    } catch (e) {
      return SizedBox();
    }
  }

  Widget acceptDecline({Function onAccept, Function onDecline}) {
    return Wrap(
      spacing: 10,
      children: [
        FlatButton(
          onPressed: () => onAccept(),
          shape: StadiumBorder(),
          color: Get.theme.accentColor.withOpacity(0.1),
          child: Text("Accept".tr, style: Get.textTheme.subtitle1),
        ),
        FlatButton(
          onPressed: () => onDecline(),
          shape: StadiumBorder(),
          color: Get.theme.accentColor.withOpacity(0.1),
          child: Text("Decline".tr, style: Get.textTheme.subtitle1),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // controller.refreshTasks();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Requests".tr,
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
                    child: Text("Accepted".tr,
                        maxLines: 1,
                        style: TextStyle(fontSize: 12),
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
                    child: Text("Requested".tr,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
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
                    child: Text("Invited".tr,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.fade),
                  ),
                ),
              ),
            ],
            onTap: (index) async {
              switch (index) {
                case 0:
                  controller.paginationHelper.update();
                  controller.setShowMore(controller.getAcceptedTenders);
                  await controller.getAcceptedTenders();
                  break;
                case 1:
                  controller.paginationHelper.update();
                  controller.setShowMore(controller.getRequestedTenders);
                  await controller.getRequestedTenders();
                  break;
                case 2:
                  controller.paginationHelper.update();
                  controller.setShowMore(controller.getInvitedTenders);
                  await controller.getInvitedTenders();
                  break;
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
                  child: list_task_requested(controller,
                      tenders: controller.acceptedTasks, child: acceptTenders),
                ),
                RefreshIndicator(
                  onRefresh: () async {
                    controller.paginationHelper.update();
                    await controller.showMore(refresh: true);
                  },
                  child: list_task_requested(controller,
                      tenders: controller.requestSendTasks,
                      child: requestTenders),
                ),
                RefreshIndicator(
                  onRefresh: () async {
                    controller.paginationHelper.update();
                    await controller.showMore(refresh: true);
                  },
                  child: list_task_requested(controller,
                      tenders: controller.invitedTasks, child: invitedTenders),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
