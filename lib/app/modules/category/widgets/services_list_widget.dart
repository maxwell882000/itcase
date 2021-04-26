import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/models/user_model.dart';
import 'package:itcase/app/modules/category/controllers/category_controller.dart';
import '../../../global_widgets/circular_loading_widget.dart';
import 'services_list_item_widget.dart';

import '../../../models/e_service_model.dart';

class ServicesListWidget extends StatelessWidget {
  final List<User> services;
  final controller = Get.find<CategoryController>();
  ServicesListWidget({Key key,  this.services}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return CircularLoadingWidget(
            height: 300
        );
      } else {
        return ListView.builder(
          padding: EdgeInsets.only(bottom: 10, top: 10),
          primary: false,
          shrinkWrap: true,
          itemCount: services.length,
          itemBuilder: ((_, index) {
            var _service = services.elementAt(index);
            return ServicesListItemWidget(service: _service);
          }),
        );
      }
    });
  }

}

