import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:itcase/app/global_widgets/format.dart';
import 'package:itcase/app/models/category_model.dart';
import 'package:itcase/app/models/subcategory_model.dart';
import 'package:itcase/app/providers/api.dart';
import 'package:get/get.dart';

class Tenders {
  int id, owner_id, need_id, contractor_id;
  bool published;
  final opened = true.obs;
  String client_name,
      client_type,
      client_email,
      client_phone_number,
      client_company_name,
      client_site_url,
      title,
      description,
      budget,
      deadline,
      target_audience,
      links,
      additional_info,
      other_info,
      what_for,
      type,
      slug,
      created_at,
      updated_at,
      published_at,
      delete_reason,
      place,
      work_start_at,
      work_end_at;
  String geo_location;
  List files;
  bool email_subscription;
  int views;
  bool remote = false;
  String icon = "";
  List categories = [];
  bool status;
  final choose = false.obs;

  Tenders({
    this.client_name,
    this.client_type,
    this.client_email,
    this.client_phone_number,
    this.client_company_name,
    this.client_site_url,
    this.title,
    this.description,
    this.budget,
    this.deadline,
    this.target_audience,
    this.links,
    this.additional_info,
    this.other_info,
    this.what_for,
    this.type,
    this.slug,
    this.created_at,
    this.updated_at,
    this.status,
    this.published_at,
    this.id,
    this.owner_id,
    this.need_id,
    this.contractor_id,
    this.work_start_at,
    this.work_end_at,
    this.published,
    this.remote,
    this.files,
    this.categories,
  });

  Tenders.fromJsonShort(Map json) {
    this.id = json['id'];
    this.title = json['title'];
  }

  fromJson(Map json) {
    id = json['id'];
    client_type = json['private'];
    client_email = json['client_name'];
    client_phone_number = json['client_phone_number'];
    client_company_name = json['client_company_name'];
    client_site_url = json['client_site_url'];
    title = json['title'];
    description = Category.parseHtmlString(json['description'] ?? "");
    budget = json['budget'].toString();

    target_audience = json['target_audience'];
    links = json['links'];
    additional_info = json['additional_info'];
    other_info = json['other_info'];
    what_for = json['what_for'];
    type = json['type'];
    slug = json['slug'];
    need_id = json['need_id'];
    if (json['created_at'] != null)
      created_at = formatedStr(json['created_at']);
    if (json['updated_at'] != null)
      updated_at = formatedStr(json['updated_at']);
    owner_id = json['owner_id'];
    contractor_id = json['contractor_id'];
    status = json['status'] == "active" ? true : false;
    published = json['published'] == 1;
    published_at = json['published_at'];
    geo_location = json['geo_location'];
    email_subscription = json['email_subscription'] == 1;
    views = json['views'];
    delete_reason = json['delete_reason'];
    place = json['place'];

    if (json.containsKey('icon')) {
      icon = json['icon'];
    }
  }

  Tenders.fromJson(Map json) {
    this.fromJson(json);
    if (json.containsKey('categories')) {
      print(json['categories']);
      json['categories']
          .forEach((e) => categories.add(new SubCategory.fromJson(e)));
      // print(categories[0].id);
    }
    work_start_at =
        Format.parseDate(json['work_start_at'], Format.outputFormat);
    work_end_at = Format.parseDate(json['work_end_at'], Format.outputFormat);
    deadline = json['deadline'] != null
        ? Format.parseDate(json['deadline'], Format.outputFormatDeadline)
        : "";
    opened.value = json['opened'] == 1 &&
        Format.compareDates(
            Format.inputFormatWithoutHours.format(DateTime.now()), json['deadline']);
  }

  String formatedStr(String date) {
    return DateFormat('yyyy-MM-dd').format(DateTime.parse(date));
  }

  Map<String, dynamic> toJsonOnCreate() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['budget'] = int.parse(this.budget.replaceAll(' ', ''));
    data['deadline'] = this.deadline;
    data['links'] = this.links ?? "1";
    data['additional_info'] = this.additional_info;
    data['other_info'] = this.other_info;
    data['work_start_at'] = this.work_start_at;
    data['work_end_at'] = this.work_end_at;
    data['geo_location'] = this.geo_location;
    data['remote'] = this.remote ? 'on' : 'off';
    data['place'] = this.place;
    data['categories'] = this.categories.join(' ');
    data['files'] = this.files ?? [];
    return data;
  }

  Map<String, dynamic> toJsonModify() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['deadline'] = this.deadline;
    data['links'] = this.links ?? "1";
    data['additional_info'] = this.additional_info;
    data['other_info'] = this.other_info;
    data['work_start_at'] = this.work_start_at;
    data['work_end_at'] = this.work_end_at;
    data['geo_location'] = this.geo_location;
    data['remote'] = this.remote ? 'on' : 'off';
    data['place'] = this.place;
    data['files'] = this.files ?? [];
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['client_name'] = this.client_name;
    data['client_type'] = this.client_type;
    data['client_email'] = this.client_email;
    data['client_phone_number'] = this.client_phone_number;
    data['client_company_name'] = this.client_company_name;
    data['client_site_url'] = this.client_site_url;
    data['title'] = this.title;
    data['description'] = this.description;
    data['budget'] = this.budget;
    data['deadline'] = this.deadline;
    data['work_start_at'] = this.work_start_at;
    data['work_end_at'] = this.work_end_at;
    data['target_audience'] = this.target_audience;
    data['place'] = this.place;
    data['links'] = this.links;
    data['additional_info'] = this.additional_info;
    data['other_info'] = this.other_info;
    data['remote'] = this.remote ? 'on' : 'off';
    data['what_for'] = this.what_for;
    data['type'] = this.type;
    data['slug'] = this.slug;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
    data['status'] = this.status;
    data['files'] = this.files ?? [];
    data['published_at'] = this.published_at;
    data['id'] = this.id;
    data['owner_id'] = this.owner_id;
    data['need_id'] = this.need_id;
    data['geo_location'] = this.geo_location;
    data['contractor_id'] = this.contractor_id;
    data['opened'] = this.opened;
    data['published'] = this.published == true? 1:0;

    return data;
  }

  getTenders(page) async {
    var res = await API().getData("tenders?page=${page}");
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      var data = body['tenders']['data'];
      // print(data);
      return data;
    }
  }
}
