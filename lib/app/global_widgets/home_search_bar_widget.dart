import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/search/controllers/search_controller.dart';
import '../routes/app_pages.dart';
import 'filter_bottom_sheet_widget.dart';

class HomeSearchBarWidget extends StatelessWidget implements PreferredSize {
  final controller = Get.find<SearchController>();
  final String heroTag;
  final Function onSubmit;

   HomeSearchBarWidget({Key key, this.heroTag, this.onSubmit}) : super(key: key);


  Widget buildSearchBar({String heroTag = "home_search", Function onSubmit}) {
    controller.heroTag.value = heroTag;
    return Hero(
      tag: heroTag,
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 16),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
            color: Get.theme.primaryColor,
            border: Border.all(
              color: Get.theme.focusColor.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(10)),
        child: GestureDetector(
          onTap: () {
            if (heroTag=="home_search")
            Get.toNamed(Routes.SEARCH);
            else {
              onSubmit(controller);
            }
          },
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
                child: Text(
                  "Search".tr,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: Get.textTheme.caption,
                ),
              ),
              SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  if (heroTag=="home_search")
                    Get.toNamed(Routes.SEARCH);
                  else {
                    onSubmit(controller);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Get.theme.focusColor.withOpacity(0.1),
                  ),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 4,
                    children: [
                      Text("Filter".tr, style: Get.textTheme.bodyText2),
                      Icon(
                        Icons.filter_list,
                        color: Get.theme.hintColor,
                        size: 21,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildSearchBar(heroTag: heroTag,onSubmit: onSubmit);
  }

  @override
  Widget get child => buildSearchBar();

  @override
  Size get preferredSize => new Size(Get.width, 80);
}
