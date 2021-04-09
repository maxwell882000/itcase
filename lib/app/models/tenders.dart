import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:itcase/app/providers/api.dart';

class Tenders {
  int id, owner_id, need_id, contractor_id;
  int  published;
  int opened;
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
      status,
      published_at,
      delete_reason,
      place,
      work_start_at,
      work_end_at;
  String geo_location;
  bool email_subscription;
  int views;

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
    this.opened,
    this.published,
  });

  Tenders.fromJson(var json) {
    id = json['id'];
    client_type = json['private'];
    client_email = json['client_name'];
    client_phone_number =json['client_phone_number'];
    client_company_name = json['client_company_name'];
    client_site_url = json['client_site_url'];
    title = json['title'];
    description = json['description'];
    budget = json['budget'].toString();
    deadline = json['deadline'];
    target_audience = json['target_audience'];
    links = json['links'];
    additional_info = json['additional_info'];
    other_info = json['other_info'];
    what_for = json['what_for'];
    type = json['type'];
    slug = json['slug'];
    opened = json['opened'];
    need_id = json['need_id'];
    created_at = formatedStr(json['created_at']);
    updated_at = formatedStr(json['updated_at']);
    owner_id = json['owned_id'];
    contractor_id = json['contractor_id'];
    status = json['status'];
    published = json['published'];
    published_at = json['published_at'];
    geo_location = json['geo_location'];
    email_subscription = json['email_subscription'];
    views = json['views'];
    delete_reason = json['delete_reason'];
    place = json['place'];
    work_start_at= json['work_start_at'];
    work_end_at= json['work_end_at'];
  }
  String formatedStr(String date){
    return DateFormat('yyyy-MM-dd').format(DateTime.parse(date));
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
    data['target_audience'] = this.target_audience;
    data['links'] = this.links;
    data['additional_info'] = this.additional_info;
    data['other_info'] = this.other_info;
    data['what_for'] = this.what_for;
    data['type'] = this.type;
    data['slug'] = this.slug;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
    data['status'] = this.status;
    data['published_at'] = this.published_at;
    data['id'] = this.id;
    data['owner_id'] = this.owner_id;
    data['need_id'] = this.need_id;
    data['contractor_id'] = this.contractor_id;
    data['opened'] = this.opened;
    data['published'] = this.published;

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
