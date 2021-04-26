import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/models/setting_model.dart';
import 'package:itcase/app/services/settings_service.dart';

import '../../../../common/ui.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_service.dart';
import '../../root/controllers/root_controller.dart';
import '../controllers/account_controller.dart';
import '../widgets/account_link_widget.dart';

class SettingsProfileView extends GetView<AccountController> {

  @override
  Widget build(BuildContext context) {
    var _currentUser = Get.find<AuthService>().user;
    final Setting _settings = Get.find<SettingsService>().setting.value;
    return
        RefreshIndicator(
        onRefresh: () async {
          controller.refreshAccount(showMessage: true);
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Settings".tr,
                style: Get.textTheme.headline6
                    .merge(TextStyle(color: context.theme.primaryColor)),
              ),
              centerTitle: true,
              backgroundColor: Get.theme.accentColor,
              automaticallyImplyLeading: false,
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back, color: Get.theme.primaryColor),
                onPressed: () => {Get.back()},
              ),
              elevation: 0,
            ),
            body: ListView(
              primary: true,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: Ui.getBoxDecoration(),
                  child: Column(
                    children: [
                      AccountLinkWidget(
                        icon: Icon(Icons.person_outline,
                            color: Get.theme.accentColor),
                        text: Text("Profile".tr),
                        onTap: (e) {
                          Get.toNamed(Routes.PROFILE, arguments: _currentUser.value);
                        },
                      ),
                      AccountLinkWidget(
                        icon: Icon(Icons.assignment_outlined,
                            color: Get.theme.accentColor),
                        text: Text("My Bookings".tr),
                        onTap: (e) {
                          Get.find<RootController>().changePageInRoot(1);
                        },
                      ),
                      AccountLinkWidget(
                        icon: Icon(Icons.notifications_outlined,
                            color: Get.theme.accentColor),
                        text: Text("Notifications".tr),
                        onTap: (e) {
                          Get.toNamed(Routes.NOTIFICATIONS);
                        },
                      ),
                      AccountLinkWidget(
                        icon:
                        Icon(Icons.chat_outlined, color: Get.theme.accentColor),
                        text: Text("Messages".tr),
                        onTap: (e) {
                          Get.find<RootController>().changePageInRoot(2);
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: Ui.getBoxDecoration(),
                  child: Column(
                    children: [
                      AccountLinkWidget(
                        icon: Icon(Icons.settings_outlined,
                            color: Get.theme.accentColor),
                        text: Text("Settings App".tr),
                        onTap: (e) {
                          Get.toNamed(Routes.SETTINGS);
                        },
                      ),
                      AccountLinkWidget(
                        icon: Icon(Icons.translate_outlined,
                            color: Get.theme.accentColor),
                        text: Text("Languages".tr),
                        onTap: (e) {
                          Get.toNamed(Routes.SETTINGS_LANGUAGE);
                        },
                      ),
                      AccountLinkWidget(
                        icon: Icon(Icons.brightness_6_outlined,
                            color: Get.theme.accentColor),
                        text: Text("Theme Mode".tr),
                        onTap: (e) {
                          Get.toNamed(Routes.SETTINGS_THEME_MODE);
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: Ui.getBoxDecoration(),
                  child: Column(
                    children: [
                      AccountLinkWidget(
                        icon: Icon(Icons.support_outlined,
                            color: Get.theme.accentColor),
                        text: Text("Help & FAQ".tr),
                        onTap: (e) {
                          Get.toNamed(Routes.HELP);
                        },
                      ),
                      AccountLinkWidget(
                        icon: Icon(Icons.logout, color: Get.theme.accentColor),
                        text: Text("Logout".tr),
                        onTap: (e) {
                          Get.offAllNamed(Routes.LOGIN);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )),
      );
  }
}
