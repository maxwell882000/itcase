import 'package:get/get.dart';
import 'package:itcase/app/modules/auth/controllers/auth_controller.dart';

import 'package:itcase/app/modules/category/controllers/categories_controller.dart';
import 'package:itcase/app/modules/category/controllers/category_controller.dart';
import 'package:itcase/app/modules/e_service/controllers/e_service_controller.dart';
import 'package:itcase/app/modules/tasks/controllers/tender_controller.dart';

import '../../search/controllers/search_controller.dart';

import '../../account/controllers/account_controller.dart';
import '../../home/controllers/home_controller.dart';

import '../controllers/root_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RootController>(
      () => RootController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );

    Get.lazyPut<CategoriesController>(
      () => CategoriesController(),
    );

    Get.lazyPut<CategoryController>(
      () => CategoryController(),
    );
    Get.lazyPut<TenderController>(
      () => TenderController(),
      fenix: true
    );

    Get.lazyPut<AccountController>(
      () => AccountController(),
    );
    Get.lazyPut<SearchController>(
      () => SearchController(),
    );
    Get.lazyPut(() => EServiceController());
  }
}
