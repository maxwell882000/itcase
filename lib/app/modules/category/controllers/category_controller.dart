import 'package:get/get.dart';
import 'package:itcase/app/models/user_model.dart';
import 'package:itcase/app/services/auth_service.dart';
import 'package:itcase/common/pagination_contractors.dart';

import '../../../../common/ui.dart';
import '../../../models/category_model.dart';

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
  var selected = 0.obs;
  final caregoryFilter = new CategoryFilter().obs;
  final eServices = List<User>().obs;
  final isLoading = true.obs;
  final currentUser = Get.find<AuthService>().user;
  PaginationContractors pagination;

  EServiceRepository _eServiceRepository;

  CategoryController() {
    _eServiceRepository = new EServiceRepository();
  }

  @override
  void onInit()  {
    category.value = Get.arguments as Category;
    selected.value = category.value.id;
    caregoryFilter.value.setChoices([category.value.id, "All".tr]);
    pagination = new PaginationContractors();
    category.value.categories.forEach((e) => caregoryFilter.value.setChoices([
          e.id,
          e.title,
        ]));

    pagination.addingListener(controller: this);
    refreshEServices(showMessage: true);

    super.onInit();
  }


  Future refreshEServices({bool showMessage}) async {
    await getEServicesOfCategory(refresh: showMessage);
    if (showMessage == true) {
      // Get.showSnackbar(Ui.SuccessSnackBar(
      //     message: "List of contractors refreshed successfully".tr));
    }
  }

  bool isSelected(int filter) => selected.value == filter;

  void toggleSelected(int filter) {
    selected.value = filter;
  }

  Future showMore({bool refresh}) async {
    await getEServicesOfCategory(refresh: refresh);
  }

  Future getEServicesOfCategory({bool refresh = false}) async {
    try {
      if (refresh) {

        isLoading.value = true;
      }

      List data = await _eServiceRepository.getContractors(
          id:selected.value.toString(),
          page: refresh ? '1' : pagination.currentPage.value.toString());
      pagination.processData(
          refresh: refresh,
          data: data,
          contractors: eServices
      );
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
    isLoading.value = false;
  }
}
