import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/category_model.dart';
import '../../../repositories/category_repository.dart';

enum CategoriesLayout { GRID, LIST }

class CategoriesController extends GetxController {
  CategoryRepository _categoryRepository;

  final categories = <Category>[].obs;
  final layout = CategoriesLayout.LIST.obs;

  CategoriesController() {
    _categoryRepository = new CategoryRepository();
  }

  @override
  Future<void> onInit() async {
    await refreshCategories();
    super.onInit();
  }

  Future refreshCategories({bool showMessage}) async {
    await getCategories();
    if (showMessage == true) {
      Get.showSnackbar(Ui.SuccessSnackBar(
          message: "List of categories refreshed successfully".tr));
    }
  }
  Future searchCategory({String keywords}) async {
    try {
      categories.assignAll(await _categoryRepository.getAll());
      if (keywords != null && keywords.isNotEmpty) {
        categories.assignAll( categories.where((_categories) {
          return _categories.title.toLowerCase().contains(keywords.toLowerCase());
        }).toList());
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getCategories() async {
    try {
      categories.assignAll(await _categoryRepository.getAll());
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }
}