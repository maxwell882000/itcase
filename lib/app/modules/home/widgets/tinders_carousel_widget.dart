import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/modules/tasks/widgets/tasks_list_widget.dart';
import '../../../routes/app_pages.dart';

import '../../../../common/ui.dart';
import '../controllers/home_controller.dart';

class TindersCarouselWidget extends GetWidget<HomeController> {
  void update(_task, tender) {
    List tasks = controller.tenders;
    int index;
    tasks.where((elem) => elem.id == tender.id).forEach((elem) {
      index =  tasks.indexOf(elem);
    });
    tasks.removeAt(index);
    // if ( tender.delete_reason != null &&  tender.delete_reason != "")
      tasks.insert(index, tender);
    _task(tender);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      color: Get.theme.primaryColor,
      child: Obx(() {
        return ListView.builder(
            padding: EdgeInsets.only(bottom: 10),
            primary: false,
            shrinkWrap: false,
            scrollDirection: Axis.horizontal,
            itemCount: controller.tenders.length,
            itemBuilder: (_, index) {
              var _tenders = controller.tenders.elementAt(index).obs;
              if (_tenders.value.delete_reason == null || _tenders.value.delete_reason == "")
              return SizedBox(
                width: 400,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.TENDER_VIEW, arguments: _tenders);
                  },
                  child: TasksListWidget().list_tinders(_tenders.value,
                      controller: (tender) => update(_tenders, tender)),
                ),
              );
              return SizedBox();
            });
      }),
    );
  }
}
