import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'services_carousel_widget.dart';

class FeaturedCategoriesWidget extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetX(builder: (context) {
      return Column(
        children: List.generate(controller.featured.length, (index) {
          var _category = controller.featured.elementAt(index);
          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  children: [
                    // Expanded(child: Text(_category.name, style: Get.textTheme.headline5)),
                    FlatButton(
                      onPressed: () {},
                      shape: StadiumBorder(),
                      color: Get.theme.accentColor.withOpacity(0.1),
                      child:
                          Text("View All".tr, style: Get.textTheme.subtitle1),
                    ),
                  ],
                ),
              ),
              // ServicesCarouselWidget(services: _category.services),
            ],
          );
        }),
      );
    });
  }
}
