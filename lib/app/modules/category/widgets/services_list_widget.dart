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
  final controller;
  final ScrollController scroll = new ScrollController();
  ServicesListWidget({Key key,  this.services, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Obx(() {
      if (controller.isLoading.value) {
        return CircularLoadingWidget(
            height: 300
        );
      } else {
        return ListView.builder(
          controller:  controller.pagination.scrollController.value,
          padding: EdgeInsets.only(bottom: 10, top: 10),
          primary: false,
          shrinkWrap: true,
          itemCount: services.length + 1,
          itemBuilder: ((_, index) {
            if (services.length == index){
              return Visibility(
                child: CircularLoadingWidget(
                  height: 50,
                ),
                visible: !controller.pagination.isLast.value,
              );
            }
            var _service = services.elementAt(index);
            if (_service.id == controller.currentUser.value.id)
              return SizedBox();
            return ServicesListItemWidget(service: _service);
          }),
        );
      }
    });
  }
}

