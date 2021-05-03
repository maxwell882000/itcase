import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:itcase/app/providers/api.dart';
import 'package:get/get.dart';
import 'package:itcase/common/loading.dart';

import '../models/category_model.dart';
import '../providers/mock_provider.dart';

class CategoryRepository {
  MockApiClient _apiClient;

  CategoryRepository() {
    this._apiClient = MockApiClient(httpClient: Dio());
  }

  Future<List<Category>> getAll() {
    return _apiClient.getAllCategories();
  }

  Future<List<Category>> getCats() async {
   var res = await API().getData('catalog');
    if (res.statusCode == 200) {
      res = jsonDecode(res.body);
      print(res);
      return res['parentCategories']
          .map<Category>((obj) => Category.fromJson(obj))
          .toList();
    } else
      return null;
  }

  Future<List<Category>> getFeatured() {
    return _apiClient.getFeaturedCategories();
  }
  Future<List> getAllCategoriesTender() async{
    var res = await API().getData('tenders/create/category');
    if (res.statusCode ==200){
      Map body = jsonDecode(res.body);
      return body['category'];
    }
    throw {'message': "Occured Error".tr};
  }
}