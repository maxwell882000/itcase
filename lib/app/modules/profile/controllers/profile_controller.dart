import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/models/user_model.dart';
import 'package:itcase/app/modules/auth/controllers/auth_controller.dart';
import 'package:itcase/common/ui.dart';
class ProfileController extends AuthController {
  var user = new User().obs;


  @override
  void onInit() {
    super.onInit();
    user.value = Get.arguments as User;
    print(user.value.email);

  }

  void saveProfileForm(GlobalKey<FormState> profileForm) {
    if (formKey.value.currentState.validate()) {
      formKey.value.currentState.save();
      print("changed");
      print(tempUser.value.gender);
      Get.showSnackbar(
          Ui.SuccessSnackBar(message: "Profile saved successfully".tr));
    } else {
      Get.showSnackbar(Ui.ErrorSnackBar(
          message: "There are errors in some fields please correct them!".tr));
    }
  }

  void resetProfileForm(GlobalKey<FormState> profileForm) {
    profileForm.currentState.reset();
  }
}
