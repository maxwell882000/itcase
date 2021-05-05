import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/address_model.dart';
import '../models/user_model.dart';
import '../repositories/user_repository.dart';

class AuthService extends GetxService {
  final user = User().obs;
  final address = Address().obs;
  // final curUser;
  GetStorage box;
  SharedPreferences prefs;

  UserRepository _usersRepo;

  AuthService() {
    _usersRepo = new UserRepository();
    box = new GetStorage();
    // curUser = ;
  }

  Future<AuthService> init() async {
    prefs = await SharedPreferences.getInstance();
    print("AUTH VALUE :::: ");
    print(user.value.auth);
    print(box.hasData('current_user'));
    String token = prefs.getString('token') ?? "";
    if ( token.isNotEmpty) {
        user.update((val) {
          val.auth = true;
          val.token = token;
        });
    } else {
      user.update((val) {
        val.auth = false;
      });
    }

    // user.value = await _usersRepo.login();
    // user.value.auth = true;

    return this;
  }

  bool get isAuth => user.value.auth ?? false;
}
