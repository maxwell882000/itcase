import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:get/get.dart';
import '../models/e_service_model.dart';
import '../models/e_service_model.dart';
import '../models/faq_category_model.dart';
import '../models/notification_model.dart';
import '../models/review_model.dart';
import '../models/slide_model.dart';
import 'package:meta/meta.dart';

import '../models/address_model.dart';
import '../models/category_model.dart';
import '../models/e_service_model.dart';
import '../models/setting_model.dart';
import '../models/task_model.dart';
import '../models/user_model.dart';
import '../services/global_service.dart';

class MockApiClient {
  final _globalService = Get.find<GlobalService>();

  String get baseUrl => _globalService.global.value.mockBaseUrl;
  static String get url => "http://itcasetest.vid.uz/";
  String get itcase_url => url + "api/";
  final Dio httpClient;
  final Options _options =
      buildCacheOptions(Duration(days: 3), forceRefresh: true);

  MockApiClient({@required this.httpClient}) {
    httpClient.interceptors
        .add(DioCacheManager(CacheConfig(baseUrl: baseUrl)).interceptor);
  }

  Future<List<User>> getAllUsers() async {
    var response =
        await httpClient.get(baseUrl + "users/all.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data']
          .map<User>((obj) => User.fromJson(obj))
          .toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<Slide>> getHomeSlider() async {
    var response =
        await httpClient.get(baseUrl + "slides/home.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data']
          .map<Slide>((obj) => Slide.fromJson(obj))
          .toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<User> getLogin() async {
    var response =
        await httpClient.get(baseUrl + "users/user.json", options: _options);
    if (response.statusCode == 200) {
      return User.fromJson(response.data['data']);
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<Address>> getAddresses() async {
    var response = await httpClient.get(baseUrl + "users/addresses.json",
        options: _options);
    if (response.statusCode == 200) {
      return response.data['data']
          .map<Address>((obj) => Address.fromJson(obj))
          .toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<EService>> getRecommendedEServices() async {
    var response = await httpClient.get(itcase_url + "contractors",
        options: _options);
    if (response.statusCode == 200) {
      List<EService> result = [];
      response.data['contractors']['data'].forEach((key, value) =>result.add( new EService.fromJson(value)));
      return result;
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<EService>> getAllEServices(String id) async {
    var response = await httpClient
        .get(itcase_url + "contractors/category/" + id, options: _options);
    if (response.statusCode == 200) {
      List<EService> result = [];
      response.data['contractors']['data'].forEach((key, value) =>result.add( new EService.fromJson(value)));
      return result;
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  // Future<List<EService>> getEservices(String id) async {
  //   var response = await httpClient
  //       .get(itcase_url + "contractors/category/" + id, options: _options);
  //   if (response.statusCode == 200) {
  //     return response.data['contractors']
  //         .map<Category>((obj) => print(obj))
  //         .toList();
  //   } else {
  //     throw new Exception(response.statusMessage);
  //   }
  // }

  Future<List<EService>> getFavoritesEServices() async {
    var response = await httpClient.get(baseUrl + "services/favorites.json",
        options: _options);
    if (response.statusCode == 200) {
      return response.data['data']
          .map<EService>((obj) => EService.fromJson(obj))
          .toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<EService> getEService(String id) async {
    var response = await httpClient
        .get(itcase_url + "contractors/category/" + id, options: _options);
    if (response.statusCode == 200) {

      return new EService.fromJson(response.data['contractor']);
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<Review>> getEServiceReviews(String eServiceId) async {
    var response = await httpClient.get(baseUrl + "services/reviews.json",
        options: _options);
    if (response.statusCode == 200) {
      return response.data['data']
          .map<Review>((obj) => Review.fromJson(obj))
          .toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<EService>> getFeaturedEServices() async {
    var response = await httpClient.get(baseUrl + "services/featured.json",
        options: _options);
    if (response.statusCode == 200) {
      return response.data['data']
          .map<EService>((obj) => EService.fromJson(obj))
          .toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<EService>> getPopularEServices() async {
    var response = await httpClient.get(baseUrl + "services/popular.json",
        options: _options);
    if (response.statusCode == 200) {
      return response.data['data']
          .map<EService>((obj) => EService.fromJson(obj))
          .toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<EService>> getMostRatedEServices() async {
    var response =
        await httpClient.get(baseUrl + "services/all.json", options: _options);
    if (response.statusCode == 200) {
      // List<EService> _services = response.data['data']
      //     .map<EService>((obj) => EService.fromJson(obj))
      //     .toList();
      // _services.sort((s1, s2) {
      //   return s2.rate.compareTo(s1.rate);
      // });
      return [];
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<EService>> getAvailableEServices() async {
    var response =
        await httpClient.get(baseUrl + "services/all.json", options: _options);
    if (response.statusCode == 200) {
      // List<EService> _services = response.data['data']
      //     .map<EService>((obj) => EService.fromJson(obj))
      //     .toList();
      // _services = _services.where((_service) {
      //   return _service.eProvider.available;
      // }).toList();
      return [];
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<Category>> getAllCategories() async {
    var response =
        await httpClient.get(itcase_url + "catalog", options: _options);
    if (response.statusCode == 200) {
      return response.data['parentCategories']
          .map<Category>((obj) => Category.fromJson(obj))
          .toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<Category>> getFeaturedCategories() async {
    var response = await httpClient.get(baseUrl + "categories/featured.json",
        options: _options);
    if (response.statusCode == 200) {
      return response.data['data']
          .map<Category>((obj) => Category.fromJson(obj))
          .toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<Task>> getTasks() async {
    var response =
        await httpClient.get(baseUrl + "tasks/all.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data']
          .map<Task>((obj) => Task.fromJson(obj))
          .toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<Notification>> getNotifications() async {
    var response = await httpClient.get(baseUrl + "notifications/all.json",
        options: _options);
    if (response.statusCode == 200) {
      return response.data['data']
          .map<Notification>((obj) => Notification.fromJson(obj))
          .toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<List<FaqCategory>> getCategoriesWithFaqs() async {
    var response =
        await httpClient.get(baseUrl + "help/faqs.json", options: _options);
    if (response.statusCode == 200) {
      return response.data['data']
          .map<FaqCategory>((obj) => FaqCategory.fromJson(obj))
          .toList();
    } else {
      throw new Exception(response.statusMessage);
    }
  }

  Future<Setting> getSettings() async {
    var response =
        await httpClient.get(baseUrl + "settings/all.json", options: _options);
    if (response.statusCode == 200) {
      return Setting.fromJson(response.data['data']);
    } else {
      throw new Exception(response.statusMessage);
    }
  }
}
