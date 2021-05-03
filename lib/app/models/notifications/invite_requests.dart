import 'package:itcase/app/models/notifications/notification.dart';
import 'package:get/get.dart';
class InviteRequests extends NotificationBase{

  String tenderName;
  String contractorName;
  String customerName;
  int tenderId;

  InviteRequests.fromJson(Map json){
    tenderName = json['data']['tenderName'];
    contractorName = json['data']['contractorName'];
    customerName = json['data']['customerName'];
    tenderId = json['data']['tenderId'];
    fromJson(json);
  }

  @override
  String title() {
    return "Invitation".tr + " " + tenderName;
  }

  @override
  String body() {
    return customerName  + " " + "invites you for taking part in the task. Will you accept?".tr;
  }


}