import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/models/tenders.dart';
import 'package:itcase/app/models/user_model.dart';
import 'package:itcase/app/modules/tasks/widgets/tasks_list_widget.dart';
import '../../../global_widgets/circular_loading_widget.dart';
import '../../category/widgets/services_list_item_widget.dart';

import '../../../models/e_service_model.dart';

class SearchTendersListWidget extends StatelessWidget {
  final List<Tenders> tenders;

  SearchTendersListWidget({Key key, List<Tenders> this.tenders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (this.tenders.isEmpty) {
        return CircularLoadingWidget(height: 300);
      } else {
        return ListView.builder(
          padding: EdgeInsets.only(bottom: 10, top: 10),
          primary: false,
          shrinkWrap: true,
          itemCount: tenders.length,
          itemBuilder: ((_, index) {
            var _service = tenders.elementAt(index);
            return TasksListWidget().list_tinders(_service);
          }),
        );
      }
    });
  }
}
