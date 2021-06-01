import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:itcase/app/models/tender_requests.dart';
import 'package:itcase/app/models/tenders.dart';
import 'package:itcase/app/providers/api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:itcase/app/services/auth_service.dart';
import 'package:itcase/common/loading.dart';
import '../models/task_model.dart';
import '../providers/mock_provider.dart';

class TaskRepository {
  final currentUser = Get.find<AuthService>().user;

  Future<List<Tenders>> searchMap(String json) async {
    print(json);
    final result = await API().post(json, 'tenders/maps-filter');
    final body = jsonDecode(result.body);
    print(body);
    if (result.statusCode == 200) {
      return body.map<Tenders>((e) => new Tenders.fromJson(e)).toList();
    }
    throw "Error Occured".tr;
  }

  Future<List> getTenders({String page = "1", String url = "tenders", String json = ""}) async {
    String paginate = "?page=" + page;
    var result;
    if (json.isEmpty)
      result = await API().getData(url + paginate);
    else
      result = await API().post(json, "$url$paginate");
    if (result.statusCode == 200) {
      Map body = jsonDecode(result.body);
      try {
        List response = [
          body['tenders']['data']
              .map<Tenders>((obj) => Tenders.fromJson(obj))
              .toList(),
          body['tenders']['last_page'],
          body['tenders']['current_page'],
        ];
        if (body.containsKey('tendersCount')) {
          response.add(body['tendersCount']);
        }
        return response;
      } catch (e) {
        print(e);
        print(body);
        List<Tenders> result = [];
        body['tenders']['data']
            .forEach((key, obj) => result.add(Tenders.fromJson(obj)));
        List response = [
          result,
          body['tenders']['last_page'],
          body['tenders']['current_page'],
        ];
        if (body.containsKey('tendersCount')) {
          response.add(body['tendersCount']);
        }
        return response;
      }
    }
    throw "Error Occured".tr;
  }

  Future<List> searchTender(String json,
      {String url = "tenders/text-filter", String page='1'}) async {
    print(json);
    return getTenders(page: page, url: url, json:json);
    // final result = await API().post(json, "$url?page=");
    // Map body = jsonDecode(result.body);
    // if (result.statusCode == 200) {
    //   List<Tenders> result = [];
    //   print(body);
    //   body['tenders']['data']
    //       .forEach((obj) => result.add(new Tenders.fromJson(obj)));
    //   return [
    //     result,
    //     body['tenders']['last_page'],
    //     body['tenders']['current_page'],
    //   ];
    // } else {
    //   throw body;
    // }
  }

  Future<Map> acceptRequests(
      String json, String tenderId, String requestsId) async {
    print('tenders/$tenderId/accept/$requestsId');
    final response =
        await API().post(json, 'tenders/$tenderId/accept/$requestsId');
    if (response.statusCode != 401) {
      return {
        'success':
            'Исполнитель на этот конкурс назначен! Администратор сайта с вами свяжется и вы получите инструкции, необходимые для того, чтобы исполнитель приступил к работе.'
      };
    }
    throw response.body;
  }

  Future<Map> declineRequests(String json) async {
    final response = await API().post(json, 'tenders/cancelRequest');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response.body;
  }

  Future<Map> createTender(Map json) async {
    final response = await API().multipart(json, 'tenders/create');
    return jsonDecode(response);
  }

  Future<Map> updateTender({Map json, String id}) async {
    final response = await API().multipart(json, 'tenders/update/$id');
    print(response);
    return jsonDecode(response);
  }

  Future<Map> deleteTender(String json, String id) async {
    final response = await API().delete('tenders/delete/$id', data: json);
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw "Delete Tender".tr;
  }

  Future<List> getMyOpenedTenders({String page}) async {
    return await getTenders(page: page, url: "account/tenders");
  }

  Future<List> getGuestTenders(String id, {String page}) async {
    return await getTenders(page: page, url: "account/guest/tenders/$id");
  }

  Future<List> getInvitationTenders({String page}) async {
    return await getTenders(page: page, url: "account/invitation/get");
  }

  Future<Map> acceptInvitation(String json) async {
    final result = await API().post(json, "contractors/accept/invitation");
    print(result.body);
    if (result.statusCode == 200) {
      Map body = jsonDecode(result.body);
      return body;
    }
    return result.body;
  }
  Future<Map> declineInvitation(String json) async {
    final result = await API().post(json, "contractors/reject/invitation");
    print(result.body);
    if (result.statusCode == 200) {
      Map body = jsonDecode(result.body);
      return body;
    }
    return result.body;
  }

  Future<List> getArchivedTasks({String page}) async {
    return await getTenders(
        page: page, url: "account/myTenders/finishedTenders");
  }

  Future<List> getAvailableTenders({String page}) async {
    return await getTenders(page: page, url: "tenders/show/opened");
  }

  Future<List> getModificationTasks({String page}) async {
    return await getTenders(
        page: page, url: "account/myTenders/onModerationTenders");
  }

  Future<List> getAcceptedTenders({String page}) async {
    return await getTenders(
        page: page, url: "account/myRequest/requestsAccepted");
  }

  Future<List> getRequestedTenders({String page}) async {
    return await getTenders(page: page, url: "account/myRequest/requestsSend");
  }

  Future<Map> sendRequest(json) async {
    final result = await API().post(json, "tenders/makeRequest");
    Map body = jsonDecode(result.body);
    if (result.statusCode == 200) {
      return body;
    } else {
      throw body;
    }
  }

  Future<String> getAddress(String lng, String lat) async {
    var res = await http.get(
        'https://geocode-maps.yandex.ru/1.x/?apikey=d968824f-7680-4384-b158-736f430ee7c5&geocode=${lat},${lng}&lang=ru_RU&format=json');
    Map body = jsonDecode(res.body);
    print(body);
    return body['response']['GeoObjectCollection']['featureMember'][0]
        ['GeoObject']['metaDataProperty']['GeocoderMetaData']['text'];
  }

  Future<Tenders> getTender(String id) async {
    print("ID $id");
    final response = await API().getData("tenders/$id");

    var body = jsonDecode(response.body);
    print(body);
    if (response.statusCode == 200) {
      return new Tenders.fromJson(body);
    } else {
      throw new Exception(body['message']);
    }
  }

  Future<List<TenderRequests>> getTenderRequests(String json) async {
    final response = await API().post(json, 'tenders/showOffered');
    Map body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return body['requested']
          .map<TenderRequests>((e) => TenderRequests.fromJson(e))
          .toList();
    }
    print(body);
  }
}
