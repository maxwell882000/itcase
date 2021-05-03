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
import '../widgets/categories_carousel_widget.dart';

class HomeView extends GetView<CategoriesController> {
  @override
  Widget build(BuildContext context) {
    if (Get.find<AuthService>().isAuth) print("True");

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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                        child: Text("Categories".tr,
                            style: Get.textTheme.headline5)),
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
              CategoriesCarouselWidget(),
              Container(
                color: Get.theme.primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(children: [
                  Expanded(
                      child:
                          Text("Tasks".tr, style: Get.textTheme.headline5)),
                  FlatButton(
                    onPressed: () {},
                    shape: StadiumBorder(),
                    color: Get.theme.accentColor.withOpacity(0.1),
                    child: Text("View All".tr, style: Get.textTheme.subtitle1),
                  ),
                  RaisedButton(
                    child: Text("Booking"),
                    onPressed: () async {
                      // Get.to(TaskPage());
                      // Get.to(MyTaskView());
                    },
                  )
                ]),
              ),
            ],
          ),
        ));
  }
}
