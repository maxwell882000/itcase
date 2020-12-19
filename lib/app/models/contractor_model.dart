class Contractor {
  String name,
      phone_number,
      user_role,
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
    this.user_role = "contractor",
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_role'] = user_role;
    data['contractor_name'] = name;
    data['contractor_phone_number'] = phone_number;
    data['contractor_email'] = email;
    if (gender != null) data['contractor_gender'] = gender;
    data['contractor_about_myself'] = about_myself;
    data['contractor_type'] = contractor_type;
    if (birthday != null) data['contractor_birthday_date'] = birthday;
    data['image'] = image;
    data['agree_personal_data_processing'] = agree_personal_data;
    return data;
  }
}
