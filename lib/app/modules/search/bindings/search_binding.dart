import 'package:get/get.dart';
import 'package:itcase/app/modules/auth/controllers/auth_controller.dart';
import 'package:itcase/app/modules/search/controllers/search_controller_map.dart';



class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchMapController>(
          () => SearchMapController(),
    );
  }
}
