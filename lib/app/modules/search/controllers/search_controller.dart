import 'dart:convert';

import 'package:get/get.dart';
import 'package:itcase/app/models/tenders.dart';
import 'package:itcase/app/models/user_model.dart';
import 'package:itcase/app/repositories/task_repository.dart';
import 'package:itcase/common/pagination_helper.dart';

import '../../../../common/ui.dart';
import '../../../models/category_model.dart';
import '../../../models/e_service_model.dart';
import '../../../repositories/category_repository.dart';
import '../../../repositories/e_service_repository.dart';

class SearchController extends GetxController {
  final heroTag = "".obs;
  final categories = List<Category>(0).obs;
  final check = true.obs;
  final eServices = List<User>().obs;
  final typed = "".obs;
  final tenders = List<Tenders>().obs;
  Function onSubmit = () {};
  EServiceRepository _eServiceRepository;
  CategoryRepository _categoryRepository;
  TaskRepository _taskRepository;
  final PaginationHelper paginationHelper = new PaginationHelper();

  void searchTenders() async {
    Map<String, dynamic> data = {};
    try {
      if (choosenCategories().isNotEmpty) {
        data.addAll({
          'categories': choosenCategories(),
        });
        if (typed.value.isNotEmpty) {
          data.addAll({
            'terms': typed.value,
          });
        }
        String json = jsonEncode(data);
        print('asdsadsadsasadasdasd');
        print(data);
        final result = await _taskRepository.searchTender(json);
        tenders.value = result[0];
        paginationHelper.lastPage.value = result[1];
        paginationHelper.currentPage.value = result[2] + 1;
      } else {
        if (typed.value.isNotEmpty) {
          data.addAll({
            'search': typed.value,
          });
          String json = jsonEncode(data);
          final result = await _taskRepository.searchTender(json,url: 'tenders/search');
          tenders.value = result[0];
          paginationHelper.lastPage.value = result[1];
          paginationHelper.currentPage.value = result[2] + 1;
        }
      }
    } catch (e) {
      print(e);
      e['errors'].forEach((key, object) =>
          Get.showSnackbar(Ui.ErrorSnackBar(message: object[0], title: key)));
    }
  }

  void setOnSubmut(Function onSubmit) {
    this.onSubmit = onSubmit;
    update();
  }

  SearchController() {
    _eServiceRepository = new EServiceRepository();
    _categoryRepository = new CategoryRepository();
    _taskRepository = new TaskRepository();
  }

  @override
  void onInit() async {
    heroTag.value = Get.arguments as String;
    await refreshSearch();
    super.onInit();
  }

  @override
  void onReady() {
    // tenders.value = Get.arguments[1] as List<Tenders>;
    super.onReady();
  }

  List choosenCategories() {
    return categories.value
        .where((element) => element.choose.value)
        .map((e) => e.id)
        .toList();
  }
  List allIdCategories(){
    return categories.value.map((e) => e.id).toList();
  }
  Future refreshSearch({bool showMessage}) async {
    await searchEServices();
    if (showMessage == true) {
      Get.showSnackbar(Ui.SuccessSnackBar(
          message: "List of services refreshed successfully".tr));
    }
  }

  Future searchEServices({String keywords}) async {
    // try {
    //   eServices.assignAll(await _eServiceRepository.getAll());
    //   if (keywords != null && keywords.isNotEmpty) {
    //     eServices.assignAll( eServices.where((EService _service) {
    //       return _service.title.toLowerCase().contains(keywords.toLowerCase());
    //     }).toList());
    //   }
    // } catch (e) {
    //   Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    // }
  }

  Future getCategories() async {
    try {
      _categoryRepository.getAll().then((value) {
        categories.clear();
        return value;
      }).then((value) {
        categories.assignAll(value);
      });
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }
}
