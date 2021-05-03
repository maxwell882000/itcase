import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/modules/category/widgets/services_list_item_widget.dart';
import 'package:itcase/app/modules/category/widgets/services_list_widget.dart';
import 'package:itcase/app/modules/e_service/views/e_service_view.dart';

import 'package:itcase/app/modules/search/controllers/search_controller.dart';
import 'package:itcase/app/modules/tasks/widgets/tasks_list_widget.dart';
import '../../../global_widgets/circular_loading_widget.dart';

class SearchContractorsListWidget extends GetView<SearchController> {
  SearchContractorsListWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.eServices.isEmpty || controller.loading.value) {
        return CircularLoadingWidget(height: 300);
      } else {
        return Obx(
          () => ListView.builder(
            controller: controller.paginationContractors.scrollController.value,
            padding: EdgeInsets.only(bottom: 10, top: 10),
            primary: false,
            shrinkWrap: true,
            itemCount: controller.eServices.length + 1,
            itemBuilder: ((_, index) {
              if (index >= controller.eServices.length) {
                return Visibility(
                  child: CircularLoadingWidget(height: 50),
                  visible: !controller.paginationTasks.isLast.value,
                );
              }
              var _service = controller.eServices[index];
              return ServicesListItemWidget(
                service: _service,
              );
            }),
          ),
        );
      }
    });
  }
}
