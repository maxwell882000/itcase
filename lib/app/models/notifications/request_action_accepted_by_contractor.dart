import 'package:itcase/app/models/notifications/notification.dart';
import 'package:get/get.dart';

class RequestActionAcceptedByContractor extends NotificationBase {
  String type;
  String tenderName;
  String contractorName;
  int tenderId;

  RequestActionAcceptedByContractor.fromJson(Map request) {
    Map json = request['data'];
    type = json['type'];
    tenderName = json['tenderName'];
    contractorName = json['contractorName'];
    fromJson(request);
  }

  @override
  String body() {
    return "Congratulations".tr +
        " " +
        contractorName +
        " " +
        "accepted your invitation for".tr +
        " " +
        tenderName;
  }

  @override
  String title() {
    return "Invitation accepted".tr;
  }
}
