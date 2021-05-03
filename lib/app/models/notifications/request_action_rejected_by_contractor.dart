import 'package:itcase/app/models/notifications/notification.dart';
import 'package:get/get.dart';

class RequestActionRejectedByContractor extends NotificationBase {
  String type;
  String tenderName;
  String contractorName;
  int tenderId;

  RequestActionRejectedByContractor.fromJson(Map request) {
    Map json = request['data'];
    type = json['type'];
    tenderName = json['tenderName'];
    contractorName = json['contractorName'];
    fromJson(request);
  }

  @override
  String body() {
    return "Sorry".tr +
        " " +
        contractorName +
        " " +
        "rejected your request for".tr +
        " " +
        tenderName;
  }

  @override
  String title() {
    return "Invitation rejected".tr;
  }
}
