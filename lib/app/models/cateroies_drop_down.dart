import 'package:get/get.dart';
import 'package:itcase/app/repositories/category_repository.dart';

class CategoriesDropDown{
  List categoriesList = [];
  final List<String> subCategoriesList = List<String>().obs;
  List id = [].obs;
  final categories = "".obs;
  final subCategories = "".obs;
  final categoryRepository = new CategoryRepository();

  CategoriesDropDown(){
    begining();
  }
  Future begining() async {
    categoriesList = await categoryRepository.getAllCategoriesTender();
    categories.value = categoriesList[0][0][0];
    categoriesList[0][1].forEach((e) {
      subCategoriesList.add(e[0]);
      id.add(e[1]);
    });
  }


}