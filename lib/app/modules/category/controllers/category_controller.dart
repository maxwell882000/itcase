import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/category_model.dart';
import '../../../models/e_service_model.dart';
import '../../../repositories/e_service_repository.dart';

enum CategoryFilter { ALL, AVAILABILITY, RATING, FEATURED, POPULAR }

class CategoryController extends GetxController {
  final category = new Category().obs;
  final selected = Rx<CategoryFilter>();
  final eServices = List<EService>().obs;
  EServiceRepository _eServiceRepository;

  CategoryController() {
    _eServiceRepository = new EServiceRepository();
  }

  @override
  Future<void> onInit() async {
    category.value = Get.arguments as Category;
    selected.value = CategoryFilter.ALL;
    await refreshEServices();
    super.onInit();
  }

  Future refreshEServices({bool showMessage}) async {
    await getEServicesOfCategory(filter: selected.value);
    if (showMessage == true) {
      Get.showSnackbar(Ui.SuccessSnackBar(message: "List of services refreshed successfully".tr));
    }
  }

  bool isSelected(CategoryFilter filter) => selected == filter;

  void toggleSelected(CategoryFilter filter) {
    if (isSelected(filter)) {
      selected.value = CategoryFilter.ALL;
    } else {
      selected.value = filter;
    }
  }

  Future getEServicesOfCategory({CategoryFilter filter}) async {
    try {
      eServices.value = [];
      switch (filter) {
        case CategoryFilter.ALL:
          eServices.value = await _eServiceRepository.getAll();
          break;
        case CategoryFilter.FEATURED:
          eServices.value = await _eServiceRepository.getFeatured();
          break;
        case CategoryFilter.POPULAR:
          eServices.value = await _eServiceRepository.getPopular();
          break;
        case CategoryFilter.RATING:
          eServices.value = await _eServiceRepository.getMostRated();
          break;
        case CategoryFilter.AVAILABILITY:
          eServices.value = await _eServiceRepository.getAvailable();
          break;
        default:
          eServices.value = await _eServiceRepository.getAll();
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }
}
