import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/providers/api.dart';
import 'package:itcase/app/repositories/user_repository.dart';
import 'package:itcase/app/routes/app_pages.dart';
import 'package:itcase/app/services/auth_service.dart';
import 'package:itcase/common/ui.dart';
import 'package:url_launcher/url_launcher.dart';

class VerifyController extends GetxController {
  final code = 0.obs;
  final currentUser = Get.find<AuthService>().user;
  final loading = false.obs;
  final UserRepository _userRepository = new UserRepository();
  final sendAgain = true.obs;

  @override
  void onInit() {
    // if (Get.find<AuthService>().isAuth) Get.toNamed(Routes.ROOT);

    super.onInit();
  }

  make_payment() async {
    String url = "account/create";
    if (Platform.isAndroid) {
      url = "$url?dynamicUrl=true";
    }
    var get_response = await API().getData(url);
    var body_1 = jsonDecode(get_response.body);
    var site = body_1['paymentUrl'];
    print("PAYMENT URL");
    print(site);
    if (await canLaunch(site)) await launch(site);
  }

  Future sendMoreTime() async {
    print("PASSWORD PASS ${currentUser.value.password}");
    if (sendAgain.value) {
      sendAgain.value = false;
      Get.showSnackbar(Ui.SuccessSnackBar(message: "Code is sent".tr));
      await login();
      await _userRepository.resendPhoneCode();
      Future.delayed(Duration(seconds: 60))
          .then((value) => sendAgain.value = true);
    } else {
      Get.showSnackbar(
          Ui.ErrorSnackBar(message: "Code can be sent every 60 seconds".tr));
    }
  }

  Future login() async {
    if (currentUser.value.token == null || currentUser.value.token.isEmpty) {
      var login = await API().login(jsonEncode({
        "email": currentUser.value.email,
        "password": currentUser.value.password
      }));
      var body = jsonDecode(login.body);
      print(body);
      currentUser.value.token = body['token'];
      print(code.value);
    }
  }

  phone_verify(GlobalKey<FormState> validateForm) async {
    loading.value = true;
    if (validateForm.currentState.validate()) {
      validateForm.currentState.save();
      print(currentUser.value.password);
      print(currentUser.value.email);
      await login();

      var response =
          await API().post(jsonEncode({'code': code.value}), "phone/verify");
      print(response.statusCode.toString());
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        make_payment();
        Get.toNamed(Routes.AFTER_REGISTRATION);
      } else {
        Get.showSnackbar(Ui.ErrorSnackBar(message: "Incorrect code".tr));
      }
    }
    loading.value = false;
  }
}
