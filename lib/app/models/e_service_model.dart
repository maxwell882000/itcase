import 'package:itcase/app/models/pivot.dart';
import 'package:itcase/app/models/subcategory_model.dart';
import 'package:html/parser.dart';
import 'package:itcase/app/providers/mock_provider.dart';
import 'category_model.dart';
import 'e_provider_model.dart';
import 'parents/media_list_model.dart';

class EService {
  String id;
  String title;
  String description;
  List<Category> category = [];
  Pivot pivot;
  String images;
  EService(
      {this.title,
        this.description,
        this.pivot,
        this.category,
        this.images,
      });


  EService.fromJson(Map<String, dynamic> json) {
    try {

      pivot = new Pivot.fromJson(json['pivot']);
      title = json['name'];
      this.id = json['id'].toString();
      this.images =  MockApiClient.url + "uploads/users/" +  json['image'];
      description = Category.parseHtmlString(json['about_myself']);
      json['categories'].forEach((e) =>  category.add(new Category.fromJson(e)));
    } catch (e) {
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;


    return data;
  }

  @override
  bool get hasData {
    return id != null && title != null && description != null;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
              other is EService &&
              runtimeType == other.runtimeType &&
              title == other.title &&
              description == other.description;

  @override
  int get hashCode =>
      super.hashCode ^
      title.hashCode ^
      description.hashCode;

}
