import 'package:itcase/app/models/pivot.dart';

class SubCategory {
  String ru_title,
      en_title,
      uz_title,
      ru_slug,
      en_slug,
      uz_slug,
      image,
      position,
      color,
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

  int id;

  SubCategory(
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
        this.tender_meta_title_prefix});

  SubCategory.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.ru_title = json['ru_title'];
    this.en_title = json['en_title'];
    this.uz_title = json['uz_title'];
    this.title = this.ru_title;
    this.ru_slug = json['ru_slug'];
    this.en_slug = json['en_slug'];
    this.uz_slug = json['uz_slug'];
    this.image = json['image'];
    this.position = json['position'].toString();
    this.color = json['color'];
    this.lft = json['lft'].toString();
    this.rgt = json['rgt'].toString();
    this.parent_id = json['parent_id'].toString();
    this.created_at = json['created_at'].toString();
    this.updated_at = json['updated_at'].toString();
    this.favorite = json['favorite'].toString();
    this.meta_title = json['meta_title'];
    this.meta_description = json['meta_description'];
    this.meta_keywords = json['meta_keywords'];
    this.template = json['template'];
    this.ru_description = json['ru_description'];
    this.en_description = json['en_description'];
    this.uz_description = json['uz_description'];
    this.description = this.ru_description;
    this.tender_meta_title_prefix = json['tender_meta_title_prefix'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['ru_title'] = this.ru_title;
    data['en_title'] = this.en_title;
    data['uz_title'] = this.uz_title;
    data['ru_slug'] = this.ru_slug;
    data['en_slug'] = this.en_slug;
    data['uz_slug'] = this.uz_slug;
    data['image'] = this.image;
    data['position'] = this.position;
    data['color'] = this.color;
    data['lft'] = this.lft;
    data['rgt'] = this.rgt;
    data['parent_id'] = this.parent_id;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
    data['favorite'] = this.favorite;
    data['meta_title'] = this.meta_title;
    data['meta_description'] = this.meta_description;
    data['meta_keywords'] = this.meta_keywords;
    data['template'] = this.template;
    data['ru_description'] = this.ru_description;
    data['en_description'] = this.en_description;
    data['uz_description'] = this.uz_description;
    data['tender_meta_title_prefix'] = this.tender_meta_title_prefix;
    return data;
  }
}