import 'package:itcase/app/models/user_model.dart';
import 'package:get/get.dart';
class TenderRequests {
  String id,
      budgetFrom,
      budgetTo,
      periodFrom,
      periodTo,
      comment;
  final isCanceled = false.obs;
  int invited;
  User user;

  TenderRequests.fromJson(Map json){
    print(json);
    id = json['id'].toString();
    budgetFrom = json['budget_from'];
    budgetTo = json['budget_to'];
    periodFrom = json['period_from'];
    periodTo = json['period_to'];
    invited = json['invited'];
    comment = json['comment'];
    json['user_info']['id'] = json['user_id'].toString();
    user = new User.fromJsonRequests(json['user_info']);

  }
  //
  // "id": 8,
  // "tender_id": 59,
  // "user_id": 5,
  // "budget_from": "21321321",
  // "budget_to": "21321321321",
  // "period_from": "2",
  // "period_to": "323",
  // "comment": "123213213",
  // "created_at": "2021-04-14T13:03:40.000000Z",
  // "updated_at": "2021-04-14T13:03:40.000000Z",
  // "invited": 0,
  // "user_info": {
  // "first_name": "Murodov Shokhod",
  // "email": "shaxa882@gmail.cs",
  // "image": "4x2pTExZiWozjbChiF6t.jpg"
  // }
}