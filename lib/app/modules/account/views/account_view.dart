import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
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

class AccountView extends GetView<AccountController> {
  Widget text(String text) {
    return Container(
      width: Get.width*0.9,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              text,
              style: Get.textTheme.bodyText1.merge(TextStyle(
                fontSize: 14

              )),
            ),
          ),
        ],
      ),
    );
  }

  Widget icon(IconData icon) {
    return Icon(
      icon,
      color: Get.theme.accentColor,
    );
  }

  Widget row(icon, text) {
    return Row(
    children: [
      this.icon(icon),
      SizedBox(
        width: 20,
      ),
      this.text(text),
    ],
      );
  }

  Widget validated(var currentUser) {
    List<Widget> widget = [];

    if (currentUser.value.phoneConfirmed != null && currentUser.value.phoneConfirmed) {
      widget.add(row(Icons.phone, "Phone".tr));
    }
    widget.add(SizedBox(
      height: 10,
    ));
    if (currentUser.value.emailConfirmed != null && currentUser.value.emailConfirmed) {
      widget.add(row(Icons.email, "Email".tr));
    }
    // if (currentUser.value.passportConfirmed != null && currentUser.value.passportConfirmed) {
    //   widget.add(row(Icons.description, "Passport".tr));
    // }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget,
    );
  }

  Widget account(var controller,
      {Widget child = const SizedBox(), Function tasks, Function takenTasks}) {
    final Setting _settings = Get
        .find<SettingsService>()
        .setting
        .value;
    return ListView(
      primary: true,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              height: 150,
              width: Get.width,
              decoration: BoxDecoration(
                color: Get.theme.accentColor,
                borderRadius:
                BorderRadius.vertical(bottom: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      color: Get.theme.focusColor.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 5)),
                ],
              ),
              margin: EdgeInsets.only(bottom: 50),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Obx(
                          () =>
                          Text(
                            controller.accountSee.value.name.value,
                            style: Get.textTheme.headline6
                                .merge(TextStyle(color: Get.theme
                                .primaryColor)),
                          ),
                    ),
                    SizedBox(height: 5),
                    Obx(
                          () =>
                          Text(controller.accountSee.value.email.value ?? " ",
                              style: Get.textTheme.caption
                                  .merge(TextStyle(color: Get.theme
                                  .primaryColor,
                                  fontSize: 12))),
                    ),
                    SizedBox(height: 5),
                    Visibility(
                      visible: controller.accountSee.value.permission.value,
                      child: Obx(
                            () =>
                            Text(controller.accountSee.value.phone.value ?? " ",
                                style: Get.textTheme.caption
                                    .merge(TextStyle(color: Get.theme
                                    .primaryColor,
                                    fontSize: 12
                                ))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 100,
              width: Get.width,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Column(
                      children: [
                        Obx(
                              () =>
                              Text(
                                controller.accountSee.value.numberGivenTasks
                                    .value,
                                style: Get.textTheme.headline6.merge(
                                    TextStyle(color: Get.theme.primaryColor)),
                              ),
                        ),
                        Text("created tasks".tr,
                            style: Get.textTheme.caption.merge(
                                TextStyle(color: Get.theme.primaryColor,
                                fontSize: 12))),
                      ],
                    ),
                    onTap: () => tasks(),
                  ),
                  Visibility(
                    visible: controller.accountSee.value.isContractor.value,
                    child: GestureDetector(
                      child: Column(
                        children: [
                          Obx(
                                () =>
                                Text(
                                  controller
                                      .accountSee.value.numberAccomplishedTasks.value,
                                  style: Get.textTheme.headline6.merge(
                                      TextStyle(color: Get.theme.primaryColor)),
                                ),
                          ),
                          Text("taken tasks".tr,
                              style: Get.textTheme.caption.merge(
                                  TextStyle(color: Get.theme.primaryColor,
                                  fontSize: 12))),
                        ],
                      ),
                      onTap: () => takenTasks(),
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              child: Obx(
                    () =>
                    CachedNetworkImage(
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      imageUrl: controller.accountSee.value.image.value,
                      placeholder: (context, url) =>
                          Image.asset(
                            'assets/img/loading.gif',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 100,
                          ),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error_outline),
                    ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 80),
              child: Obx(
                    () =>
                    Container(
                        width: 20,
                        height: 20,
                        decoration: Ui.getBoxDecoration(
                          color: controller.accountSee.value.statusOnline.value
                              ? Ui.parseColor(_settings.enable_color)
                              : Get.theme.primaryColor,
                          radius: 14,
                          border:
                          Border.all(width: 3, color: Get.theme.primaryColor),
                        ),
                        child: SizedBox()),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Wrap(
            direction: Axis.vertical,
            spacing: 10,
            children: [
              SizedBox(
                height: 10,
              ),
              Text("About myself".tr, style: Get.textTheme.headline2),
              Obx(() =>
                  text(controller.accountSee.value.aboutMyself.value ?? " ")),
              SizedBox(
                height: 10,
              ),
              Text(
                "Validated".tr,
                style: Get.textTheme.headline2,
              ),
              child
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.refreshAccount(showMessage: true);
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Get.theme.primaryColor,
                ),
                onPressed: () async {
                  await Get.toNamed(Routes.SETTINGS_PROFILE);
                  controller.refreshAccount();
                  print("BACKED");
                }),
          ],
          title: Text(
            "Account".tr,
            style: Get.textTheme.headline6
                .merge(TextStyle(color: context.theme.primaryColor)),
          ),
          centerTitle: true,
          backgroundColor: Get.theme.accentColor,
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(Icons.sort, color: Get.theme.primaryColor),
            onPressed: () => {Scaffold.of(context).openDrawer()},
          ),
          elevation: 0,
        ),
        body:
        account(controller, child: validated(controller.currentUser),
            tasks: ()async =>{
          controller.onNextPage(controller.getOpenedTasks),
              controller.getOpenedTasks(),
                Get.toNamed(Routes.MY_TASKS,arguments: controller.currentUser.value),
            },
          takenTasks: ()async => {
            controller.onNextPage(controller.getAcceptedTenders),
            controller.getAcceptedTenders(),
          Get.toNamed(Routes.REQUESTED_TASKS, arguments: controller.currentUser.value)},
      ),
      ),
    );
  }
}
