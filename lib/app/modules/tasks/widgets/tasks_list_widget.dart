import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:itcase/app/global_widgets/circular_loading_widget.dart';


import 'package:itcase/app/models/tenders.dart';
import 'package:itcase/app/modules/tasks/controllers/tender_controller.dart';

import '../../../../common/ui.dart';

import '../../../routes/app_pages.dart';


  class TasksListWidget extends StatelessWidget {
  final controller = Get.find<TenderController>();
  final List<Tenders> tasks;

  TasksListWidget({Key key, List<Tenders> this.tasks}) : super(key: key);
  Widget list_tinders(Tenders _task,{Function controller }){
   return GestureDetector(
     onTap: (){
       Get.toNamed(Routes.TENDER_VIEW , arguments: _task);
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
                    imageUrl: "https://i.pinimg.com/originals/80/8c/0f/808c0faeff1173563adb93d4162d6a0f.jpg",
                    placeholder: (context, url) => Image.asset(
                      'assets/img/loading.gif',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 70,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error_outline),
                  ),
                ),
                Text(_task.opened.value? "Opened" : "Closed"),
              ],
            ),
            SizedBox(width: 20),
            Expanded(
              child: Wrap(
                runSpacing: 10,
                alignment: WrapAlignment.end,
                children: <Widget>[
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          _task.title ?? '',
                          style: Get.textTheme.bodyText2,
                          maxLines: 3,
                          // textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 8, thickness: 1),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Your Review".tr,
                          style: Get.textTheme.bodyText1,
                        ),
                      ),
                      Wrap(
                        spacing: 0,
                        children: Ui.getStarsList(0.0),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Time".tr,
                          style: Get.textTheme.bodyText1,
                        ),
                      ),
                      Text(
                        '${_task.created_at}',
                        style: Get.textTheme.caption,
                      ),
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
                      Ui.getPrice(double.parse(_task.budget?? "0"), style: Get.textTheme.headline6),
                    ],
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
   );
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
          if (tasks.length == index){
            return Visibility(
                child: CircularLoadingWidget(
              height: 50,
             ),
              visible: !controller.paginationHelper.isLast.value,
            );
          }
          var _task = tasks[index];
          return list_tinders(_task);
        }),
      );
    });
  }
}
