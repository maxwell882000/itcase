import 'dart:math' as math; // import this

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/modules/root/controllers/root_controller.dart';
import 'package:itcase/app/modules/search/controllers/search_controller.dart';

import '../../../global_widgets/home_search_bar_widget.dart';
import '../../../models/slide_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/settings_service.dart';
import '../controllers/home_controller.dart';
import '../widgets/address_widget.dart';
import '../widgets/categories_carousel_widget.dart';
import '../widgets/featured_categories_widget.dart';
import '../widgets/tinders_carousel_widget.dart';

class Home2View extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: () async {
            controller.refreshHome(showMessage: true);
          },
          child: CustomScrollView(
            primary: true,
            shrinkWrap: false,
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Get.theme.accentColor,
                expandedHeight: 100,
                elevation: 0.5,
                // pinned: true,
                floating: true,
                iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
                title: Text(
                  Get.find<SettingsService>().setting.value.appName,
                  style: Get.textTheme.headline6,
                ),
                centerTitle: true,
                automaticallyImplyLeading: false,
                leading: new IconButton(
                  icon: new Icon(Icons.sort, color: Colors.white),
                  onPressed: () => {Scaffold.of(context).openDrawer()},
                ),
                bottom:  HomeSearchBarWidget(
                    heroTag: 'tender_search',
                    onSubmit: (SearchController controller) {
                      controller.tenders.value =
                          this.controller.tenders;
                      controller.setShowMore(controller.searchTenders);
                      controller.paginationTasks
                          .addingListener(controller: controller);
                      Get.toNamed(Routes.TENDER_SEARCH);
                    }),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Obx(() {
                    return Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: <Widget>[
                        CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 7),
                            height: 310,
                            viewportFraction: 1.0,
                            onPageChanged: (index, reason) {
                              controller.currentSlide.value = index;
                            },
                          ),
                          items: controller.slider.map((Slide slide) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Stack(
                                  //alignment: AlignmentDirectional.topStart,
                                  children: [
                                    Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.rotationY(Directionality.of(context) == TextDirection.rtl ? math.pi : 0),
                                      child: CachedNetworkImage(
                                        width: double.infinity,
                                        height: 310,
                                        fit: BoxFit.cover,
                                        imageUrl: slide.image,
                                        placeholder: (context, url) => Image.asset(
                                          'assets/img/loading.gif',
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                        errorWidget: (context, url, error) => Icon(Icons.error_outline),
                                      ),
                                    ),
                                    Container(
                                        padding: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                                        child: SizedBox(
                                          width: 180,
                                          child: Column(
                                            children: [
                                              Text(
                                                slide.title,
                                                style: Get.textTheme.headline5.merge(TextStyle(color: Colors.black87)),
                                                maxLines: 3,
                                              ),
                                              Text(
                                                slide.description,
                                                style: Get.textTheme.bodyText1.merge(TextStyle(color: Colors.black54)),
                                                maxLines: 3,
                                              ),
                                            ],
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            //direction: Axis.vertical,
                                          ),
                                        )),
                                  ],
                                );
                              },
                            );
                          }).toList(),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 70, horizontal: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: controller.slider.map((Slide slide) {
                              return Container(
                                width: 20.0,
                                height: 5.0,
                                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    color: controller.currentSlide.value == controller.slider.indexOf(slide) ? Colors.black87 : Colors.black87.withOpacity(0.4)),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  }),
                ).marginOnly(bottom: 42),
              ),

              // WelcomeWidget(),
              SliverToBoxAdapter(
                child: Wrap(
                  children: [
                    // AddressWidget(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Row(
                        children: [
                          Expanded(child: Text("Categories".tr, style: Get.textTheme.headline5)),
                          FlatButton(
                            onPressed: () {
                              Get.toNamed(Routes.CATEGORIES);
                            },
                            shape: StadiumBorder(),
                            color: Get.theme.accentColor.withOpacity(0.1),
                            child: Text("View All".tr, style: Get.textTheme.subtitle1),
                          ),
                        ],
                      ),
                    ),
                    CategoriesCarouselWidget(),
                    Container(
                      color: Get.theme.primaryColor,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Row(
                        children: [
                          Expanded(child: Text("Tasks".tr, style: Get.textTheme.headline5)),

                          FlatButton(
                            onPressed: () {
                              Get.find<RootController>().changePage(1);
                            },
                            shape: StadiumBorder(),
                            color: Get.theme.accentColor.withOpacity(0.1),
                            child: Text("View All".tr, style: Get.textTheme.subtitle1),
                          ),
                        ],
                      ),
                    ),
                    TindersCarouselWidget(),
                   // FeaturedCategoriesWidget(),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}