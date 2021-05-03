import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/global_widgets/circular_loading_widget.dart';
import 'package:itcase/app/models/chat_model.dart';

import 'package:itcase/app/models/tender_requests.dart';
import 'package:itcase/app/modules/root/controllers/root_controller.dart';
import '../../../routes/app_pages.dart';
import 'package:itcase/app/modules/tasks/controllers/tender_view_controller.dart';

import '../../../../common/ui.dart';

class OffersListWidget extends StatelessWidget {
  final controller = Get.find<TenderViewController>();
  final List<TenderRequests> offers;

  OffersListWidget({Key key, List<TenderRequests> this.offers})
      : super(key: key);

  Widget user_list(TenderRequests offers) {
    print(controller.status.value &&
        controller.tender.value.owner_id ==
            int.parse(controller.currentUser.value.id));
    print(
        "Status  ${controller.status.value}   tender_owner_id  ${controller.tender.value.owner_id}   currentUser  ${controller.currentUser.value.id}");
    return Visibility(
      visible: !offers.isCanceled.value,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: Ui.getBoxDecoration(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                if (offers.user.id != controller.currentUser.value.id) {
                  Get.back();
                  Get.toNamed(Routes.GUEST, arguments: offers.user);
                } else {
                  Get.find<RootController>().changePage(3);
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: CachedNetworkImage(
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                  imageUrl: offers.user.image_gotten,
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
                          offers.user.name ?? '',
                          style: Get.textTheme.bodyText2,
                          maxLines: 3,
                          // textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 8, thickness: 1),
                  if (offers.invited == 0)
                    Wrap(
                      runSpacing: 10,
                      alignment: WrapAlignment.end,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                offers.comment ?? "",
                                style: Get.textTheme.bodyText1,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                "Budget from".tr + ": " + offers.budgetFrom ??
                                    "",
                                style: Get.textTheme.bodyText1,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                "Budget to".tr + ": " + offers.budgetTo ?? "",
                                style: Get.textTheme.bodyText1,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                offers.periodFrom == "1"
                                    ? "Period from".tr +
                                        ": " +
                                        offers.periodFrom +
                                        " " +
                                        "dayss".tr
                                    : "Period from".tr +
                                        ": " +
                                        offers.periodFrom +
                                        " " +
                                        "days".tr,
                                style: Get.textTheme.bodyText1,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                offers.periodTo == "1"
                                    ? "Period to".tr +
                                        ": " +
                                        offers.periodTo +
                                        " " +
                                        "dayss".tr
                                    : "Period to".tr +
                                        ": " +
                                        offers.periodTo +
                                        " " +
                                        "days".tr,
                                style: Get.textTheme.bodyText1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  if (offers.invited == 1 &&
                      offers.user.id !=
                          controller.tender.value.contractor_id.toString())
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            "Waiting while contractor will accept offer".tr,
                            style: Get.textTheme.bodyText1,
                          ),
                        ),
                      ],
                    ),
                  if (offers.user.id ==
                          controller.tender.value.contractor_id.toString() &&
                      controller.tender.value.owner_id ==
                          int.parse(controller.currentUser.value.id))
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            "Write him to discuss details".tr,
                            style: Get.textTheme.bodyText1,
                          ),
                        ),
                      ],
                    ),
                  Visibility(
                    visible: offers.invited != 1 &&
                        controller.status.value &&
                        controller.tender.value.owner_id ==
                            int.parse(controller.currentUser.value.id),
                    child: Wrap(
                      spacing: 10,
                      children: [
                        FlatButton(
                          onPressed: () {
                            controller.accepts(offers.id);
                          },
                          shape: StadiumBorder(),
                          color: Get.theme.accentColor.withOpacity(0.1),
                          child:
                              Text("Accept".tr, style: Get.textTheme.subtitle1),
                        ),
                        FlatButton(
                          onPressed: () {
                            offers.isCanceled.value = true;
                            controller.decline(offers.id);
                          },
                          shape: StadiumBorder(),
                          color: Get.theme.accentColor.withOpacity(0.1),
                          child: Text("Decline".tr,
                              style: Get.textTheme.subtitle1),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !controller.status.value &&
                        controller.tender.value.contractor_id ==
                            int.parse(offers.user.id) &&
                        controller.tender.value.owner_id ==
                            int.parse(controller.currentUser.value.id),
                    child: FlatButton(
                      onPressed: () {
                        controller.sendMessage(new Chat(user: offers.user));
                      },
                      shape: StadiumBorder(),
                      color: Get.theme.accentColor.withOpacity(0.1),
                      child: Text("Send message".tr,
                          style: Get.textTheme.subtitle1),
                    ),
                  )
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
    if (offers.isNull || offers.isEmpty) {
      return CircularLoadingWidget(
        height: Get.height * 0.04,
      );
    }
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 10, top: 10),
      primary: true,
      shrinkWrap: false,
      itemCount: offers?.length,
      itemBuilder: ((_, index) {
        var _task = offers[index];

        return GestureDetector(
            onTap: () {
              // Get.toNamed(Routes.ACCOUNT, arguments: _task.user);
            },
            child: Obx(() => user_list(_task)));
      }),
    );
  }
}
