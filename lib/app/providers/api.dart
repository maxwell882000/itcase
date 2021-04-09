import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:itcase/app/services/auth_service.dart';

class API {
  final String _url = 'https://itcasetest.vid.uz/api/';
  var token;
  final currentUser = Get.find<AuthService>().user;
  _getToken() async {

    token = currentUser.value.token;
    print(token);
  }

  post(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    await _getToken();
    return await http
        .post(fullUrl, body: data, headers: _setHeaders())
        .timeout(Duration(seconds: 5), onTimeout: () {
      return null;
    });
  }

  login(data) async {
    var fullUrl = _url + 'login';
    return await http.post(fullUrl, body: data, headers: {
      // "Accept": 'application/json'
    }).timeout(Duration(seconds: 5), onTimeout: () {
      return null;
    });
  }

  put(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    await _getToken();
    return await http
        .put(fullUrl, body: data, headers: _setHeaders())
        .timeout(Duration(seconds: 5), onTimeout: () {
      return null;
    });
  }

  delete(apiUrl) async {
    var fullUrl = _url + apiUrl;
    await _getToken();
    return await http
        .delete(fullUrl, headers: _setHeaders())
        .timeout(Duration(seconds: 5), onTimeout: () {
      return null;
    });
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    await _getToken();
    final res = await http
        .get(fullUrl, headers: _setHeaders())
        .timeout(Duration(seconds: 5), onTimeout: () {
      return null;
    });
    return res;
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
}
