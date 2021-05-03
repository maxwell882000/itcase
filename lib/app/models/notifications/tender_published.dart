import 'package:itcase/app/models/notifications/notification.dart';
import 'package:itcase/app/models/tenders.dart';
import 'package:get/get.dart';
class TenderPublished extends NotificationBase{
  Tenders tenders;

  TenderPublished.fromJson(Map json){
    tenders = Tenders.fromJson(json['data']['tender']);
    fromJson(json);
  }
  @override
  String body() {
    return tenders.title + ' ' + 'is passed moderation and published'.tr;
  }

  @override
  String title() {
    return "Published".tr;
  }
}