
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:itcase/app/global_widgets/platform_implementation/platfrom_material.dart';
import 'package:itcase/app/services/firebase_messaging_service.dart';
import 'package:itcase/app/services/notification_service.dart';

import 'app/routes/app_pages.dart';
import 'app/services/auth_service.dart';
import 'app/services/global_service.dart';
import 'app/services/settings_service.dart';
import 'app/services/translation_service.dart';

void initServices() async {
  Get.log('starting services ...');
  await Get.putAsync(() => TranslationService().init());
  await Get.putAsync(() => GlobalService().init());
  await Get.putAsync(() => AuthService().init());
  await Get.putAsync(() => SettingsService().init());
  await Get.putAsync(() => FireBaseService().init());
  await Get.putAsync(() => NotificationService().init());
  await GetStorage.init();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  FirebaseMessaging.onBackgroundMessage(FireBaseService.backGroundTasks);

  runApp(
    GetMaterialApp(
      title: Get.find<SettingsService>().setting.value.appName,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      localizationsDelegates: [GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
      supportedLocales: Get.find<TranslationService>().supportedLocales(),
      translationsKeys: Get.find<TranslationService>().translations,
      locale: Get.find<SettingsService>().getLocale(),
      fallbackLocale: Get.find<TranslationService>().fallbackLocale,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.cupertino,
      themeMode: Get.find<SettingsService>().getThemeMode(),
      theme: Get.find<SettingsService>()
          .getLightTheme(), //Get.find<SettingsService>().getLightTheme.value,
      darkTheme: Get.find<SettingsService>().getDarkTheme(),
    ),
  );
}
