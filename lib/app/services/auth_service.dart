import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/address_model.dart';
import '../models/user_model.dart';
import '../repositories/user_repository.dart';

class AuthService extends GetxService {
  final user = User().obs;
  final address = Address().obs;
  // final curUser;
  GetStorage _box;

  UserRepository _usersRepo;

  AuthService() {
    _usersRepo = new UserRepository();
    _box = new GetStorage();
    // curUser = ;
  }

  Future<AuthService> init() async {
    // TODO Complete version
    if (user.value.auth == null && _box.hasData('current_user')) {
      user.value = User.fromJson(jsonDecode(await _box.read('current_user')));
      user.value.auth = true;
    } else {
      user.value.auth = false;
    }

    // user.value = await _usersRepo.login();
    // user.value.auth = true;

    address.listen((Address _address) {
      _box.write('current_address', _address);
    });

    if (_box.hasData('current_address')) {
      address.value = Address.fromJson(await _box.read('current_address'));
    }
    return this;
  }

  bool get isAuth => user.value.auth ?? false;
}
