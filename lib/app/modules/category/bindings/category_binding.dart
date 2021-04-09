import 'package:get/get.dart';
import 'package:itcase/app/modules/search/controllers/search_controller.dart';

import '../controllers/categories_controller.dart';
import '../controllers/category_controller.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryController>(
      () => CategoryController(),
    );
    Get.lazyPut<CategoriesController>(
      () => CategoriesController(),
    );
    Get.lazyPut<SearchController>(
      () => SearchController(),
    );
  }
}
