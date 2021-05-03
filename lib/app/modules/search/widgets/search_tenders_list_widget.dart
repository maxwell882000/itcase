import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:itcase/app/modules/search/controllers/search_controller.dart';
import 'package:itcase/app/modules/tasks/widgets/tasks_list_widget.dart';
import '../../../global_widgets/circular_loading_widget.dart';


class SearchTendersListWidget extends GetView<SearchController> {


  SearchTendersListWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Obx(() {
      if (controller.tenders.isEmpty || controller.loading.value) {
        return CircularLoadingWidget(height: 300);
      } else {
        return Obx(
          ()=> ListView.builder(
            controller: controller.paginationTasks.scrollController.value,
            padding: EdgeInsets.only(bottom: 10, top: 10),
            primary: false,
            shrinkWrap: true,
            itemCount: controller.tenders.value.length + 1,
            itemBuilder: ((_, index) {
              if (index >= controller.tenders.value.length){
                return Visibility(
                    child: CircularLoadingWidget(height: 50),
                  visible: !controller.paginationTasks.isLast.value,
                );
              }
              var _service = controller.tenders[index];
              return TasksListWidget().list_tinders(_service);
            }),
          ),
        );
      }
    });
  }
}
