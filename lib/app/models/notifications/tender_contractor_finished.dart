import 'package:itcase/app/models/notifications/notification.dart';
import 'package:itcase/app/models/tenders.dart';
import 'package:get/get.dart';
class TenderContractorFinished extends NotificationBase {
  Tenders tenders;

  TenderContractorFinished.fromJson(Map json){
    tenders = new Tenders.fromJson(json['data']['tender']);
    fromJson(json);
  }
  @override
  String body() {
    return tenders.title + " " + 'is finished. Please check this task , and if it is okey, you can mark it as performed'.tr;
  }

  @override
  String title() {
    return "Tender is finished".tr;
  }

}