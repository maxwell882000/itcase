import 'dart:convert';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:itcase/app/global_widgets/format.dart';

import 'package:itcase/app/models/user_model.dart';
import 'package:itcase/app/modules/auth/controllers/verify_controller.dart';
import 'package:itcase/app/modules/auth/views/phone_verification_view.dart';
import 'package:itcase/app/modules/auth/views/register/fill_account.dart';
import 'package:itcase/app/modules/auth/views/register/after_registartion.dart';
import 'package:itcase/app/providers/api.dart';
import 'package:itcase/app/repositories/user_repository.dart';
import 'package:itcase/app/routes/app_pages.dart';
import 'package:itcase/app/services/auth_service.dart';
import 'package:itcase/common/ui.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthFillController extends GetxController {
  String confirm;
  GetStorage _box;
  final currentUser = Get.find<AuthService>().user;
  final formKey = GlobalKey<FormState>().obs;
  final tempKey = GlobalKey<FormState>().obs;
  final Map<String, dynamic> data = Map<String, dynamic>();

  final UserRepository _userRepository = new UserRepository();
  final user = new User().obs;

  var tempUser = new TempUser().obs;

  final hidePassword = true.obs;
  final agree = false.obs;
  final initialAvatar = false.obs;
  final avatar = "".obs;
  final gender = "male".obs;
  final type = "individual".obs;
  final role = "contractor".obs;
  final accountRegistered = false.obs;
  final birthday = DateFormat('dd.MM.yyyy').format(DateTime.now()).obs;
  final loading = false.obs;

  void start() {
    if (user.value.gender != null) {
      gender.value = user.value.gender;
    }
    if (user.value.phoneConfirmed == true) {
      accountRegistered.value = true;
    }
    if (user.value.image_gotten?.isNotEmpty ?? false) {
      initialAvatar.value = true;
    }
    if (user.value.user_role != null) {
      role.value = user.value.user_role;
      if (role.value == TypeUser.constractor && user.value.contractor_type != null) {
          type.value = user.value.contractor_type;
      }
      else if (role.value == TypeUser.customer || user.value.contractor_type == null) {
        type.value = user.value.customer_type;
      }
    }

    if (user.value.birthday_date != null) {
      birthday.value = Format.parseDate(user.value.birthday_date, Format.outputFormatDeadline);
      tempUser.value.birthday = birthday.value;
    }
  }

  @override
  void onInit() {
    user(Get.find<AuthService>().user.value);

    if (Get.arguments != null) {

      User _userArgument = Get.arguments as User;
      user.update(
          (current) => current.fromJson(_userArgument.toJson())
      );
    }
    print(user.value.toJson());
    print(user.value.token);
    start();
    super.onInit();
  }
  updateRole (String role){
    this.role.value = role;
    update();
  }
 Future<bool> fill_data_account(role, {String url = 'account/create'}) async {
   print(tempUser.value.city);
   print(tempUser.value.user_role);

    if (formKey.value.currentState.validate()) {
      loading.value = true;
      print("here");
      formKey.value.currentState.save();


      var data;

      if (tempUser.value.image == null) {
        loading.value = false;
      await Get.showSnackbar(Ui.ErrorSnackBar(
            title: "Error", message: "Please choose avatar picture.".tr));
        return false;
      }
      if (tempUser.value.type == 'individual') {

        if (tempUser.value.birthday == null) {
          loading.value = false;
          Get.showSnackbar(Ui.ErrorSnackBar(
              title: "Error", message: "Please select your birthday.".tr));
          return false;
        }

      }
      data = tempUser.value.toJson();
      if (!tempUser.value.agree_personal_data) {
        loading.value = false;
         Get.showSnackbar(Ui.ErrorSnackBar(
            title: "Error",
            message: "Please agree with your personal data".tr));
         return false;
      }
      print("DATA OF INPUT");
      print(data);
      print(currentUser.value.token);
      print(user.value.token);
      try {
        var response = await API().multipart(data, url);
        var body = jsonDecode(response);
        if (body['message'] != null) {
          print(body);
          _box = new GetStorage();
          _box.write('user_role', role);
          url == 'account/create'
              ? Get.toNamed(Routes.PHONE_VERIFICATION)
              : Get.toNamed(Routes.ROOT);
          loading.value = false;
        }
      } catch (e) {
        loading.value = false;
        return Get.showSnackbar(
            Ui.ErrorSnackBar(title: "Error", message: e.toString()));
      }
    }
    return false;

  }

  modify_account(GlobalKey<FormState> password) async {
    loading.value = true;
    if (formKey.value.currentState.validate() &&
        password.currentState.validate()) {
      password.currentState.save();
      formKey.value.currentState.save();
      print("changed");

      tempUser.value.user_role = user.value.user_role;

      tempUser.value.language = user.value.language;
      print(tempUser.value.toModify());
      try {
        Map message = await _userRepository.modifyAccount(
            tempUser.value.toModify(),
            url: tempUser.value.user_role == TypeUser.customer
                ? 'account/customer/profile/save'
                : 'account/contractor/profile/save');
        Map account =
            await _userRepository.getAccount(id: currentUser.value.id);
        user.value.fromJson(account['user']);
      await  Get.showSnackbar(Ui.SuccessSnackBar(message: message['message']));
        loading.value = false;
      } catch (e) {
        print(e);
        loading.value = false;
        Map body = jsonDecode(e.toString());
        body['error'].forEach((key, value) =>
            Get.showSnackbar(Ui.ErrorSnackBar(message: value[0])));
      }
    } else {
      loading.value = false;
      Get.showSnackbar(Ui.ErrorSnackBar(
          message: "There are errors in some fields please correct them!".tr));
    }
    loading.value = false;
  }

  modify_passwords() {}
}
