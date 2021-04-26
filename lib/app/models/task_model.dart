import 'address_model.dart';
import 'e_service_model.dart';
import 'parents/model.dart';
import 'payment_method.dart';
import 'user_model.dart';

class Task extends Model {
  String id;
  DateTime dateTime;
  String title;
  String place;
  String description;
  DateTime deadline;
  int budget;
  bool remote;
  double latitude;
  double longtitude;
  String progress;
  double total;
  double tax;
  double rate;
  User user;
  EService eService;
  List files;
  Address address;
  List categories;
  String additional_info;
  String other_info;
  PaymentMethod paymentMethod;
  // 'title', 'description', 'budget', 'deadline',
  // 'target_audience', 'links', 'additional_info', 'other_info', 'what_for', 'type',
  // 'slug', 'opened', 'work_start_at', 'work_end_at',
  // 'need_id', 'owner_id', 'contractor_id', 'geo_location', 'place', 'delete_reason'


  // _token
  // "RtNGXdS9lcpDLWvCoLu1g4OQlE1lHn9G8HBpXhwT"
  // title
  // "asdasd"
  // place
  // "my_place"
  // categories
  // array:1 [▼
  //   0 => "17"
  // ]
  // description
  // "<p>asdasdasd</p>"
  // additional_info
  // "<p>sadasd</p>"
  // other_info
  // "<p>asdsadsad</p>"
  // work_start_at
  // "27.04.2021 23:15"
  // work_end_at
  // "16.04.2021 23:15"
  // budget
  // "20000000"
  // deadline
  // "21.04.2021"
  // geo_location
  // "41.23045338587126,69.08160457734371"
  // remote
  // "on"
  Task(
      {this.id,
      this.dateTime,
      this.title,
      this.description,
      // this.status,
      this.progress,
      this.total,
      this.tax,
      this.rate,
      this.user,
      this.eService,
      this.address,
      this.paymentMethod});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    dateTime = DateTime.parse(json['date_time']);
    title = json['title'];
    description = json['description'];
    // status = json['status'];
    progress = json['progress'];
    total = json['total']?.toDouble();
    rate = json['rate']?.toDouble();
    tax = json['tax']?.toDouble();
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    paymentMethod = json['payment_method'] != null
        ? PaymentMethod.fromJson(json['payment_method'])
        : null;
    eService =
        json['e_service'] != null ? EService.fromJson(json['e_service']) : null;
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title;
    data['place'] = this.place;

    data['description'] = this.description;
    // data['status'] = this.status;
    data['progress'] = this.progress;
    data['total'] = this.total;
    data['tax'] = this.tax;
    data['rate'] = this.rate;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    if (this.eService != null) {
      data['e_service'] = this.eService.toJson();
    }
    return data;
  }
}
