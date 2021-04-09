import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:itcase/app/models/category_model.dart';
import 'package:itcase/app/modules/category/controllers/categories_controller.dart';
import 'package:itcase/app/modules/category/widgets/category_grid_item_widget.dart';
import 'package:itcase/app/modules/category/widgets/category_list_item_widget.dart';
import 'package:itcase/app/modules/e_service/views/e_service_view.dart';
import 'package:itcase/app/modules/tasks/views/my_task.dart';
import 'package:itcase/app/modules/tasks/views/task_page.dart';
import 'package:itcase/app/services/auth_service.dart';

import '../../../global_widgets/search_bar_widget.dart';

class HomeView extends GetView<CategoriesController> {
  @override
  Widget build(BuildContext context) {
    // print(Get.arguments);
    GetStorage box = new GetStorage();
    var b = box.read('current_user');
    print(b);
    if (Get.find<AuthService>().isAuth) print("True");
    final currentUser = Get.find<AuthService>().user;
    var cur = currentUser.value.token;
    print(cur);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Categories".tr,
            style: Get.textTheme.headline6
                .merge(TextStyle(color: context.theme.primaryColor)),
          ),
          centerTitle: true,
          backgroundColor: Get.theme.accentColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(Icons.sort, color: Colors.white),
            onPressed: () => {Scaffold.of(context).openDrawer()},
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.refreshCategories(showMessage: true);
          },
          child: ListView(
            primary: true,
            children: [
              SearchBarWidget().paddingSymmetric(horizontal: 20, vertical: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: Row(children: [
                  Expanded(
                    child: Text(
                      "Categories of services".tr,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  RaisedButton(
                    child: Text("Booking"),
                    onPressed: () async {
                      // Get.to(TaskPage());
                      // Get.to(MyTaskView());
                    },
                  )
                  /*
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          controller.layout.value = CategoriesLayout.LIST;
                        },
                        icon: Obx(() {
                          return Icon(
                            Icons.format_list_bulleted,
                            color:
                                controller.layout.value == CategoriesLayout.LIST
                                    ? Get.theme.accentColor
                                    : Get.theme.focusColor,
                          );
                        }),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.layout.value = CategoriesLayout.GRID;
                        },
                        icon: Obx(() {
                          return Icon(
                            Icons.apps,
                            color:
                                controller.layout.value == CategoriesLayout.GRID
                                    ? Get.theme.accentColor
                                    : Get.theme.focusColor,
                          );
                        }),
                      )
                    ],
                  ),*/
                ]),
              ),
              // Obx(() {
              //   return Offstage(
              //     offstage: controller.layout.value != CategoriesLayout.GRID,
              //     child: StaggeredGridView.countBuilder(
              //       primary: false,
              //       shrinkWrap: true,
              //       crossAxisCount: 4,
              //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //       itemCount: controller.categories.length,
              //       itemBuilder: (BuildContext context, int index) {
              //         return CategoryGridItemWidget(
              //             category: controller.categories.elementAt(index),
              //             heroTag: "heroTag");
              //       },
              //       staggeredTileBuilder: (int index) => new StaggeredTile.fit(
              //           Get.mediaQuery.orientation == Orientation.portrait
              //               ? 2
              //               : 4),
              //       mainAxisSpacing: 15.0,
              //       crossAxisSpacing: 15.0,
              //     ),
              //   );
              // }),
              // Obx(() {
              //   return Offstage(
              //     offstage: controller.layout.value != CategoriesLayout.LIST,
              //     child: ListView.separated(
              //       scrollDirection: Axis.vertical,
              //       shrinkWrap: true,
              //       primary: false,
              //       itemCount: controller.categories.length,
              //       separatorBuilder: (context, index) {
              //         return SizedBox(height: 10);
              //       },
              //       itemBuilder: (context, index) {
              //         return CategoryListItemWidget(
              //           heroTag: 'favorites_list',
              //           category: controller.categories.elementAt(index),
              //         );
              //       },
              //     ),
              //   );
              // }),
              // Container(
              //   child: ListView(
              //       primary: false,
              //       shrinkWrap: true,
              //       children: List.generate(controller.categories.length, (index) {
              //         return Obx(() {
              //           var _category = controller.categories.elementAt(index);
              //           return Padding(
              //             padding: const EdgeInsetsDirectional.only(start: 20),
              //             child: Text(_category.name),
              //           );
              //         });
              //       })),
              // ),
              // ListView.builder()
            ],
          ),
        ));
  }
}
