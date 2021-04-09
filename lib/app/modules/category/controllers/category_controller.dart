import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/category_model.dart';
import '../../../models/e_service_model.dart';
import '../../../models/e_service_model.dart';
import '../../../models/subcategory_model.dart';
import '../../../repositories/e_service_repository.dart';

class CategoryFilter {

  List choices;

  CategoryFilter() {
    choices = [];
  }

  void setChoices(List additional) {
    choices.add(additional);
  }
}

class CategoryController extends GetxController {
  final category = new Category().obs;
  var selected  =  0.obs;
  final caregoryFilter = new CategoryFilter().obs;
  final eServices = List<EService>().obs;
  EServiceRepository _eServiceRepository;

  CategoryController() {
    _eServiceRepository = new EServiceRepository();
  }

  @override
  Future<void> onInit() async {
    category.value = Get.arguments as Category;
    selected.value = category.value.id;
    caregoryFilter.value.setChoices([
       category.value.id,
      "Все пользователи"
    ]);

    category.value.categories.forEach((e) => caregoryFilter.value.setChoices([
          e.id,
          e.title,
        ]));

    print(caregoryFilter.value.choices);
    await refreshEServices();
    super.onInit();
  }

  Future refreshEServices({bool showMessage}) async {
    await getEServicesOfCategory(filter: selected.value);
    if (showMessage == true) {
      Get.showSnackbar(Ui.SuccessSnackBar(
          message: "List of services refreshed successfully".tr));
    }
  }

  bool isSelected(int filter) => selected.value == filter;

  void toggleSelected(int filter) {
    selected.value = filter;

    // if (isSelected(filter)) {
    //   selected.value.selected = 0;
    // } else {
    //
    // }
  }

  Future getEServicesOfCategory({int filter}) async {
    try {
      eServices.assignAll([]);
      eServices.assignAll(await _eServiceRepository.getAllCategories(filter.toString()));
      print(eServices.first.id);
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }
}
