import 'package:itcase/app/models/category_model.dart';
import 'package:intl/intl.dart';
import 'package:itcase/app/providers/api.dart';
class Comments{
  String id;
  String assessment;
  String who_set;
  String for_set;
  String comment;
  String date;
  String images;
  final outputFormat = DateFormat('dd-MM-yyyy');
  Comments({this.id,this.assessment, this.who_set,this.for_set,this.comment, this.images});


  Comments.fromJson(Map json)  {
    id = json['id'].toString();
    assessment =   json['assessment'];
    who_set = json['who_set'];
    for_set = json['for_set'];
    comment = Category.parseHtmlString(json['comment']);
    date = formatDate(json['updated_at']);
    if(json.containsKey('images')) {
      images = API().getLink(json['images']);
    }
    else if (json.containsKey('image')){
      images = API().getLink(json['image']);
    }
  }
 Map<String,dynamic> toJson(){
    return {
      'for_comment_id': for_set,
      'rating': assessment,
      'comment':comment
    };
  }
  formatDate(String date){
    DateTime dateFormatted = DateTime.parse(date);
    return outputFormat.format(dateFormatted);
  }

}