import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/models/address_model.dart';
import 'package:itcase/app/models/tenders.dart';
import 'package:itcase/app/models/user_model.dart';
import 'package:itcase/app/modules/e_service/widgets/e_service_til_widget.dart';
import 'package:itcase/app/modules/e_service/widgets/e_service_title_bar_widget.dart';
import 'package:itcase/app/modules/home/widgets/address_widget.dart';
import 'package:itcase/app/modules/tasks/controllers/tender_controller.dart';
import 'package:itcase/app/modules/tasks/controllers/tender_view_controller.dart';
import 'package:itcase/app/modules/tasks/views/tender_modification.dart';
import 'package:itcase/app/modules/tasks/widgets/delete_tender.dart';
import 'package:itcase/app/modules/tasks/widgets/offers_list_widget.dart';
import '../../../global_widgets/block_button_widget.dart';
import '../../../global_widgets/circular_loading_widget.dart';
import '../../../models/e_service_model.dart';

import '../../../routes/app_pages.dart';

import '../../../../common/ui.dart';
import '../../../models/media_model.dart';

class TenderView extends GetView<TenderViewController> {
  Widget address() {
    return Row(
      children: [
        Icon(Icons.place_outlined),
        SizedBox(width: 10),
        Expanded(
          child: Obx(() {
            return Text(controller.location.value,
                style: Get.textTheme.bodyText1);
          }),
        ),
        SizedBox(width: 10),
        IconButton(icon: Icon(Icons.gps_fixed), onPressed: () {})
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var _tender = controller.tender;
      if (_tender.value.id.isNull || controller.loading.value) {
        return Scaffold(
          body: CircularLoadingWidget(height: Get.height),
        );
      } else {
        return Scaffold(
          bottomNavigationBar:
              controller.isOwner.value && controller.tender.value.opened.value
                  ? edditOrDelete(_tender)
                  : !controller.currentUser.value.isContractor.value ||
                          !controller.tender.value.opened.value
                      ? null
                      : takingOfferWidget(_tender.value),
          body: RefreshIndicator(
              onRefresh: () async {
                controller.refreshTasks(showMessage: true);
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
                    iconTheme:
                        IconThemeData(color: Theme.of(context).primaryColor),
                    centerTitle: true,
                    automaticallyImplyLeading: false,
                    leading: new IconButton(
                      icon: new Icon(Icons.arrow_back_ios,
                          color: Get.theme.hintColor),
                      onPressed: () =>
                          {Get.back(result: controller.tender.value)},
                    ),
                    bottom:
                        buildEServiceTitleBarWidget(controller.tender.value),
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: Obx(() {
                        return Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: <Widget>[
                            buildCarouselSlider(controller.tender.value),
                            buildCarouselBullets(controller.tender.value),
                          ],
                        );
                      }),
                    ).marginOnly(bottom: 50),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 10),
                        if (controller.tender.value.categories.isNotEmpty)
                          buildCategories(controller.tender.value),
                        if (controller.location.value.isNotEmpty)
                          AddressWidget(
                            locationString: controller.location.value,
                          ),
                        SizedBox(
                          height: 500,
                          child: ContainedTabBarView(
                            tabBarProperties: TabBarProperties(
                              labelColor: Get.theme.accentColor,
                              unselectedLabelColor: Colors.black26,
                            ),
                            tabs: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  'Details'.tr,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text('Offers'.tr),
                              )
                            ],
                            views: [description(), offers()],
                            onChange: (index) {},
                          ),
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

  description() {
    return Column(
      children: [
        EServiceTilWidget(
          title: Text("Description".tr, style: Get.textTheme.subtitle2),
          content: Text(controller.tender.value.description,
              style: Get.textTheme.bodyText1),
        ),
        EServiceTilWidget(
          title: Text("Additional info".tr, style: Get.textTheme.subtitle2),
          content: Text(controller.tender.value.additional_info ?? "",
              style: Get.textTheme.bodyText1),
        ),
        EServiceTilWidget(
          title: Text("Ways of communication".tr, style: Get.textTheme.subtitle2),
          content: Text(controller.tender.value.other_info ?? "",
              style: Get.textTheme.bodyText1),
        ),

      ],
    );
  }

  offers() {
    // controller.getOffers();
    return Obx(() => OffersListWidget(offers: controller.tenderRequests.value));
  }

  CarouselSlider buildCarouselSlider(Tenders _eService) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 7),
        height: 350,
        viewportFraction: 1.0,
        onPageChanged: (index, reason) {
          // controller.currentSlide.value = index;
        },
      ),
      items: List.generate(1, (media) {
        return Builder(
          builder: (BuildContext context) {
            return CachedNetworkImage(
              width: double.infinity,
              height: 350,
              fit: BoxFit.cover,
              imageUrl:
                  "https://i.pinimg.com/originals/80/8c/0f/808c0faeff1173563adb93d4162d6a0f.jpg",
              placeholder: (context, url) => Image.asset(
                'assets/img/loading.gif',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error_outline),
            );
          },
        );
      }).toList(),
    );
  }

  Container buildCarouselBullets(Tenders _eService) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 92, horizontal: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(1, (media) {
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
  EServiceTitleBarWidget buildEServiceTitleBarWidget(Tenders _tender) {
    return EServiceTitleBarWidget(
      height: 130,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _tender.title,
                  style: Get.textTheme.headline5,
                ),
              ),
            ],
          ),
          Wrap(
            direction: Axis.horizontal,
            children: [
              text("Start from".tr, _tender.budget + "cум" + " "),
              text("Published".tr, _tender.work_start_at),
              text("Deadline".tr, _tender.deadline),
            ],
          )
        ],
      ),
    );
  }

  text(String key, String value) {
    return Text(
      key + ": " + value,
      style: Get.textTheme.caption.merge(TextStyle(
        fontSize: 12
      )),
    );
  }

  Widget buildCategories(Tenders _tender) {
    print(_tender);
    print(_tender.categories[0].title);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 5,
        runSpacing: 8,
        children: List.generate(_tender.categories.length, (index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Text(_tender.categories[index].title ?? "",
                style: Get.textTheme.caption),
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

  Widget takingOfferWidget(Tenders _tenders) {
    return ContainerForButtons(
      child: BlockButtonWidget(
          text: Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Take offer".tr,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.headline6.merge(
                    TextStyle(color: Get.theme.primaryColor),
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios,
                  color: Get.theme.primaryColor, size: 20)
            ],
          ),
          color: Get.theme.accentColor,
          onPressed: () {
            Get.toNamed(Routes.TAKE_OFFER, arguments: _tenders);
          }).paddingOnly(right: 20, left: 20),
    );
  }

  Widget edditOrDelete(final _tenders) {
    return ContainerForButtons(
        child: Row(
      children: [
        Expanded(
          child: BlockButtonWidget(
              text: SizedBox(
                width: double.infinity,
                child: Text(
                  "Update".tr,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.headline6.merge(
                    TextStyle(color: Get.theme.primaryColor),
                  ),
                ),
              ),
              color: Get.theme.accentColor,
              onPressed: () async {
                final result = await Get.toNamed(Routes.TASK_MODIFY,
                    arguments: _tenders.value);
                if (result != null) {
                  _tenders(result);
                  controller.getLocation();
                  print(_tenders.value.toJson());
                }
              }).paddingOnly(right: 20, left: 20),
        ),
        Expanded(
          child: BlockButtonWidget(
              text: SizedBox(
                width: double.infinity,
                child: Text(
                  "Delete".tr,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.headline6.merge(
                    TextStyle(color: Get.theme.primaryColor),
                  ),
                ),
              ),
              color: Get.theme.accentColor,
              onPressed: () async {
                final result = await Get.bottomSheet(
                  DeleteTender(),
                  isScrollControlled: true,
                );
              }).paddingOnly(right: 20, left: 20),
        ),
      ],
    ));
  }

  Widget ContainerForButtons({Widget child}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Get.theme.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
              color: Get.theme.focusColor.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -5)),
        ],
      ),
      child: child,
    );
  }
}
