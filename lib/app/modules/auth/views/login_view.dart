import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/global_widgets/circular_loading_widget.dart';
import 'file:///C:/Projects/newest/itcase/lib/app/modules/auth/views/register/register_view.dart';
import 'package:itcase/app/services/auth_service.dart';

import '../../../../common/ui.dart';
import '../../../global_widgets/block_button_widget.dart';
import '../../../global_widgets/text_field_widget.dart';
import '../../../models/setting_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/settings_service.dart';
import '../controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  // final _currentUser = Get.find<AuthService>().user;
  final Setting _settings = Get.find<SettingsService>().setting.value;
  final GlobalKey<FormState> _loginForm = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Вход".tr,
            style: Get.textTheme.headline6
                .merge(TextStyle(color: context.theme.primaryColor)),
          ),
          centerTitle: true,
          backgroundColor: Get.theme.accentColor,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: Obx(
          ()=>Stack(
            children: [
                Visibility(
                  visible: controller.loading.value,
                  child: CircularLoadingWidget(
                  height: Get.height,
                  onCompleteText: "".tr,
                ),
                ),
              Visibility(
                visible:!controller.loading.value,
                child: Form(
                  key: _loginForm,
                  child: ListView(
                    primary: true,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Container(
                            height: 180,
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: Get.theme.accentColor,
                              image: DecorationImage(
                                image: AssetImage("assets/icon/itcase.jpg"),
                                fit: BoxFit.cover,
                              ),
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
                              child: SizedBox()
                            ),
                          ),
                          Container(
                            decoration: Ui.getBoxDecoration(
                              radius: 100,
                              border:
                                  Border.all(width: 5, color: Get.theme.primaryColor),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(100000000)),
                              child: Image.asset(
                                'assets/icon/logo_itcase.png',
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        child: Column(
                          children: [
                            Text(
                              _settings.appName,
                              style: Get.textTheme.headline6.merge(TextStyle(
                                  color: Get.theme.accentColor, fontSize: 24)),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Добро пожаловать, надеждные исполнители для решения любых задач".tr,
                              style: Get.textTheme.caption.merge(
                                  TextStyle(color: Get.theme.accentColor)),
                              textAlign: TextAlign.center,
                            ),
                            // Text("Fill the following credentials to login your account", style: Get.textTheme.caption.merge(TextStyle(color: Get.theme.primaryColor))),
                          ],
                        ),
                      ),
                      TextFieldWidget(
                        labelText: "Введите e-mail".tr,
                        hintText: "johndoe@gmail.com".tr,
                        iconData: Icons.alternate_email,
                        onSaved: (val) => controller.user.value.email = val,
                        validator: (val) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val)
                              ? null
                              : "Пожалуйста введите правильный mail";
                        },
                      ),
                      Obx(() {
                        return TextFieldWidget(
                          labelText: "Password".tr,
                          hintText: "••••••••••••".tr,
                          obscureText: controller.hidePassword.value,
                          onSaved: (val) => controller.user.value.password = val,
                          validator: (val) =>
                              val.length == 0 ? "Пожалуйста введите пароль" : null,
                          iconData: Icons.lock_outline,
                          keyboardType: TextInputType.visiblePassword,
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.hidePassword.value =
                                  !controller.hidePassword.value;
                            },
                            color: Theme.of(context).focusColor,
                            icon: Icon(controller.hidePassword.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                          ),
                        );
                      }),
                      Visibility(
                        visible: controller.loading.value,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Get.offAndToNamed(Routes.FORGOT_PASSWORD);
                              },
                              child: Text("Forget password?".tr, style: Get.textTheme.button,),
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 20),
                      ),
                      BlockButtonWidget(
                        onPressed: () async {
                          // Get.offAllNamed(Routes.ROOT);
                          controller.user.value.phone_number = await deviceInfo();
                          controller.login(_loginForm);
                        },
                        color: Get.theme.buttonColor,
                        text: Text(
                          "Login".tr,
                          style: Get.textTheme.headline6
                              .merge(TextStyle(color: Get.theme.primaryColor)),
                        ),
                      ).paddingSymmetric(vertical: 10, horizontal: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.REGISTER);
                            },
                            child: Text("У вас ещё нету аккаунта?".tr, style: Get.textTheme.button,),
                          ),
                        ],
                      ).paddingSymmetric(vertical: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

  deviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.device;
  }
}
