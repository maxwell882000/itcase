import 'dart:convert';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:itcase/app/providers/api.dart';
import 'package:itcase/app/services/auth_service.dart';
import 'package:itcase/common/loading.dart';

import '../models/address_model.dart';
import '../models/user_model.dart';
import '../providers/mock_provider.dart';

class UserRepository {
  MockApiClient _apiClient;

  UserRepository() {
    this._apiClient = MockApiClient(httpClient: Dio());
  }

  Future<List<User>> getAll() {
    return _apiClient.getAllUsers();
  }

  Future<User> login() {
    return _apiClient.getLogin();
  }

  Future<List<Address>> getAddresses() {
    return _apiClient.getAddresses();
  }

  Future<Map> getAccount({String id}) async {
    if (id == null || id.isEmpty) {
      id = '0';
    }
    var res = await API().getData('account/seeAccount/$id');
    if (res.statusCode == 200) {
      Map body = jsonDecode(res.body);
      body['user']['role'] = body['role'];

      return body;
    } else if (res.statusCode == 401) {
      throw 401;
    } else {
      print(res.statusCode);
      print(res.body);
      throw ("Error Occurred".tr);
    }
  }

  Future<String> registerAccount(String json) async {
          // print(json);
    var response = await API().post(json, "register");
    print(response);
    var body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return body['token'];
    }
    throw body['error'];
  }

  Future<bool> resendPhoneCode() async {
    final response = await API().post("","phone/resend");
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    }
    print(response.body);
    return false;
  }

  Future<Map> modifyAccount(Map<String, dynamic> json, {String url}) async {
    final response = await API().multipart(json, url, method: "POST");
    Map body = jsonDecode(response);
    return body;
  }

  Future<Map> changePassword(String json) async {
    final response = await Loading.response(()=>API().post(json, 'account/password/change/save'));
    print(response.body);
    if (response.statusCode == 200){
      Map body = jsonDecode(response.body);
      return body;
    }
    throw response.body;
  }

  Future<Map> saveProfessional(String json) async{
    final result = await Loading.response(()=>API().post(json, 'account/professional'));
    print(result.body);
    if (result.statusCode ==200){
      Map body = jsonDecode(result.body);
      return body;
    }
    throw result.body;
  }
}
