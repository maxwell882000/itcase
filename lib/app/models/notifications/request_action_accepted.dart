import 'package:itcase/app/models/notifications/notification.dart';
import 'package:get/get.dart';

class RequestActionAccepted extends NotificationBase {
  String type;
  String tenderName;
  String customerName;
  int tenderId;

  RequestActionAccepted.fromJson(Map request) {
    Map json = request['data'];
    type = json['type'];
    tenderName = json['tenderName'];
    customerName = json['customerName'];
    fromJson(request);
  }

  @override
  String body() {
    return "Congratulations".tr +
        " " +
        customerName +
        " " +
        "accepted your request for".tr +
        " " +
        tenderName;
  }

  @override
  String title() {
    return "Request accepted".tr;
  }
}
