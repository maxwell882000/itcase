import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:itcase/app/models/notifications/notification.dart';
import 'package:itcase/app/providers/api.dart';

import '../models/notification_model.dart';
import '../providers/mock_provider.dart';

class NotificationRepository {
  MockApiClient _apiClient;

  NotificationRepository() {
    this._apiClient = MockApiClient(httpClient: Dio());
  }
  Future<List<NotificationBase>> getNotificationAll()async{
    final response = await API().getData('account/notification');
    print(response.body);
    if (response.statusCode == 200){
      Map body = jsonDecode(response.body);
      List<NotificationBase> result = body['notification'].map<NotificationBase>((e)=>NotificationBase.switchCorrect(e['type'], e)).toList();
      result.removeWhere((element) => element == null);
      return result;
    }
    throw "";
  }
  Future deleteNotification(String json) async{
    final response = await API().post(json, "account/notifications/delete");
    print(response.body);
    if (response.statusCode == 200){
      return;
    }
    throw "";
  }
  Future markAsReadNotification()async{
    final response = await API().getData('account/notifications/markAsRead');
    print(response.body);
    if (response.statusCode == 200){
        return;
    }
    throw "";
  }
  Future<List<Notification>> getAll() {
    return _apiClient.getNotifications();
  }

  Future<Map> getCountNotification() async{
    final response = await API().getData('account/notifications/update');

    if (response.statusCode == 200){
      Map body = jsonDecode(response.body);
      return body;
    }
    throw "";
  }

}
