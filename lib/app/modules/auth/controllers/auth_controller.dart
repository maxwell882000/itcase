import 'dart:convert';

import 'package:date_time_picker/date_time_picker.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:itcase/app/models/user_model.dart';
import 'package:itcase/app/modules/auth/controllers/verify_controller.dart';

import 'package:itcase/app/providers/api.dart';
import 'package:itcase/app/repositories/user_repository.dart';
import 'package:itcase/app/routes/app_pages.dart';
import 'package:itcase/app/services/auth_service.dart';
import 'package:itcase/app/services/firebase_messaging_service.dart';
import 'package:itcase/common/ui.dart';

class AuthController extends GetxController {
  String confirm;
  GetStorage _box;

  final currentUser = Get.find<AuthService>().user;
  final formKey = GlobalKey<FormState>().obs;
  final tempKey = GlobalKey<FormState>().obs;
  final Map<String, dynamic> data = Map<String, dynamic>();

  final UserRepository _userRepository = new UserRepository();
  var user = new User().obs;

  var tempUser = new TempUser().obs;

  final hidePassword = true.obs;

  final loading = true.obs;

  @override
  void onInit() async {
    user = Get.find<AuthService>().user;
    await startingPoint();
    Future.delayed(Duration(seconds: 2)).then((value) => loading.value = false);

    super.onInit();
  }

  Future startingPoint() async {
    print("SOMETHING");
    if (currentUser.value.auth != null && currentUser.value.auth == true) {
      print("AUTHORIZED");
      await getAccount();
      Get.offAllNamed(Routes.ROOT);
    }
  }

  Future getAccount() async {
    Map body = await _userRepository.getAccount();
    body['user']['password'] = user.value.password;
    currentUser.value.fromJson(body['user']);
    currentUser.value.password = user.value.password;
  }

  validate() async {
    try {
      await getAccount();
      final prefs = Get.find<AuthService>().prefs;
      prefs.setString('token', currentUser.value.token);
      if (currentUser.value.phoneConfirmed) {
        if (currentUser.value.account_paid == null) {
          Future.delayed(Duration(seconds: 5))
              .then((value) => VerifyController().make_payment());
          Get.showSnackbar(Ui.ErrorSnackBar(
              message:
                  "You did not pay for your account. Please make payment at first. Web site for making payment will open in 5 seconds"
                      .tr
                      .tr));
          return false;
        }
      } else {
        _userRepository.resendPhoneCode().then((value) {
          if (value) {
            Get.toNamed(Routes.PHONE_VERIFICATION);
          }
        });
        Get.showSnackbar(Ui.ErrorSnackBar(
            message:
                "You are required to confirm your phone number. Window for confirmation of phone will open in 3 seconds"
                    .tr));
        return false;
      }
    } catch (e) {
      if (e == 401) {
        await Get.showSnackbar(Ui.ErrorSnackBar(
            message:
                "You are required at first fill your data. Window for filling data will open in 3 seconds"
                    .tr
                    .tr));
        currentUser.value.phone_number = "";
        Get.toNamed(Routes.BECOME_CONSUMER, arguments: currentUser.value);
        return false;
      }
      print(e);
      Get.showSnackbar(Ui.ErrorSnackBar(message: e));
      return false;
    }

    return true;
  }

  login(GlobalKey<FormState> loginForm) async {
    loading.value = true;
    try {
      if (loginForm.currentState.validate()) {
        loginForm.currentState.save();
        _box = new GetStorage();
        print(user.value.toJsonlogin());
        var response = await API().login(jsonEncode(user.value.toJsonlogin()));
        print(response.statusCode);
        if (response.statusCode == 200) {
          var body = jsonDecode(response.body);
          // OLD METHOD
          // currentUser.value.auth = true;
          // currentUser.value.token = body['token'];
          // currentUser.value.password = user.value.password;
          currentUser.update((val) {
            val.auth = true;
            val.token = body['token'];
            val.password = user.value.password;
          });

          if (await validate()) {
            Get.find<FireBaseService>().sendOrMissToken();
            Get.offAllNamed(Routes.ROOT);
          }
        } else {
          print(response.body);
          Get.showSnackbar(
              Ui.ErrorSnackBar(message: "Email or password incorrect.".tr));
        }
      } else {
        Get.showSnackbar(Ui.ErrorSnackBar(
            message:
                "There are errors in some fields please correct them!".tr));
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: "Try again please".tr));
    } finally {
      loading.value = false;
      update();
    }
  }

  modify_passwords() {}
}
