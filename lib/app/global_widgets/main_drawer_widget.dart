import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/models/user_model.dart';
import 'package:itcase/app/services/auth_service.dart';
import 'package:itcase/common/ui.dart';


import '../modules/auth/controllers/auth_controller.dart';
import '../modules/auth/views/register/fill_account.dart';
import '../modules/root/controllers/root_controller.dart' show RootController;
import '../routes/app_pages.dart';
import '../services/settings_service.dart';
import 'drawer_link_widget.dart';

class MainDrawerWidget extends StatelessWidget {
  final RootController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    print('ASDSAD');
    return Drawer(
      child: ListView(
        children: [
          GestureDetector(
            onTap: () {
              //currentUser.value.apiToken != null ? Navigator.of(context).pushNamed('/Profile') : Navigator.of(context).pushNamed('/Login');
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
              decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .hintColor
                    .withOpacity(0.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome".tr,
                      style: Get.textTheme.headline5.merge(
                          TextStyle(color: Theme
                              .of(context)
                              .accentColor))),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () { Get.back();
                        Get.find<RootController>().changePage(3);
                        },
                        child:  ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          child: Obx(
                                ()
                                {
                                  if (controller.currentUser.value
                                      .image_gotten != null)
                                   return  CachedNetworkImage(
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                      imageUrl: controller.currentUser.value
                                          .image_gotten,
                                      placeholder: (context, url) =>
                                          Image.asset(
                                            'assets/img/loading.gif',
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: 100,
                                          ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error_outline),
                                    );
                                  return SizedBox();
                                }
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      if(controller.currentUser.value.auth)
                        Text("${controller.currentUser.value.name}".tr,
                            style: Get.textTheme.bodyText1.merge(TextStyle(
                              fontSize: 12
                            ))),
                    ],
                  ),


                  if(!controller.currentUser.value.auth)
                    SizedBox(height: 15),
                  if(!controller.currentUser.value.auth)
                    Wrap(
                      spacing: 10,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Get.offAndToNamed(Routes.LOGIN);
                          },
                          color: Get.theme.accentColor,
                          height: 40,
                          child: Wrap(
                            runAlignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 9,
                            children: [
                              Icon(Icons.exit_to_app_outlined,
                                  color: Get.theme.primaryColor, size: 24),
                              Text(
                                "Login".tr,
                                style: Get.textTheme.subtitle1.merge(
                                    TextStyle(color: Get.theme.primaryColor)),
                              ),
                            ],
                          ),
                          shape: StadiumBorder(),
                        ),
                        // FlatButton(
                        //   color: Get.theme.focusColor.withOpacity(0.2),
                        //   height: 40,
                        //   onPressed: () {
                        //     Get.offAllNamed(Routes.REGISTER);
                        //   },
                        //   child: Wrap(
                        //     runAlignment: WrapAlignment.center,
                        //     crossAxisAlignment: WrapCrossAlignment.center,
                        //     spacing: 9,
                        //     children: [
                        //       Icon(Icons.person_add_outlined,
                        //           color: Get.theme.hintColor, size: 24),
                        //       Text(
                        //         "Register".tr,
                        //         style: Get.textTheme.subtitle1
                        //             .merge(
                        //             TextStyle(color: Get.theme.hintColor)),
                        //       ),
                        //     ],
                        //   ),
                        //   shape: StadiumBorder(),
                        // ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          DrawerLinkWidget(
            icon: Icons.home_outlined,
            text: "Home".tr,
            onTap: (e) {
              Get.back();
              Get.find<RootController>().changePage(0);
            },
          ),
          DrawerLinkWidget(
            icon: Icons.folder_special_outlined,
            text: "Categories".tr,
            onTap: (e) {
              Get.toNamed(Routes.CATEGORIES);
            },
          ),
          DrawerLinkWidget(
            icon: Icons.assignment_outlined,
            text: "Bookings".tr,
            onTap: (e) {
              Get.back();
              Get.find<RootController>().changePage(1);
            },
          ),
          DrawerLinkWidget(
            icon: Icons.notifications_none_outlined,
            text: "Notifications",
            onTap: (e) {
              Get.toNamed(Routes.NOTIFICATIONS);
            },
          ),
          DrawerLinkWidget(

            icon: Icons.favorite_outline,

            text: "My tasks".tr,
            onTap: (e) {
              Get.toNamed(Routes.MY_TASKS);
            },
          ),
          DrawerLinkWidget(
            icon: Icons.chat_outlined,
            text: "Messages".tr,
            onTap: (e) {
              Get.back();
              Get.toNamed(Routes.CHATS_ALL);
            },
          ),
          if(controller.currentUser.value.auth && !controller.currentUser.value.isContractor.value)
            DrawerLinkWidget(
              icon: Icons.check,
              text: "Become a contractor".tr,
              onTap: (e) {
               Get.toNamed(Routes.BECOME_CONSTRUCTOR);
              },
            ),
          ListTile(
            dense: true,
            title: Text(
              "Application preferences".tr,
              style: Get.textTheme.caption,
            ),
            trailing: Icon(
              Icons.remove,
              color: Get.theme.focusColor.withOpacity(0.3),
            ),
          ),
          DrawerLinkWidget(
            icon: Icons.person_outline,
            text: "Account",
            onTap: (e) {
              Get.back();
              Get.find<RootController>().changePage(3);
            },
          ),
          DrawerLinkWidget(
            icon: Icons.translate_outlined,
            text: "Languages",
            onTap: (e) {
              Get.toNamed(Routes.SETTINGS_LANGUAGE);
            },
          ),

          // ListTile(
          //   dense: true,
          //   title: Text(
          //     "Help & Privacy".tr,
          //     style: Get.textTheme.caption,
          //   ),
          //   trailing: Icon(
          //     Icons.remove,
          //     color: Get.theme.focusColor.withOpacity(0.3),
          //   ),
          // ),
          // DrawerLinkWidget(
          //   icon: Icons.help_outline,
          //   text: "Help & FAQ".tr,
          //   onTap: (e) {
          //     Get.toNamed(Routes.HELP);
          //   },
          // ),
          // DrawerLinkWidget(
          //   icon: Icons.privacy_tip_outlined,
          //   text: "Privacy Policy".tr,
          //   onTap: (e) {
          //     Get.toNamed(Routes.PRIVACY);
          //   },
          // ),
          DrawerLinkWidget(
            icon: Icons.logout,
            text: "Logout".tr,
            onTap: (e) {
              final prefs = Get.find<AuthService>().prefs;
              prefs.remove('token');
              controller.currentUser(new User());
              Get.offAllNamed(Routes.LOGIN);
            },
          ),
          if (Get
              .find<SettingsService>()
              .setting
              .value
              .enableVersion)
            ListTile(
              dense: true,
              title: Text(
                "Version".tr +
                    " " +
                    Get
                        .find<SettingsService>()
                        .setting
                        .value
                        .appVersion,
                style: Get.textTheme.caption,
              ),
              trailing: Icon(
                Icons.remove,
                color: Get.theme.focusColor.withOpacity(0.3),
              ),
            )
        ],
      ),
    );
  }
}
