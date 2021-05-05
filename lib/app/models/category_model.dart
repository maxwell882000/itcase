import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:itcase/app/models/pivot.dart';
import 'package:itcase/app/models/subcategory_model.dart';
import 'package:itcase/app/providers/mock_provider.dart';
import 'package:get/get.dart';
import '../../common/ui.dart';

class Category {
  String ru_title,
      en_title,
      uz_title,
      ru_slug,
      en_slug,
      uz_slug,
      image,
      position,
      lft,
      rgt,
      parent_id,
      created_at,
      updated_at,
      favorite,
      meta_title,
      meta_description,
      meta_keywords,
      template,
      ru_description,
      en_description,
      uz_description,
      tender_meta_title_prefix;
  String title, description;
  List<SubCategory> categories;
  Color color;
  Color backGround;
  int id;
  Pivot pivot;
  final choose = false.obs;
  static final UPLOAD_DIRECTORY = 'uploads/handbook_categories_images/';
  Category(
      {this.id,
        this.ru_title,
        this.en_title,
        this.uz_title,
        this.ru_slug,
        this.en_slug,
        this.uz_slug,
        this.image,
        this.position,
        this.color,
        this.lft,
        this.rgt,
        this.parent_id,
        this.created_at,
        this.updated_at,
        this.favorite,
        this.meta_title,
        this.meta_description,
        this.meta_keywords,
        this.template,
        this.ru_description,
        this.en_description,
        this.uz_description,
        this.tender_meta_title_prefix,
        this.categories});
  Category.fromJsonToUser(Map<String, dynamic> json){
    ru_title = json['ru_title'];
    en_title = json['en_title'];
    uz_title = json['uz_title'];
    title = ru_title;
  }
  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    ru_title = json['ru_title'];
    en_title = json['en_title'];
    uz_title = json['uz_title'];
    title = ru_title;
    ru_slug = json['ru_slug'];
    en_slug = json['en_slug'];
    uz_slug = json['uz_slug'];
    if(json['image']!=null) {
      image = MockApiClient.url + UPLOAD_DIRECTORY + json['image'];
    }
    else{
      image = "http://handyman.smartersvision.com/mock/categories/media/nurse.svg";
    }


    position = json['position'].toString();
    color = Colors.white;
    backGround = Get.theme.accentColor;
    lft = json['lft'].toString();
    rgt = json['rgt'].toString();
    parent_id = json['parent_id'].toString();
    created_at = json['created_at'].toString();
    updated_at = json['updated_at'].toString();
    favorite = json['favorite'].toString();
    meta_title = json['meta_title'];
    meta_description = json['meta_description'];
    meta_keywords = json['meta_keywords'];
    template = json['template'];
    ru_description = parseHtmlString(json['ru_description']?? "");
    en_description = parseHtmlString(json['en_description']?? "");
    uz_description =parseHtmlString(json['uz_description']?? "");
    description = ru_description;
    tender_meta_title_prefix = json['tender_meta_title_prefix'];
    categories = [];
    if (json.containsKey("pivot")) {
      pivot = new Pivot.fromJson(json);
    }
    if (json.containsKey("categories")) {
      json['categories'].forEach((v) {
        categories.add(SubCategory.fromJson(v));
      });
    }
  }

  static String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id.toString();
    data['ru_title'] = this.ru_title;
    data['en_title'] = this.en_title;
    data['uz_title'] = this.uz_title;
    data['ru_slug'] = this.ru_slug;
    data['en_slug'] = this.en_slug;
    data['uz_slug'] = this.uz_slug;
    data['image'] = this.image;
    data['position'] = this.position.toString();
    data['color'] = this.color;
    data['lft'] = this.lft.toString();
    data['rgt'] = this.rgt.toString();
    data['parent_id'] = this.parent_id.toString();
    data['created_at'] = this.created_at.toString();
    data['updated_at'] = this.updated_at.toString();
    data['favorite'] = this.favorite.toString();
    data['meta_title'] = this.meta_title;
    data['meta_description'] = this.meta_description;
    data['meta_keywords'] = this.meta_keywords;
    data['template'] = this.template;
    data['ru_description'] = this.ru_description;
    data['en_description'] = this.en_description;
    data['uz_description'] = this.uz_description;
    data['tender_meta_title_prefix'] = this.tender_meta_title_prefix;
    data['categories'] = this.categories.map((v) => v.toJson()).toList();
    return data;
  }
}