import 'dart:convert';

import 'package:get/get.dart';
import 'package:itcase/app/models/tenders.dart';
import 'package:itcase/app/models/user_model.dart';
import 'package:itcase/app/repositories/task_repository.dart';
import 'package:itcase/common/pagination_contractors.dart';
import 'package:itcase/common/pagination_helper.dart';
import 'package:itcase/common/pagination_tenders.dart';

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
  final loading = false.obs;
  Function onSubmit = () {};
  final selected = 0.obs;
  EServiceRepository _eServiceRepository;
  CategoryRepository _categoryRepository;
  TaskRepository _taskRepository;
  Function showMore;
  final PaginationTenders paginationTasks = new PaginationTenders();
  final PaginationContractors paginationContractors = new PaginationContractors();

  Future searchEServices({bool refresh = true}) async {
    Map<String, dynamic> data = {
      'contractorSearch' : typed.value,
    };
    if (selected.value != 0)
       data['category_id'] = selected.value;
    String json = jsonEncode(data);
    if (refresh) {
      loading.value = true;
      paginationContractors.update();
    }
    try{
      final result = await _eServiceRepository.searchContractors(page:  refresh ? '1' : paginationContractors.currentPage.value.toString(), json: json);
      print(result);
      paginationContractors.processData(refresh: refresh,contractors: eServices,data: result);
    }
    catch(e){
      print(e);
      loading.value = false;
      e['errors'].forEach((key, object) =>
          Get.showSnackbar(Ui.ErrorSnackBar(message: object[0], title: key)));
    }
    loading.value = false;
  }
  void searchTenders({bool refresh = true}) async {
    Map<String, dynamic> data = {};
    if (refresh) {
      loading.value = true;
      paginationTasks.update();
    }
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
        final result = await _taskRepository.searchTender(json,page: refresh ? '1' : paginationTasks.currentPage.value.toString());
        paginationTasks.processData(
            refresh: refresh, tenders: tenders, data: result);
      } else {
        if (typed.value.isNotEmpty) {
          data.addAll({
            'search': typed.value,
          });
          String json = jsonEncode(data);
          final result =
              await _taskRepository.searchTender(json, url: 'tenders/search',page: refresh ? '1' : paginationTasks.currentPage.value.toString());
          print(result);
          paginationTasks.processData(
              refresh: refresh, tenders: tenders, data: result);
        }
      }

    } catch (e) {
      loading.value = false;
      e['errors'].forEach((key, object) =>
          Get.showSnackbar(Ui.ErrorSnackBar(message: object[0], title: key)));
    }
    loading.value = false;
  }

  void setOnSubmut(Function onSubmit) {
    this.onSubmit = onSubmit;
    update();
  }
  void setShowMore(Function showMore) {
    this.showMore = showMore;
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
    await getCategories();
    await refreshSearch();
    super.onInit();
  }

  @override
  void onReady() {

    super.onReady();
  }

  List choosenCategories() {
    return categories.value
        .where((element) => element.choose.value)
        .map((e) => e.id)
        .toList();
  }

  List allIdCategories() {
    return categories.value.map((e) => e.id).toList();
  }

  Future refreshSearch({bool showMessage}) async {
    await searchEServices();
    if (showMessage == true) {
      Get.showSnackbar(Ui.SuccessSnackBar(
          message: "List of services refreshed successfully".tr));
    }
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
