import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:itcase/app/modules/search/controllers/search_controller.dart';
import 'package:itcase/app/routes/app_pages.dart';

import '../../../global_widgets/home_search_bar_widget.dart';
import '../../home/widgets/address_widget.dart';
import '../controllers/category_controller.dart';
import '../widgets/services_list_widget.dart';

class CategoryView extends GetView<CategoryController> {
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
                controller.category.value.title,
                style: Get.textTheme.headline6
                    .merge(TextStyle(color: Get.theme.primaryColor)),
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back_ios,
                    color: Get.theme.primaryColor),
                onPressed: () => {controller.onClose(), Get.back()},
              ),
              flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 75, bottom: 115),
                        decoration: new BoxDecoration(
                          gradient: new LinearGradient(
                              colors: [
                                controller.category.value.backGround.withOpacity(1),
                                controller.category.value.backGround.withOpacity(0.2)
                              ],
                              begin: AlignmentDirectional.topStart,
                              //const FractionalOffset(1, 0),
                              end: AlignmentDirectional.bottomEnd,
                              stops: [0.1, 0.9],
                              tileMode: TileMode.clamp),
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
                              )
                        ),
                      ),
                    ],
                  )).marginOnly(bottom: 42),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  HomeSearchBarWidget().buildSearchBar(
                      heroTag: 'contractor_search',
                      onSubmit: (SearchController controller) {
                        controller.eServices(
                            this.controller.eServices.value);
                        controller.setShowMore(controller.searchEServices);
                        controller.selected.value = this.controller.selected.value;
                        controller.paginationContractors
                            .addingListener(controller: controller);
                        Get.toNamed(Routes.CONTRACTOR_SEARCH);
                      }),
                  Container(
                    height: 60,
                    child: ListView(
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                            controller.caregoryFilter.value.choices.length,
                            (index) {
                          var _filter =
                              controller.caregoryFilter.value.choices[index];

                          return Obx(() {
                            return Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(start: 20),
                              child: RawChip(
                                elevation: 0,
                                label: Text(_filter[1]),
                                labelStyle: controller.isSelected(_filter[0])
                                    ? Get.textTheme.bodyText2.merge(TextStyle(
                                        color: Get.theme.primaryColor))
                                    : Get.textTheme.bodyText2,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 15),
                                backgroundColor: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.1),
                                selectedColor: Colors.orangeAccent,
                                selected: controller.isSelected(_filter[0]),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                showCheckmark: true,
                                checkmarkColor: Get.theme.primaryColor,
                                onSelected: (bool value) {
                                  controller.pagination.update();
                                  controller.toggleSelected(_filter[0]);
                                  controller.getEServicesOfCategory(
                                    refresh: true,
                                  );
                                },
                              ),
                            );
                          });
                        })),
                  ),
                  Container(
                    height: Get.height*0.8,
                      child: Obx(()=> ServicesListWidget(services: controller.eServices.value,controller: controller,))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
