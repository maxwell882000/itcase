import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/repositories/category_repository.dart';

import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'package:itcase/app/global_widgets/circular_loading_widget.dart';
import 'package:itcase/app/models/category_model.dart';
import 'package:itcase/app/models/media_model.dart';
import 'package:itcase/app/modules/account/widgets/account_link_widget.dart';
import 'package:itcase/app/modules/e_service/widgets/e_service_til_widget.dart';
import 'package:itcase/app/modules/e_service/widgets/e_service_title_bar_widget.dart';
import 'package:itcase/app/modules/e_service/widgets/review_item_widget.dart';
import 'package:itcase/app/modules/tasks/views/images.dart';
import 'package:itcase/app/modules/tasks/views/map.dart';
import 'package:itcase/common/ui.dart';
import '../../../global_widgets/text_field_widget.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _profileForm = new GlobalKey<FormState>();
  var tm = [
    {
      "id": "5fb973cb5b8966fafcf32cd4",
      "url": "http://lorempixel.com/400/400/business/4/",
      "thumb": "http://lorempixel.com/200/200/business/2/",
      "icon": "http://lorempixel.com/100/100/business/5/"
    },
    {
      "id": "5fb973cb89d73bc2a2b30e0d",
      "url": "http://lorempixel.com/400/400/business/5/",
      "thumb": "http://lorempixel.com/200/200/business/2/",
      "icon": "http://lorempixel.com/100/100/business/2/"
    },
    {
      "id": "5fb973cba798817e5b828d8d",
      "url": "http://lorempixel.com/400/400/business/2/",
      "thumb": "http://lorempixel.com/200/200/business/5/",
      "icon": "http://lorempixel.com/100/100/business/3/"
    },
    {
      "id": "5fb973cbb5e9ecd0ac6ae238",
      "url": "http://lorempixel.com/400/400/business/4/",
      "thumb": "http://lorempixel.com/200/200/business/5/",
      "icon": "http://lorempixel.com/100/100/business/3/"
    },
    {
      "id": "5fb973cbd1811c413e82f851",
      "url": "http://lorempixel.com/400/400/business/2/",
      "thumb": "http://lorempixel.com/200/200/business/2/",
      "icon": "http://lorempixel.com/100/100/business/2/"
    }
  ];
  var re = [
    {
      "id": "5fb973cb215352e540f96dd4",
      "rate": 2.49,
      "review":
          "Non magna ipsum duis qui sunt pariatur do reprehenderit proident ipsum ipsum qui labore ut. Pariatur ad ea nulla ea nulla ea proident duis voluptate occaecat sunt consectetur velit consequat. Exercitation fugiat aliqua laborum eiusmod sint elit nulla. Sint officia reprehenderit aute in deserunt irure ullamco enim sint esse reprehenderit Lorem. Dolore dolor consequat sit magna mollit minim magna labore quis nisi culpa Lorem cillum exercitation. Labore do et incididunt adipisicing esse elit anim laborum in aliqua.\r\n",
      "datetime": "2020-05-29T04:16:18 -01:00"
    },
    {
      "id": "5fb973cbe9b93f5d400cc803",
      "rate": 2.6,
      "review":
          "Enim enim mollit sit magna eu aute do ex incididunt amet aliquip sit officia aliquip. Occaecat commodo ea fugiat excepteur incididunt id qui irure dolore labore labore sint ullamco. Incididunt eu labore sunt minim. Ea cupidatat consectetur ad culpa eiusmod excepteur incididunt voluptate ea sint ea amet ad.\r\n",
      "datetime": "2019-10-10T02:41:46 -01:00"
    },
    {
      "id": "5fb973cbb5168e3fe9dce4f2",
      "rate": 3.82,
      "review":
          "Aute sunt nisi laborum pariatur amet tempor consectetur elit reprehenderit laborum Lorem consectetur consequat nostrud. Elit ea anim mollit sint est. Elit mollit id deserunt sint. In velit laborum tempor ex nisi reprehenderit est. Aute adipisicing qui est deserunt veniam sit aute sit aliqua tempor voluptate.\r\n",
      "datetime": "2020-01-01T09:55:03 -01:00"
    },
    {
      "id": "5fb973cb6396e2d0bf403269",
      "rate": 4.48,
      "review":
          "Adipisicing sint sit id eiusmod aute proident Lorem occaecat excepteur duis. Duis aute duis aute velit quis ut labore irure. Nulla officia veniam esse elit do labore enim. Voluptate labore dolor officia culpa eu. Qui commodo eiusmod mollit sit reprehenderit ipsum. Enim deserunt laboris consectetur id. Adipisicing ex sit duis veniam dolor ea ipsum pariatur culpa sit.\r\n",
      "datetime": "2020-05-08T01:43:40 -01:00"
    }
  ];
  bool offers;
  TabController _controller;

  @override
  void initState() {
    offers = false;
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }

  var ind = 0;

  CarouselSlider buildCarouselSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 7),
        height: 350,
        viewportFraction: 1.0,
        onPageChanged: (index, reason) {
          setState(() {
            ind = index;
          });
        },
      ),
      items: tm.map((val) {
        return Builder(
          builder: (BuildContext context) {
            return Hero(
              tag: val['id'],
              child: CachedNetworkImage(
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
                imageUrl: val['url'],
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

  Container buildCarouselBullets() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 92, horizontal: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: tm.map((val) {
          return Container(
            width: 20.0,
            height: 5.0,
            margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: ind == tm.indexOf(val)
                    ? Get.theme.hintColor
                    : Get.theme.primaryColor.withOpacity(0.4)),
          );
        }).toList(),
      ),
    );
  }

  EServiceTitleBarWidget buildEServiceTitleBarWidget() {
    return EServiceTitleBarWidget(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Search engine optimization online furniture store",
                  style: Get.textTheme.headline5,
                ),
              ),
              Text(
                "Start from".tr,
                style: Get.textTheme.caption,
              ),
            ],
          ),
          //   Row(
          //     children: [
          //       Expanded(
          //         child: Wrap(
          //           crossAxisAlignment: WrapCrossAlignment.end,
          //           children: List.from(Ui.getStarsList(4.7))
          //             ..addAll([
          //               SizedBox(width: 5),
          //               Text(
          //                 "Reviews (%s)".trArgs(["100"]),
          //                 style: Get.textTheme.caption,
          //               ),
          //             ]),
          //         ),
          //       ),
          //       Ui.getPrice(
          //         7.5,
          //         style: Get.textTheme.headline3
          //             .merge(TextStyle(color: Get.theme.accentColor)),
          //         unit: "Fixed" != 'fixed' ? "/h".tr : null,
          //       ),
          //     ],
          //   ),
        ],
      ).marginOnly(bottom: 10),
    );
  }

// Widget buildCategories() {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: Wrap(
//         alignment: WrapAlignment.start,
//         spacing: 5,
//         runSpacing: 8,
//         children: List.generate(_eService.categories.length, (index) {
//               var _category = _eService.categories.elementAt(index);
//               return Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                 child: Text(_category.ru_title,
//                     style: Get.textTheme.bodyText1
//                         .merge(TextStyle(color: _category.color))),
//                 decoration: BoxDecoration(
//                     color: _category.color.withOpacity(0.2),
//                     border: Border.all(
//                       color: _category.color.withOpacity(0.1),
//                     ),
//                     borderRadius: BorderRadius.all(Radius.circular(20))),
//               );
//             }) +
//             List.generate(_eService.subCategories.length, (index) {
//               return Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                 child: Text(_eService.subCategories.elementAt(index).ru_title,
//                     style: Get.textTheme.caption),
//                 decoration: BoxDecoration(
//                     color: Get.theme.primaryColor,
//                     border: Border.all(
//                       color: Get.theme.focusColor.withOpacity(0.2),
//                     ),
//                     borderRadius: BorderRadius.all(Radius.circular(20))),
//               );
//             }),
//       ),
//     );
//   }

  CategoryRepository cat = new CategoryRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TASK ID 958626".tr,
          style: TextStyle(color: Get.theme.primaryColor),
        ),
        centerTitle: true,
        backgroundColor: Get.theme.accentColor,
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Get.theme.primaryColor),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: Get.theme.focusColor.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, -5)),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: FlatButton(
                onPressed: () async {},
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Get.theme.accentColor,
                child: Text("Edit".tr,
                    style: Get.textTheme.bodyText2
                        .merge(TextStyle(color: Get.theme.primaryColor))),
              ),
            ),
            SizedBox(width: 10),
            FlatButton(
              onPressed: () {
                var a = cat.getAll();
                print(a);
              },
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Get.theme.hintColor.withOpacity(0.1),
              child: Text("Delete".tr, style: Get.textTheme.bodyText2),
            ),
          ],
        ).paddingSymmetric(horizontal: 20),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Valid",
                            style: TextStyle(
                                color: Colors.green.withOpacity(0.7),
                                fontSize: 10),
                          ),
                          Text(
                            "until: 15.12.2020",
                            style:
                                TextStyle(color: Colors.black45, fontSize: 10),
                          ).paddingSymmetric(horizontal: 5),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.remove_red_eye,
                            color: Colors.black45,
                            size: 16,
                          ).paddingSymmetric(horizontal: 5),
                          Text(
                            "66",
                            style:
                                TextStyle(color: Colors.black45, fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    "Search engine optimization online furniture store",
                    style: TextStyle(color: Get.theme.hintColor, fontSize: 20),
                  ).paddingAll(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.monetization_on,
                            color: Colors.black45,
                            size: 16,
                          ).paddingOnly(right: 5),
                          Text(
                            "250000 UZS",
                            style: TextStyle(
                                color: Get.theme.accentColor, fontSize: 12),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.event_available,
                            color: Colors.black45,
                            size: 16,
                          ).paddingOnly(right: 5),
                          Text(
                            "01.12.2020",
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 11,
                            ),
                          )
                        ],
                      ),
                    ],
                  ).marginSymmetric(horizontal: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.black45,
                        size: 14,
                      ).paddingOnly(right: 5),
                      Text(
                        "Uzbekistan, Tashkent, Chilanzar 21",
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 10,
                        ),
                      )
                    ],
                  ).marginOnly(top: 10, right: 10),
                ],
              ),
            ).paddingAll(10),
            Container(
              decoration:
                  new BoxDecoration(color: Theme.of(context).primaryColor),
              child: new TabBar(
                controller: _controller,
                labelColor: Get.theme.accentColor,
                unselectedLabelColor: Colors.black45,
                tabs: [
                  new Tab(
                    text: 'Details',
                  ),
                  new Tab(
                    text: 'Suggestions',
                  ),
                ],
              ),
            ),
            Container(
              height: Get.height * 0.63,
              child: TabBarView(
                controller: _controller,
                children: <Widget>[
                  Card(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // buildCategories(),
                          EServiceTilWidget(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Description".tr,
                                    style: Get.textTheme.subtitle2),
                                Container(
                                  width: 80,
                                  child: Text("Available".tr,
                                      maxLines: 1,
                                      style: Get.textTheme.bodyText2.merge(
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 6),
                                ),
                              ],
                            ),
                            content: Column(
                              children: [
                                Text(
                                  "Search engine optimization of an online furniture store is required. Search engine optimization of an online furniture store is required.Search engine optimization of an online furniture store is required.Search engine optimization of an online furniture store is required.Search engine optimization of an online furniture store is required.Search engine optimization of an online furniture store is required.Search engine optimization of an online furniture store is required.Search engine optimization of an online furniture store is required.Search engine optimization of an online furniture store is required.Search engine optimization of an online furniture store is required.Search engine optimization of an online furniture store is required.Search engine optimization of an online furniture store is required.Search engine optimization of an online furniture store is required.Search engine optimization of an online furniture store is required.Search engine optimization of an online furniture store is required.",
                                  style: Get.textTheme.bodyText1,
                                ).marginSymmetric(vertical: 5),
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
                                              .merge(TextStyle(fontSize: 10))),
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
                              ],
                            ),
                          ),
                          Last(
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.phone_iphone,
                                      color: Colors.black54,
                                      size: 18,
                                    ).paddingOnly(right: 5),
                                    Text(
                                      "+998993792894",
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ],
                                ).paddingAll(5),
                              ],
                            ),
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: 400.0,
                            ),
                            child: YandexMap()
                          ),
                          Container(
                            width: Get.width * 0.8,
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                        "Receive email notification about new offers")),
                                Switch(
                                  value: offers ?? false,
                                  onChanged: (val) {
                                    setState(() {
                                      offers = val;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ).marginOnly(bottom: 20),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: SingleChildScrollView(
                      child: EServiceTilWidget(
                        title: Text("Reviews & Ratings".tr,
                            style: Get.textTheme.subtitle2),
                        content: Column(
                          children: [
                            Text("3.7", style: Get.textTheme.headline1),
                            Wrap(
                              children: Ui.getStarsList(3.7, size: 32),
                            ),
                            Text(
                              "Reviews (%s)".trArgs(["57"]),
                              style: Get.textTheme.caption,
                            ).paddingOnly(top: 10),
                            Divider(height: 35, thickness: 1.3),
                            Container(
                              child: Column(children: []),
                            ),
                            /*Obx(() {
                      var review = 1;
                      if (review == 0) {
                        return CircularLoadingWidget(height: 100);
                      }
                      return ListView.separated(
                        padding: EdgeInsets.all(0),
                        itemBuilder: (context, index) {
                          return ReviewItemWidget(review: re[index]['review']);
                        },
                        separatorBuilder: (context, index) {
                          return Divider(height: 35, thickness: 1.3);
                        },
                        itemCount: re.length,
                        primary: false,
                        shrinkWrap: true,
                      );
                    }),*/
                          ],
                        ),
                        actions: [
                          InkWell(
                            onTap: () {
                              // Get.offAllNamed(Routes.REGISTER);
                            },
                            child: Text("View All".tr,
                                style: Get.textTheme.subtitle1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

box(child) {
  return Container(
    padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
    margin: EdgeInsets.only(top: 0, left: 20, right: 20),
    decoration: BoxDecoration(
        color: Get.theme.primaryColor,
        boxShadow: [
          BoxShadow(
              color: Get.theme.focusColor.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 5)),
        ],
        border: Border.all(color: Get.theme.focusColor.withOpacity(0.1))),
    child: child,
  );
}

Last(child) {
  return Container(
    padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
    margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
    decoration: BoxDecoration(
        color: Get.theme.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
        boxShadow: [
          BoxShadow(
              color: Get.theme.focusColor.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 5)),
        ],
        border: Border.all(color: Get.theme.focusColor.withOpacity(0.1))),
    child: child,
  );
}
