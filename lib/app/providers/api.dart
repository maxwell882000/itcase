import 'package:http/http.dart' as http;

class API {
  final String _url = 'http://192.168.1.111:8000/api/';
  var token;

  _getToken() async {
    // token = ls.getString('token');
  }

  checkAuth() async {
    _getToken();
    if (token != null) {
      return true;
    } else
      return false;
  }

  getUser() async {
    var user;
    if (checkAuth()) {
      // user = ls.getString('user');
      return user;
    } else
      return null;
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
      "Accept": 'application/json'
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

  _setHeaders() =>
      {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
}
