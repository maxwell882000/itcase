import 'parents/media_model.dart';

class User extends MediaModel {
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
      meta_title,
      user_role,
      image,
      city;

  bool auth;
  String token;

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
  });

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
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
    about_myself = json['about_myself'];
    slug = json['slug'];
    telegram_id = json['telegram_id'];
    telegram_username = json['telegram_username'];
    google_id = json['google_id'];
    fake = json['fake'];
    meta_title = json['meta_title'];
    user_role = json['user_role'];
    image = json['image'];
    city = json['city'];
    super.fromJson(json);
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
    data['image'] = this.image;
    data['city'] = this.city;
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

  Map toRestrictMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["name"] = name;
    map["thumb"] = mediaThumb;
    return map;
  }
}

class Contractor {
  String name,
      phone_number,
      contractor_type,
      gender,
      email,
      about_myself,
      company_name,
      birthday,
      image;
  bool agree_personal_data = false;

  Contractor({
    this.name,
    this.phone_number,
    this.contractor_type = "individual",
    this.gender = "male",
    this.email,
    this.about_myself,
    this.company_name,
    this.image,
    this.birthday,
    this.agree_personal_data = false,
  });

  Map<String, dynamic> toJson() {
    // var list = {
    //   'user_role': 'contractor',
    //   'contractor_name': name,
    //   'contractor_phone_number': phone_number
    // }
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_role'] = 'contractor';
    data['contractor_name'] = name;
    data['contractor_phone_number'] = phone_number;
    data['contractor_email'] = email;
    if (gender != null) data['contractor_gender'] = gender;
    data['contractor_about_myself'] = about_myself;
    data['contractor_type'] = contractor_type;
    if (birthday != null) data['contractor_birtday_date'] = birthday;
    data['image'] = image;
    data['agree_personal_data_processing'] = agree_personal_data;
    return data;
  }
}

class Customer {
  String name,
      phone_number,
      customer_type = "legal_entity",
      email,
      about_myself,
      company_name,
      city,
      image;
  bool agree_personal_data = false;

  Customer({
    this.name,
    this.phone_number,
    this.customer_type,
    this.email,
    this.about_myself,
    this.company_name,
    this.image,
    this.agree_personal_data,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_role'] = 'customer';
    data['customer_name'] = this.name;
    data['customer_phone_number'] = this.phone_number;
    data['customer_email'] = this.email;
    data['customer_about_myself'] = this.about_myself;
    data['customer_type'] = this.customer_type;
    data['image'] = this.image;
    data['agree_personal_data_processing'] = this.agree_personal_data;
    return data;
  }
}
