import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:itcase/app/models/category_model.dart';
import 'package:itcase/app/models/user_model.dart';
import 'package:itcase/app/modules/auth/views/register_3step.dart';
import 'package:itcase/app/modules/tasks/views/task_intro.dart';
import 'package:itcase/app/providers/api.dart';
import 'package:itcase/app/routes/app_pages.dart';
import 'package:itcase/app/services/auth_service.dart';
import 'package:itcase/common/ui.dart';
import 'package:itcase/app/modules/auth/views/register_2step.dart';
// import 'package:itcase/app/modules/auth/views/signup/step1.dart';

class AuthController extends GetxController {
  String confirm;
  GetStorage _box;

  @override
  void onInit() {
    // if (Get.find<AuthService>().isAuth) Get.toNamed(Routes.ROOT);

    super.onInit();
  }

  final currentUser = Get.find<AuthService>().user;

  final Map<String, dynamic> data = Map<String, dynamic>();

  var user = new User().obs;
  var customer = new Customer().obs;
  var contractor = new Contractor().obs;
  final hidePassword = true.obs;
  final agree = false.obs;
  final gender = "male".obs;
  final type = "individual".obs;
  final role = "contractor".obs;

  login(GlobalKey<FormState> loginForm) async {
    if (loginForm.currentState.validate()) {
      loginForm.currentState.save();
      _box = new GetStorage();
      print(user.value.toJsonlogin());
      var response = await API().login(user.value.toJsonlogin());
      print(response.statusCode);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        currentUser.value.auth = true;
        currentUser.value.token = body['token'];

        var res = await API().getData('accout');
        print(res.body);

        _box.write('current_user', jsonEncode(user));
        Get.toNamed(Routes.ROOT);
      } else {
        print(response.body);
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: "Email or password incorrect.".tr));
      }
    } else {
      Get.showSnackbar(Ui.ErrorSnackBar(
          message: "There are errors in some fields please correct them!".tr));
    }
    update();
  }

  step2(GlobalKey<FormState> signupForm) async {
    // Get.to(Register2View());
    Get.to(TaskIntro());

/*
    if (signupForm.currentState.validate()) {
      signupForm.currentState.save();
      var response = await API().post(user.value.toJsonSingup(), "register");
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        currentUser.value.auth = true;
        currentUser.value.token = body['token'];
        // Get.to(TaskIntro());
        Get.to(Register2View());

        // Get.to(Step1());
      } else {
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: jsonEncode(jsonDecode(response.body))));
      }
    } else {
      Get.showSnackbar(Ui.ErrorSnackBar(
          message: "There are errors in some fields please correct them!".tr));
    }
    */
  }

  signup(GlobalKey<FormState> signupForm, role) async {
    Get.to(Register3View());
    /*
    if (signupForm.currentState.validate()) {
      signupForm.currentState.save();
      var data;
      if (role == 'contractor') {
        data = jsonEncode(contractor.value.toJson());
      } else {
        data = jsonEncode(customer.value.toJson());
      }

      var response = await API().post(data, 'account/create');
      print(response.statusCode);

      print(jsonEncode(jsonDecode(response.body)));

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        if (body['message'] != null) {}
      }
    }*/
  }
}