import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/models/setting_model.dart';
import 'package:itcase/app/models/user_model.dart';
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
                          Get.toNamed(Routes.PROFILE, arguments: null);
                        },
                      ),
                      AccountLinkWidget(
                        icon: Icon(Icons.vpn_key,
                            color: Get.theme.accentColor),
                        text: Text("Change Password".tr),
                        onTap: (e) {
                          Get.toNamed(Routes.CHANGE_PASSWORD, arguments: null);
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
                        icon: Icon(Icons.translate_outlined,
                            color: Get.theme.accentColor),
                        text: Text("Languages".tr),
                        onTap: (e) {
                          Get.toNamed(Routes.SETTINGS_LANGUAGE);
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
                      // AccountLinkWidget(
                      //   icon: Icon(Icons.support_outlined,
                      //       color: Get.theme.accentColor),
                      //   text: Text("Help & FAQ".tr),
                      //   onTap: (e) {
                      //     Get.toNamed(Routes.HELP);
                      //   },
                      // ),
                      AccountLinkWidget(
                        icon: Icon(Icons.logout, color: Get.theme.accentColor),
                        text: Text("Logout".tr),
                        onTap: (e) {
                          final prefs = Get.find<AuthService>().prefs;
                          prefs.remove('token');
                          controller.currentUser(new User());
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
