/*
 * Copyright (c) 2020 .
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/models/chat_model.dart';
import 'package:itcase/app/models/message_model.dart';
import 'package:itcase/app/modules/account/controllers/account_controller.dart';
import 'package:itcase/app/modules/category/views/categories_view.dart';
import 'package:itcase/app/modules/home/views/home2_view.dart';
import 'package:itcase/app/modules/home/views/home_view.dart';
import 'package:itcase/app/repositories/chat_repository.dart';
import 'package:itcase/app/services/auth_service.dart';
import '../../../routes/app_pages.dart';

import '../../account/views/account_view.dart';
import '../../messages/views/messages_view.dart';
import '../../tasks/views/tasks_view.dart';
import '../../tasks/views/task_intro.dart';

class RootController extends GetxController {
  final currentIndex = 0.obs;
  final currentUser = Get.find<AuthService>().user;


  @override
  void onInit() async {
    if (Get.arguments != null && Get.arguments is int) {
      changePageInRoot(Get.arguments as int);
    } else {
      changePageInRoot(0);
    }

    super.onInit();
  }

  List<Widget> pages = [
    // CategoriesView(),
    Home2View(),
    TasksView(),
    TaskIntro(),
    AccountView(),
    //MessagesView(),
  ];

  Widget get currentPage => pages[currentIndex.value];



  /**
   * change page in route
   * */
  void changePageInRoot(int _index) {
    currentIndex.value = _index;
  }

  void changePageOutRoot(int _index) {
    currentIndex.value = _index;
    Get.offNamedUntil(Routes.ROOT, (Route route) {
      if (route.settings.name == Routes.ROOT) {
        return true;
      }
      return false;
    }, arguments: _index);
  }

  void changePage(int _index) {
    if (Get.currentRoute == Routes.ROOT) {
      changePageInRoot(_index);
    } else {
      changePageOutRoot(_index);
    }
  }
}
