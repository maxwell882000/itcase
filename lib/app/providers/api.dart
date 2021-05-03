import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:itcase/app/models/category_model.dart';
import 'package:itcase/app/services/auth_service.dart';
import 'package:itcase/common/loading.dart';

class API {
  static final String _base_url = "https://itcase.com/";
  final String _url = '${_base_url}api/';
  var token;
  final currentUser = Get.find<AuthService>().user;

  _getToken() async {
    token = currentUser.value.token;
  }

  getLink(String image) {
    return _base_url + "uploads/users/" + image;
  }

  post(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    await _getToken();

    return await Loading.response(()=>http
        .post(fullUrl, body: data, headers: _setHeaders()));
  }

  getImage(String url) async {
    final url_image = _base_url + Category.UPLOAD_DIRECTORY + url;
    final response = await Loading.response(()=>http.get(url_image));
    return response.bodyBytes;
  }

  multipart(Map data, apiUrl, {method: 'POST'}) async {
    var fullUrl = _url + apiUrl;

    await _getToken();
    var request = http.MultipartRequest(method, Uri.parse(fullUrl));
    if (data['im'] != null) {
      request.files.add(
        await http.MultipartFile.fromPath('image', data['im'],
            filename: "image", contentType: new MediaType('image', 'jpg')),
      );
    }

    if (data['resume'] != null) {
      request.files.add(
        await http.MultipartFile.fromPath('resume', data['resume'],
            filename: "resume",
            contentType: new MediaType('application', 'pdf')),
      );
    }
    if (data['files'] != null) {
     await data['files'].forEach((v)  => request.files.add(
         http.MultipartFile.fromBytes('files[]', v,
         filename: "files",),
     ));

    }

    data.remove('resume');
    data.remove('im');
    data.remove('files');
    if(!currentUser.value.id.isNull)
    data['owner_id'] = currentUser.value.id;

    data.forEach((key, value) => request.fields[key] = value?.toString());

    request.headers.addAll(_setHeaders());
    http.StreamedResponse response = await Loading.response(()=>request.send());

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      throw await response.stream.bytesToString();
    }
  }

  login(data) async {
    var fullUrl = _url + 'login';
    return await Loading.response(()=>http.post(fullUrl, body: data, headers: {
      "content-type": 'application/json'
    }).timeout(Duration(seconds: 5), onTimeout: () {
      return null;
    }));
  }

  put(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    await _getToken();
    return await Loading.response(()=>http
        .put(fullUrl, body: data, headers: _setHeaders())
        .timeout(Duration(seconds: 5), onTimeout: () {
      return null;
    }));
  }

  delete(apiUrl,{data}) async {
    var fullUrl = _url + apiUrl;
    await _getToken();
    return await Loading.response(()=>http
        .put(fullUrl,body: data, headers: _setHeaders())
        .timeout(Duration(seconds: 5), onTimeout: () {
      return null;
    }));
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    await _getToken();

    final res = await Loading.response(()=>http
        .get(fullUrl, headers: _setHeaders())
        .timeout(Duration(seconds: 5), onTimeout: () {
      return null;
    }));
    return res;
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
}
