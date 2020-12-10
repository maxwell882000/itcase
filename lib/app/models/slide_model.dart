import 'package:itcase/app/models/parents/model.dart';

class Slide extends Model {
  String id;
  String title;
  String description;
  String image;

  Slide({this.id, this.title, this.description, this.image});

  Slide.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    return data;
  }
}
