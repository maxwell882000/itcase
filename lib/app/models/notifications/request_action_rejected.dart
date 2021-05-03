import 'package:itcase/app/models/notifications/notification.dart';
import 'package:get/get.dart';

class RequestActionRejected extends NotificationBase {
  String type;
  String tenderName;
  String customerName;
  int tenderId;

  RequestActionRejected.fromJson(Map request){
    Map json = request['data'];
    type = json['type'];
    tenderName = json['tenderName'];
    customerName = json['customerName'];
    fromJson(request);
  }
  @override
  String body() {
    return "Sorry".tr +
        " " +
        customerName +
        " " +
        "rejected your request for".tr +
        " " +
        tenderName;
  }

  @override
  String title() {
    return "Request rejected".tr;
  }
}
