import 'package:dio/dio.dart';

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

  Future<List<Category>> getFeatured() {
    return _apiClient.getFeaturedCategories();
  }
}
