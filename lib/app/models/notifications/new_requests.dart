import 'package:itcase/app/models/notifications/notification.dart';
import 'package:get/get.dart';
class NewRequests extends NotificationBase{

  String tenderName;
  String contractorName;
  var tenderId;



  NewRequests.fromJson(Map request){
    Map json = request['data'];
    tenderName = json['tenderName'] ?? "";
    contractorName = json['contractorName'] ?? "";
    tenderId = json['tenderId'] ?? "";
    fromJson(request);
  }
  @override
  String body() {
    return "New request for participating in".tr + " " + tenderName + " " + "from".tr + " " + contractorName;
  }

  @override
  String title() {
      return "New request".tr;
  }
}