import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global_widgets/filter_bottom_sheet_widget.dart';
import '../widgets/search_services_list_widget.dart';
import '../../../../common/ui.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search".tr,
          style: context.textTheme.headline6,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
      ),
      body: ListView(
        children: [
          buildSearchBar(),
          SearchServicesListWidget(services: controller.eServices),
        ],
      ),
    );
  }

  Widget buildSearchBar({bool heroTag = true, Function onSubmit, bool filterShow = false}) {
    // GlobalKey<FormState> searchForm = new GlobalKey();
    controller.setOnSubmut(onSubmit);
    Widget search = Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 16),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        decoration: BoxDecoration(
            color: Get.theme.primaryColor,
            border: Border.all(
              color: Get.theme.focusColor.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 12, left: 0),
              child: GestureDetector(
                  onTap: () {
                  },
                  child: Icon(Icons.search, color: Get.theme.accentColor)),
            ),
            Expanded(
              child: Material(
                color: Get.theme.primaryColor,
                child: TextField(
                  style: Get.textTheme.bodyText2,
                  onSubmitted: (value) {
                    controller.typed.value =value;
                    onSubmit(refresh:true);
                  },
                  onChanged: (value) {
                    controller.typed.value = value;
                  },
                  autofocus: true,
                  cursorColor: Get.theme.focusColor,
                  decoration: Ui.getInputDecoration(
                      hintText: "Search for home service...".tr),
                ),
              ),
            ),
            SizedBox(width: 8),
            Visibility(
              visible: heroTag || filterShow ,
              child: GestureDetector(
                onTap: () async {
                final result =  await Get.bottomSheet(
                    FilterBottomSheetWidget(),
                    isScrollControlled: true,
                  );
                 print("RESULT");
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      right: 10, left: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Get.theme.focusColor.withOpacity(0.1),
                  ),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 4,
                    children: [
                      Text(
                        "Filter".tr,
                        style: Get.textTheme
                            .bodyText2, //TextStyle(color: Get.theme.hintColor),
                      ),
                      Icon(
                        Icons.filter_list,
                        color: Get.theme.hintColor,
                        size: 21,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
    return heroTag ? Hero(tag: controller.heroTag.value, child: search) : search;
  }
}
