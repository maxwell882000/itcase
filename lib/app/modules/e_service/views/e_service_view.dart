import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/models/user_model.dart';
import 'package:itcase/app/modules/e_service/widgets/add_contractor_to_tender.dart';
import 'package:itcase/app/modules/e_service/widgets/remain_comment.dart';
import '../../../global_widgets/block_button_widget.dart';
import '../../../global_widgets/circular_loading_widget.dart';

import '../widgets/e_service_til_widget.dart';
import '../widgets/review_item_widget.dart';

import '../../../../common/ui.dart';
import '../controllers/e_service_controller.dart';
import '../widgets/e_service_title_bar_widget.dart';

class EServiceView extends GetView<EServiceController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var _eService = controller.userConractor.value;
      if (!_eService.hasData) {
        return Scaffold(
          body: CircularLoadingWidget(height: Get.height),
        );
      } else {
        return Scaffold(
          bottomNavigationBar: buildBlockButtonWidget(_eService),
          body: RefreshIndicator(
              onRefresh: () async {

                controller.refreshEService(showMessage: true);
              },
              child: CustomScrollView(
                primary: true,
                shrinkWrap: false,
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    expandedHeight: 320,
                    elevation: 0,
                    // pinned: true,
                    floating: true,
                    iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
                    centerTitle: true,
                    automaticallyImplyLeading: false,
                    leading: new IconButton(
                      icon: new Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
                      onPressed: () => {Get.back()},
                    ),
                    bottom: buildEServiceTitleBarWidget(_eService),
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: Obx(() {
                        return Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: <Widget>[
                            buildCarouselSlider(controller.userConractor.value),
                            buildCarouselBullets(controller.userConractor.value),
                          ],
                        );
                      }),
                    ).marginOnly(bottom: 50),
                  ),

                  // WelcomeWidget(),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 10),
                        buildCategories(controller.userConractor.value),
                        EServiceTilWidget(
                          title: Text("Description".tr, style: Get.textTheme.subtitle2),
                          content: Text(_eService.about_myself, style: Get.textTheme.bodyText1),
                        ),

                        EServiceTilWidget(
                          title: Text("Galleries".tr, style: Get.textTheme.subtitle2),
                          content: Container(
                            height: 120,
                            child: ListView.builder(
                                primary: false,
                                shrinkWrap: false,
                                scrollDirection: Axis.horizontal,
                                itemCount: 1,
                                itemBuilder: (_, index) {

                                  return InkWell(
                                    onTap: () {
                                      //Get.toNamed(Routes.CATEGORY, arguments: _category);
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      margin: EdgeInsetsDirectional.only(end: 10, start: 0, top: 10, bottom: 10),
                                      child: Stack(
                                        alignment: AlignmentDirectional.topStart,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            child: CachedNetworkImage(
                                              height: 100,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                              imageUrl: _eService.image_gotten,
                                              placeholder: (context, url) => Image.asset(
                                                'assets/img/loading.gif',
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: 100,
                                              ),
                                              errorWidget: (context, url, error) => Icon(Icons.error_outline),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional.only(start: 12, top: 8),
                                            child: Text(
                                              '',
                                              maxLines: 2,
                                              style: Get.textTheme.bodyText2.merge(TextStyle(color: Get.theme.primaryColor)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          actions: [
                            InkWell(
                              onTap: () {
                                // Get.offAllNamed(Routes.REGISTER);
                              },
                              child: Text("View All".tr, style: Get.textTheme.subtitle1),
                            ),
                          ],
                        ),
                        EServiceTilWidget(
                          title: Text("Reviews & Ratings".tr, style: Get.textTheme.subtitle2),
                          content: Column(
                            children: [
                              Text(controller.userConractor.value.rate.toString(), style: Get.textTheme.headline1),
                              Wrap(
                                children: Ui.getStarsList(controller.userConractor.value.rate, size: 32),
                              ),
                              Text(
                                "Reviews (%s)".trArgs([controller.userConractor.value.comments.length.toString()]),
                                style: Get.textTheme.caption,
                              ).paddingOnly(top: 10),
                              Divider(height: 35, thickness: 1.3),
                              Obx(() {
                                return Stack(
                                  children: [
                                    Visibility(
                                      visible: !controller.isLoaded.value,
                                      child: CircularLoadingWidget(
                                        height: 100,
                                        onCompleteText: "No comments".tr,
                                      ),
                                    ),
                                    Visibility(
                                      child: ListView.separated(
                                        padding: EdgeInsets.all(0),
                                        itemBuilder: (context, index) {
                                          return ReviewItemWidget(review: controller.comments.value[controller.comments.length - index - 1]);
                                        },
                                        separatorBuilder: (context, index) {
                                          return Divider(height: 35, thickness: 1.3);
                                        },
                                        itemCount: controller.comments.length,
                                        primary: false,
                                        shrinkWrap: true,
                                      ),
                                      visible: controller.isLoaded.value,
                                    ),
                                  ],
                                );
                              }),
                            ],
                          ),
                          actions: [
                            InkWell(
                              onTap: () {
                                // Get.offAllNamed(Routes.REGISTER);
                              },
                              child: Text("View All".tr, style: Get.textTheme.subtitle1),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        );
      }
    });
  }

  CarouselSlider buildCarouselSlider(User _eService) {

    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 7),
        height: 350,
        viewportFraction: 1.0,
        onPageChanged: (index, reason) {
          controller.currentSlide.value = index;
        },
      ),
      items: List.generate(1,(media) {
        return Builder(
          builder: (BuildContext context) {
            return Hero(
              tag: _eService.id,
              child: CachedNetworkImage(
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
                imageUrl: _eService.image_gotten,
                placeholder: (context, url) => Image.asset(
                  'assets/img/loading.gif',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error_outline),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Container buildCarouselBullets(User _eService) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 92, horizontal: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(1,(media) {
          return Container(
            width: 20.0,
            height: 5.0,
            margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Get.theme.hintColor),
          );
        }).toList(),
      ),
    );
  }
//controller.currentSlide.value == _eService.media.indexOf(media) ? : Get.theme.primaryColor.withOpacity(0.4)
  EServiceTitleBarWidget buildEServiceTitleBarWidget(User _eService) {
    return EServiceTitleBarWidget(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _eService.name,
                  style: Get.textTheme.headline5,
                ),
              ),
              Text(
                "Start from".tr,
                style: Get.textTheme.caption,
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: List.from(Ui.getStarsList(controller.userConractor.value.rate))
                    ..addAll([
                      SizedBox(width: 5),
                      Text(
                        "Reviews (%s)".trArgs([controller.userConractor.value.comments.length.toString()]),
                        style: Get.textTheme.caption,
                      ),
                    ]),
                ),
              ),
              Ui.getPrice(
           _eService.pivot == null ?0.0 :  _eService?.pivot?.priceFrom?.toDouble(),
                style: Get.textTheme.headline3.merge(TextStyle(color: Get.theme.accentColor, fontSize: 12)),
                unit: _eService?.pivot?.priceFrom != 'fixed' ? "/h".tr : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCategories(User _eService) {
    print(_eService.category);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 5,
        runSpacing: 8,
        children: List.generate(_eService.category.length, (index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Text(_eService.category[index].title, style: Get.textTheme.caption),
            decoration: BoxDecoration(
                color: Get.theme.primaryColor,
                border: Border.all(
                  color: Get.theme.focusColor.withOpacity(0.2),
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
          );
        }),
      ),
    );
  }

  Widget buildBlockButtonWidget(User _eService) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Get.theme.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(color: Get.theme.focusColor.withOpacity(0.1), blurRadius: 10, offset: Offset(0, -5)),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: BlockButtonWidget(
                text: SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Add to tender".tr,
                    textAlign: TextAlign.center,
                    style: Get.textTheme.headline6.merge(
                      TextStyle(color: Get.theme.primaryColor),
                    ),
                  ),
                ),
                color: Get.theme.accentColor,
                onPressed: ()async {
                  final result =  await Get.bottomSheet(
                    AddContractorToTender(),
                    isScrollControlled: true,
                  );
                }).paddingOnly(right: 20, left: 20),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: BlockButtonWidget(
                text: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Comment".tr,
                        textAlign: TextAlign.center,
                        style: Get.textTheme.headline6.merge(
                          TextStyle(color: Get.theme.primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
                color: Get.theme.accentColor,
                onPressed: ()async {
                  final result =  await Get.bottomSheet(
                    RemainComment(),
                    isScrollControlled: true,
                  );
                }).paddingOnly(right: 20, left: 20),
          ),
        ],
      ),
    );
  }
}


