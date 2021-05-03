import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:itcase/app/models/tenders.dart';
import 'package:itcase/app/modules/category/controllers/category_controller.dart';
import 'package:itcase/app/modules/category/widgets/services_list_widget.dart';
import 'package:itcase/common/ui.dart';

import '../../../global_widgets/home_search_bar_widget.dart';
import '../../home/widgets/address_widget.dart';

class AllTaskView extends GetView<CategoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          controller.refreshEServices(showMessage: true);
        },
        child: CustomScrollView(
          primary: true,
          shrinkWrap: false,
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Get.theme.scaffoldBackgroundColor,
              expandedHeight: 280,
              elevation: 0.5,
              primary: true,
              // pinned: true,
              floating: true,
              iconTheme: IconThemeData(color: Get.theme.primaryColor),
              title: Text(
                // controller.category.value.ru_title,
                "Tasks".tr,
                style: Get.textTheme.headline6
                    .merge(TextStyle(color: Get.theme.primaryColor)),
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back_ios,
                    color: Get.theme.primaryColor),
                onPressed: () => {Get.back()},
              ),
              bottom: HomeSearchBarWidget(),
              flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      /*Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 75, bottom: 115),
                        decoration: new BoxDecoration(
                          /*gradient: new LinearGradient(
                              colors: [
                                // controller.category.value.color.withOpacity(1),
                                // controller.category.value.color.withOpacity(0.2)
                              ],
                              begin: AlignmentDirectional.topStart,
                              //const FractionalOffset(1, 0),
                              end: AlignmentDirectional.bottomEnd,
                              stops: [0.1, 0.9],
                              tileMode: TileMode.clamp),*/
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5)),
                        ),
                        child: (controller.category.value.image
                                .toLowerCase()
                                .endsWith('.svg')
                            ? SvgPicture.network(
                                controller.category.value.image,
                                color: controller.category.value.color,
                              )
                            : CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: controller.category.value.image,
                                placeholder: (context, url) => Image.asset(
                                  'assets/img/loading.gif',
                                  fit: BoxFit.cover,
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error_outline),
                              )),
                      ),*/
                      AddressWidget().paddingOnly(bottom: 75),
                    ],
                  )).marginOnly(bottom: 42),
            ),
            SliverToBoxAdapter(
              child: Wrap(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Get.toNamed(Routes.E_SERVICE, arguments: _service);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: Ui.getBoxDecoration(),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Hero(
                                      tag: 1,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                        child: CachedNetworkImage(
                                          height: 80,
                                          width: 80,
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              "http://lorempixel.com/400/400/business/4/",
                                          placeholder: (context, url) =>
                                              Image.asset(
                                            'assets/img/loading.gif',
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: 80,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error_outline),
                                        ),
                                      ),
                                    ),
                                    if (true)
                                      Container(
                                        width: 80,
                                        child: Text("Available".tr,
                                            maxLines: 1,
                                            style:
                                                Get.textTheme.bodyText2.merge(
                                              TextStyle(
                                                  color: Colors.green,
                                                  height: 1.4,
                                                  fontSize: 10),
                                            ),
                                            softWrap: false,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.fade),
                                        decoration: BoxDecoration(
                                          color: Colors.green.withOpacity(0.2),
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10)),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 6),
                                      ),
                                    if (!true)
                                      Container(
                                        width: 80,
                                        child: Text("Offline".tr,
                                            maxLines: 1,
                                            style:
                                                Get.textTheme.bodyText2.merge(
                                              TextStyle(
                                                  color: Colors.grey,
                                                  height: 1.4,
                                                  fontSize: 10),
                                            ),
                                            softWrap: false,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.fade),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.2),
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10)),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 6),
                                      ),
                                  ],
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Wrap(
                                    runSpacing: 10,
                                    alignment: WrapAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Text(
                                            "Title",
                                            style: Get.textTheme.bodyText2,
                                            maxLines: 3,
                                            // textAlign: TextAlign.end,
                                          ),
                                        ],
                                      ),
                                      Divider(height: 8, thickness: 1),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            spacing: 5,
                                            children: [
                                              SizedBox(
                                                height: 32,
                                                child: Chip(
                                                  padding: EdgeInsets.all(0),
                                                  label: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.star,
                                                        color: Get
                                                            .theme.accentColor,
                                                        size: 18,
                                                      ),
                                                      Text("4.3",
                                                          style: Get.textTheme
                                                              .bodyText2
                                                              .merge(TextStyle(
                                                                  color: Get
                                                                      .theme
                                                                      .accentColor,
                                                                  height:
                                                                      1.4))),
                                                    ],
                                                  ),
                                                  backgroundColor: Get
                                                      .theme.accentColor
                                                      .withOpacity(0.15),
                                                  shape: StadiumBorder(),
                                                ),
                                              ),
                                              Text(
                                                "From (%s)".trArgs(["7"]),
                                                style: Get.textTheme.bodyText1,
                                              ),
                                            ],
                                          ),
                                          Ui.getPrice(6.25,
                                              style: Get.textTheme.headline6),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          // TODO check if eProvider is company or freelancer
                                          // Icon(
                                          //   Icons.person_outline,
                                          //   size: 18,
                                          //   color: Get.theme.focusColor,
                                          // ),
                                          Icon(
                                            Icons.home_work_outlined,
                                            size: 18,
                                            color: Get.theme.focusColor,
                                          ),
                                          SizedBox(width: 5),
                                          Flexible(
                                            child: Text(
                                              "Company name",
                                              maxLines: 1,
                                              overflow: TextOverflow.fade,
                                              softWrap: false,
                                              style: Get.textTheme.bodyText1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.place_outlined,
                                            size: 18,
                                            color: Get.theme.focusColor,
                                          ),
                                          SizedBox(width: 5),
                                          Flexible(
                                            child: Text(
                                              "Uzbekistan, Tashkent",
                                              maxLines: 1,
                                              overflow: TextOverflow.fade,
                                              softWrap: false,
                                              style: Get.textTheme.bodyText1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(height: 8, thickness: 1),
                                      Wrap(
                                        spacing: 5,
                                        children: [
                                          // List.generate(_service.subCategories.length, (index) {
                                          /*return*/ Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 4),
                                            child: Text("Category",
                                                style: Get.textTheme.caption
                                                    .merge(TextStyle(
                                                        fontSize: 10))),
                                            decoration: BoxDecoration(
                                                color: Get.theme.primaryColor,
                                                border: Border.all(
                                                  color: Get.theme.focusColor
                                                      .withOpacity(0.2),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                          )
                                        ],
                                      ),
                                      // runSpacing: 5,
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*Container(
                    height: 60,
                    child: ListView(
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: List.generate(CategoryFilter.values.length,
                            (index) {
                          var _filter = CategoryFilter.values.elementAt(index);
                          return Obx(() {
                            return Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(start: 20),
                              child: RawChip(
                                elevation: 0,
                                label: Text(_filter.toString().tr),
                                labelStyle: controller.isSelected(_filter)
                                    ? Get.textTheme.bodyText2.merge(TextStyle(
                                        color: Get.theme.primaryColor))
                                    : Get.textTheme.bodyText2,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 15),
                                backgroundColor: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.1),
                                selectedColor: controller.category.value.color,
                                selected: controller.isSelected(_filter),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                showCheckmark: true,
                                checkmarkColor: Get.theme.primaryColor,
                                onSelected: (bool value) {
                                  controller.toggleSelected(_filter);
                                  controller.getEServicesOfCategory(
                                      filter: controller.selected.value);
                                },
                              ),
                            );
                          });
                        })),
                  ),*/
                  // ServicesListWidget(services: controller.eServices),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
