import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:itcase/app/global_widgets/circular_loading_widget.dart';

import 'package:itcase/app/models/tenders.dart';
import 'package:itcase/app/modules/tasks/controllers/tender_controller.dart';
import 'package:itcase/app/modules/tasks/views/my_task.dart';

import '../../../../common/ui.dart';

import '../../../routes/app_pages.dart';

class TasksListWidget extends StatelessWidget {
  final controller = Get.find<TenderController>();
  final List<Tenders> tasks;

  TasksListWidget({Key key, List<Tenders> this.tasks}) : super(key: key);

  Widget text(String title, String body) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
          ),
        ),
        Text(
          body,
        style: Get.textTheme.bodyText1,
        ),
      ],
    );
  }

  Widget list_tinders(Tenders _task, {Function controller, Widget child}) {
    if (child == null) child = SizedBox();
    return GestureDetector(
      onTap: () async {
        final result = await Get.toNamed(Routes.TENDER_VIEW, arguments: _task);
        print(result);
        if (result != null && controller != null) {
          print(result.toJson());
          controller(result);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: Ui.getBoxDecoration(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: CachedNetworkImage(
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                    imageUrl:
                        "https://i.pinimg.com/originals/80/8c/0f/808c0faeff1173563adb93d4162d6a0f.jpg",
                    placeholder: (context, url) => Image.asset(
                      'assets/img/loading.gif',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 70,
                    ),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error_outline),
                  ),
                ),
                Text(!_task.published && _task.opened.value && (_task.delete_reason == null || _task.delete_reason.isEmpty)
                    ? "Moderating".tr
                    : _task.opened.value && (_task.delete_reason == null || _task.delete_reason.isEmpty)
                    ? "Opened".tr
                        : _task.delete_reason == null || _task.delete_reason.isEmpty ? "Closed".tr : "Deleted".tr),
              ],
            ),
            SizedBox(width: 20),
            Expanded(
              child: Wrap(
                runSpacing: 10,
                alignment: WrapAlignment.end,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          _task.title ?? '',
                          style: Get.textTheme.bodyText2,
                          maxLines: 3,
                        ),
                      ),
                      Flexible(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            "Published".tr + ":\n" + '${_task.updated_at}',
                            textAlign: TextAlign.center,
                            style: Get.textTheme.bodyText1.merge(TextStyle(
                              fontSize: 10,
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 8, thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          child: text("Created time".tr, _task.work_start_at)),
                      Expanded(
                          child: text("End time".tr, _task.work_end_at)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Total Price".tr,
                          style: Get.textTheme.bodyText1,
                        ),
                      ),
                      Ui.getPrice(double.parse(_task.budget ?? "0"),
                          style: Get.textTheme.headline6),
                    ],
                  ),
                  child
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void update(_task, tender) {
    tasks.where((elem) => elem.id == tender.id).forEach((elem) {
      int index = tasks.indexOf(elem);
      tasks.removeAt(index);
      tasks.insert(index, tender);
      _task(tender);
    });
  }

  @override
  Widget build(BuildContext context) {
    final length = tasks.length;
    print(tasks.length);

    return Obx(() {
      return ListView.builder(
        controller: controller.paginationHelper.scrollController.value,
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.only(bottom: 10, top: 10),
        shrinkWrap: false,
        itemCount: tasks.length + 1,
        itemBuilder: ((_, index) {
          if (tasks.length == index) {
            return Visibility(
              child: CircularLoadingWidget(
                height: 50,
              ),
              visible: !controller.paginationHelper.isLast.value,
            );
          }
          var _task = tasks[index].obs;
          return Visibility(
              visible: _task.value.delete_reason == null ||
                  _task.value.delete_reason == "",
              child: list_tinders(_task.value,
                  controller: (tender) => update(_task, tender)));
        }),
      );
    });
  }
}
