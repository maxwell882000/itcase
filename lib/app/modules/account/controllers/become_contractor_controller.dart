import 'dart:convert';

import 'package:get/get.dart';
import 'package:itcase/app/models/cateroies_drop_down.dart';
import 'package:itcase/app/models/tenders.dart';
import 'package:itcase/app/modules/account/controllers/account_controller.dart';
import 'package:itcase/app/repositories/user_repository.dart';
import 'package:itcase/app/services/auth_service.dart';
import 'package:itcase/common/ui.dart';

class BecomeContractorController extends GetxController {
  CategoriesDropDown categoriesDropDown;
  List current = [];
  List subCategory = [];
  List category = [];
  final priceFrom = "".obs;
  final priceTo = "".obs;
  final preLastSub = 0.obs;
  final preLastCat = 0.obs;
  final pricePer = "".obs;
  List<Map> submit = [];
  final isChosen = false.obs;
  final loading = false.obs;
  UserRepository _userRepository;

  BecomeContractorController() {
    _userRepository = new UserRepository();
  }

  @override
  void onInit() async {
    categoriesDropDown = new CategoriesDropDown();
    await categoriesDropDown.begining();
    print(categoriesDropDown.categoriesList);
    super.onInit();
  }

  Future submitProfessional() async {
    loading.value = true;
    try {
      if (submit.isEmpty) throw "Please choose the category".tr;
      print(submit);
      final result = await _userRepository
          .saveProfessional(jsonEncode({'categories': submit}));

      await Get.showSnackbar(Ui.SuccessSnackBar(
          message: result['message']));
      final currentUser = Get.find<AuthService>().user;
      final accountSee = Get.find<AccountController>().accountSee;

      currentUser.update((val) {
        val.isContractor.value = true;
      });
      if (accountSee != null) {
        accountSee.value.setValues(currentUser, true);
      }
      Get.back();
    } catch (e) {
      loading.value = false;
      Get.showSnackbar(Ui.ErrorSnackBar(message: e));
    }
  }
}
