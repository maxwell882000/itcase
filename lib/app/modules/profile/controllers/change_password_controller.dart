import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/models/user_model.dart';
import 'package:itcase/app/modules/auth/controllers/auth_controller.dart';
import 'package:itcase/app/repositories/user_repository.dart';
import 'package:itcase/common/ui.dart';
class ChangePasswordController extends GetxController {
  final oldPassword = "".obs;
  final newPassword = "".obs;
  final repeatPassword = "".obs;
  final loading = false.obs;
  final hidePassword = true.obs;
  final hideNewPassword = true.obs;
  final hideRepeatPassword = true.obs;
  final UserRepository _userRepository = new UserRepository();
  @override
  void onInit() {
    super.onInit();
  }
 String toJson(){
    return jsonEncode({
      'currentPassword':oldPassword.value,
      'newPassword' : newPassword.value,
      'newPasswordRepeat':repeatPassword.value

    });
  }
  bool validate() {
    print(repeatPassword.value +  " " + " "  + newPassword.value);
    print(repeatPassword.value.compareTo(newPassword.value));
    if (repeatPassword.value.compareTo(newPassword.value) != 0){
      Get.showSnackbar(
          Ui.ErrorSnackBar(message: "Passwords don`t match".tr));
      return false;
    }
    return true;
  }
  void changePassword(GlobalKey<FormState> profileForm) async{
    loading.value = true;

    if (profileForm.currentState.validate()) {
      profileForm.currentState.save();
      if (validate()) {
        print("changed");

        try {
          Map response =
          await _userRepository.changePassword(toJson());
          await Get.showSnackbar(
              Ui.SuccessSnackBar(message: response['message']));
          loading.value = false;
        } catch (e) {
          loading.value = false;
          Map body = jsonDecode(e.toString());
          body['error'].forEach((key, value) =>
              Get.showSnackbar(Ui.ErrorSnackBar(message: value[0])));
        }
      }
    }
    loading.value = false;
  }

  void resetProfileForm(GlobalKey<FormState> profileForm) {
    profileForm.currentState.reset();
  }
}
