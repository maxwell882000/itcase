import 'dart:convert';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:itcase/app/models/user_model.dart';

class AccountController extends GetxController {
  @override
  void onInit() {
    // if (Get.find<AuthService>().isAuth) Get.toNamed(Routes.ROOT);
    super.onInit();
  }

  // final currentUser = Get.find<AuthService>().user;

  final Map<String, dynamic> data = Map<String, dynamic>();

  var user = new User().obs;
  final firstname = "".obs;
  final lastname = "".obs;
  final secondname = "".obs;
  final city = "".obs;
  final phone = "".obs;
  final avatar = "".obs;
  final birthday = DateFormat('dd.MM.yyyy').format(DateTime.now()).obs;

  signup(GlobalKey<FormState> signupForm, role) async {
    if (signupForm.currentState.validate()) {
      signupForm.currentState.save();
      var data;
    }
  }
}
