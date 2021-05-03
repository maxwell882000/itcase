import 'dart:convert';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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

class RegisterController extends GetxController {
  String confirm;
  GetStorage _box;
  final currentUser = Get
      .find<AuthService>()
      .user;
  final formKey = GlobalKey<FormState>().obs;
  final tempKey = GlobalKey<FormState>().obs;
  final hidePassword = true.obs;
  final Map<String, dynamic> data = Map<String, dynamic>();

  final UserRepository _userRepository = new UserRepository();
  var user = new User().obs;


  final loading = false.obs;

  @override
  void onInit() {

    super.onInit();
  }

  register_account(GlobalKey<FormState> signupForm) async {
    loading.value = true;
    if (signupForm.currentState.validate()) {
      signupForm.currentState.save();
      try{
        print(user.value.toJsonSingup());
      var token = await _userRepository.registerAccount(jsonEncode(user.value.toJsonSingup()));
        user.value.auth = true;
        user.value.token = token;
        print(user.value.toJson());
        currentUser.update((current) {
          current.token = user.value.token;
          current.auth = true;
          current.name = user.value.name;
          current.phone_number = user.value.phone_number;
          current.password = user.value.password;
          current.email = user.value.email;
        });
        print(currentUser.value.toJson());
        Get.toNamed(Routes.BECOME_CONSUMER, arguments: user.value);
      } catch(e) {
        print(e);
        loading.value= false;
        Map error = e as Map;
        error.forEach((key, value) =>
            Get.showSnackbar(Ui.ErrorSnackBar(message: value[0], title: key)));
      }
    } else {
      Get.showSnackbar(Ui.ErrorSnackBar(
          message: "There are errors in some fields please correct them!".tr));
    }
    loading.value= false;
  }
}
