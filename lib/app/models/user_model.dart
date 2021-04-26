import 'dart:io';

import 'package:itcase/app/global_widgets/format.dart';
import 'package:itcase/app/models/category_model.dart';
import 'package:itcase/app/models/comments.dart';
import 'package:itcase/app/models/parents/model.dart';
import 'package:itcase/app/models/pivot.dart';
import 'package:itcase/app/providers/api.dart';

import 'package:get/get.dart';
class TypeUser{
  static final String constractor = "contractor";
  static final String customer = "customer";
}
class User extends Model {
  List<Category> category = [];
  Pivot pivot;
  String name,
      email,
      password,
      company_name,
      site,
      foundation_year,
      customer_type,
      contractor_type,
      gender,
      birthday_date,
      specialization,
      skills,
      facebook,
      vk,
      telegram,
      whatsapp,
      instagram,
      phone_number,
      about_myself,
      slug,
      telegram_id,
      telegram_username,
      google_id,
      fake,
      language,
      meta_title,
      user_role,
      account_paid,
      city;
  File image;
  String image_gotten;
  bool auth;
  List<Comments> comments = [];
  String token;
  double rate;
  bool phoneConfirmed;
  bool emailConfirmed;
  bool passportConfirmed;
  String lastSeen;

  final isCustomer = false.obs;
  final isContractor = false.obs;

  User({
    this.name,
    this.email,
    this.password,
      this.company_name,
    this.site,
    this.foundation_year,
    this.customer_type,
    this.contractor_type,
    this.gender,
    this.birthday_date,
    this.specialization,
    this.skills,
    this.facebook,
    this.vk,
    this.telegram,
    this.whatsapp,
    this.instagram,
    this.phone_number,
    this.about_myself,
    this.slug,
    this.telegram_id,
    this.telegram_username,
    this.google_id,
    this.fake,
    this.meta_title,
    this.user_role,
    this.image,
    this.city,
    this.account_paid,
    this.language,
  });



  // User.
  User.fromJsonRequests(Map<String , dynamic> json){
    name = json['first_name'] + " " +  json['last_name'];
    lastSeen = Format.parseDate(json['last_online_at'], Format.outputFormatLastSeen);
    image_gotten = API().getLink(json['image']);
    Map<String, dynamic> id = {
      'id': json['id'].toString()
    };
    super.fromJson(id);
  }

  @override
  fromJson(Map<String, dynamic> json){
    if (json.containsKey('pivot')){
      pivot = new Pivot.fromJson(json['pivot']);
    }
    if (json.containsKey('categories')){
      json['categories'].forEach((e) =>  category.add(new Category.fromJsonToUser(e)));
    }
    if (json.containsKey('comments')){
      json['comments'].forEach((e) =>  comments.add(new Comments.fromJson(e)));
    }
    if (json.containsKey('language')) {
      language = json['language'];
    }
    if  (json.containsKey('mean')){
      rate  = json['mean'].toDouble();
    }
    else {
      language = 'ru';
    }
    emailConfirmed = json['email_verified_at']?.isNotEmpty ?? false;
    phoneConfirmed = json['phone_confirmed_at']?.isNotEmpty ?? false;
    name = json['first_name'] + " " +  json['last_name'];
    email = json['email'];
    password = json['password'];
    company_name = json['company_name'];
    site = json['site'];
    foundation_year = json['foundation_year'];
    customer_type = json['customer_type'];
    contractor_type = json['contractor_type'];

    gender = json['gender'];
    birthday_date = json['birthday_date'];
    specialization = json['specialization'];
    skills = json['skills'];
    facebook = json['facebook'];
    vk = json['vk'];
    telegram = json['telegram'];
    whatsapp = json['whatsapp'];
    instagram = json['instagram'];
    phone_number = json['phone_number'];
    about_myself = Category.parseHtmlString(json['about_myself']);
    slug = json['slug'];
    telegram_id = json['telegram_id'];
    telegram_username = json['telegram_username'];
    google_id = json['google_id'];
    fake = json['fake'].toString();
    meta_title = json['meta_title'];
    user_role = json['role'];
    isContractor.value =  user_role == TypeUser.constractor;
    image_gotten = API().getLink(json['image']);
    city = json['city'];
    account_paid = json['account_paid_at'];
    passportConfirmed = true;
    Map<String, dynamic> id = {
      'id': json['id'].toString()
    };
    super.fromJson(id);
  }
  void setRole(String role){
    user_role = role;
  }

  User.fromJson(Map<String, dynamic> json) {
    this.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['company_name'] = this.company_name;
    data['site'] = this.site;
    data['foundation_year'] = this.foundation_year;
    data['customer_type'] = this.customer_type;
    data['contractor_type'] = this.contractor_type;
    data['gender'] = this.gender;
    data['birthday_date'] = this.birthday_date;
    data['specialization'] = this.specialization;
    data['skills'] = this.skills;
    data['facebook'] = this.facebook;
    data['vk'] = this.vk;
    data['telegram'] = this.telegram;
    data['whatsapp'] = this.whatsapp;
    data['instagram'] = this.instagram;
    data['phone_number'] = this.phone_number;
    data['about_myself'] = this.about_myself;
    data['slug'] = this.slug;
    data['telegram_id'] = this.telegram_id;
    data['telegram_username'] = this.telegram_username;
    data['google_id'] = this.google_id;
    data['fake'] = this.fake;
    data['meta_title'] = this.meta_title;
    data['user_role'] = this.user_role;
    data['image'] = this.image_gotten;
    data['city'] = this.city;
    data['language'] = this.language;
    return data;
  }

  Map<String, dynamic> toJsonSingup() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['name'] = this.name;
    data['device_name'] = this.phone_number;
    return data;
  }

  Map<String, dynamic> toJsonlogin() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['device_name'] = this.phone_number;
    return data;
  }

}

class TempUser{
  String name,
      phone_number,
      type,
      gender,
      email,
      about_myself,
      company_name,
      language,
      birthday;

  bool agree_personal_data = false;

  String city;

  File image;

  String user_role;

  String resume;

  String newPassword;
  String currentPassword;
  static final  List roles = [
    'contractor',
    'customer',
  ];

  String instagram;
  String facebook;
  String telegram;
  String whatsapp;
  String vk;
  String twitter;

  TempUser({
    this.name,
    this.phone_number,
    this.type = "individual",
    this.gender = "male",
    this.email,
    this.about_myself,
    this.company_name,
    this.image,
    this.birthday,
    this.agree_personal_data = false,
    this.city,
    this.resume,
    this.language,
    this.newPassword,
    this.currentPassword,
    this.user_role="contractor",
  });

  Map<String, dynamic> toJson({modify = false}) {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_role'] =this.user_role;

    String additional = modify ? "":this.user_role + "_";

    List names = name.split(" ");
    data['${additional}first_name'] = names[0];
    data['${additional}last_name'] = names[1];
    data['${additional}phone_number'] = phone_number;
    data['${additional}email'] = email;
    data['${additional}city'] = city;
    data['${additional}company_name'] = company_name ?? 0;
    data['language'] = language ?? 0;
    if (gender != null) data['${user_role}_gender'] = gender;

    data['${additional}about_myself'] = about_myself;
    data['${additional}type'] = type;

    if (birthday != null) data['${user_role}_birthday_date'] = birthday;
    data['im'] = image?.path;
    data['agree_personal_data_processing'] = agree_personal_data;

    return data;
  }
  Map<String, dynamic> toModify(){
    final Map<String, dynamic> data = this.toJson(modify: true);
    data['resume'] = resume;
    data['newPassword'] = newPassword;
    data['newPasswordRepeat'] = newPassword;
    data['currentPassword'] = currentPassword;
    data['telegram'] = telegram;
    data['whatsapp'] = whatsapp;
    data['facebook'] = facebook;
    data['instagram'] = instagram;
    data['vk'] = vk;
    data['twitter'] = twitter;
    return data;
  }
}

// class Contractor {
//   String name,
//       phone_number,
//       contractor_type,
//       gender,
//       email,
//       about_myself,
//       company_name,
//       birthday;
//   bool agree_personal_data = false;
//   String city;
//   File image;
//
//   Contractor({
//     this.name,
//     this.phone_number,
//     this.contractor_type = "individual",
//     this.gender = "male",
//     this.email,
//     this.about_myself,
//     this.company_name,
//     this.image,
//     this.birthday,
//     this.agree_personal_data = false,
//     this.city,
//   });
//
//   Map<String, dynamic> toJson() {
//     // var list = {
//     //   'user_role': 'contractor',
//     //   'contractor_name': name,
//     //   'contractor_phone_number': phone_number
//     // }
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['user_role'] = 'contractor';
//     List names = name.split(" ");
//     data['contractor_first_name'] = names[0];
//     data['contractor_last_name'] = names[1];
//     data['contractor_phone_number'] = phone_number;
//     data['contractor_email'] = email;
//     data['contractor_city'] = city;
//     if (gender != null) data['contractor_gender'] = gender;
//     data['contractor_about_myself'] = about_myself;
//     data['contractor_type'] = contractor_type;
//     if (birthday != null) data['contractor_birthday_date'] = birthday;
//     data['im'] = image.path;
//     data['agree_personal_data_processing'] = agree_personal_data;
//     return data;
//   }
// }
//
// class Customer {
//   String name,
//       phone_number,
//       customer_type = "legal_entity",
//       email,
//       about_myself,
//       company_name,
//       city;
//   File image;
//
//   bool agree_personal_data = false;
//
//   Customer({
//     this.name,
//     this.phone_number,
//     this.customer_type,
//     this.email,
//     this.about_myself,
//     this.company_name,
//     this.image,
//     this.agree_personal_data,
//     this.city,
//   });
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['user_role'] = 'customer';
//     List names = name.split(" ");
//     data['customer_first_name'] = names[0];
//     data['customer_last_name'] = names[1];
//     data['customer_phone_number'] = this.phone_number;
//     data['customer_email'] = this.email;
//     data['customer_about_myself'] = this.about_myself;
//     data['customer_type'] = this.customer_type;
//     data['im'] = this.image.path;
//     data['agree_personal_data_processing'] = this.agree_personal_data;
//     data['customer_city'] = this.city;
//     return data;
//   }
// }
