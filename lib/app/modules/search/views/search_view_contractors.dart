import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:itcase/app/modules/search/controllers/search_controller.dart';
import 'package:itcase/app/modules/search/views/search_view.dart';
import 'package:itcase/app/modules/search/widgets/search_contractors_list_widget.dart';


class SearchViewContractors extends GetView<SearchController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search".tr,
          style: context.textTheme.headline6,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
      ),
      body: ListView(
        children: [
          SearchView().buildSearchBar(heroTag: true, onSubmit: controller.searchEServices),
          Container(
              height: Get.height*0.8,
              child: SearchContractorsListWidget()),
        ],
      ),
    );
  }

}