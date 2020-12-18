class Customer {
  String name,
      user_role,
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
    this.user_role = "customer",
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
    data['user_role'] = user_role;
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
