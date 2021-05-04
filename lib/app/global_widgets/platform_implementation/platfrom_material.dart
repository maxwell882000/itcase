import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:itcase/app/global_widgets/abstract/platform_widget.dart';
import 'package:itcase/app/routes/app_pages.dart';
import 'package:itcase/app/services/settings_service.dart';
import 'package:itcase/app/services/translation_service.dart';

class PlatformMaterial  extends PlatformWidget<GetCupertinoApp, GetMaterialApp> {



  @override
  GetCupertinoApp createIosWidget(BuildContext context) => new GetCupertinoApp(
    title: Get.find<SettingsService>().setting.value.appName,
    initialRoute: AppPages.INITIAL,
    getPages: AppPages.routes,
    localizationsDelegates: [GlobalMaterialLocalizations.delegate],
    supportedLocales: Get.find<TranslationService>().supportedLocales(),
    translationsKeys: Get.find<TranslationService>().translations,
    locale: Get.find<SettingsService>().getLocale(),
    fallbackLocale: Get.find<TranslationService>().fallbackLocale,
    debugShowCheckedModeBanner: false,
    defaultTransition: Transition.cupertino,
    theme: Get.find<SettingsService>()
        .getThemeIos(), //Get.find<SettingsService>().getLightTheme.value,

  );

  @override
  GetMaterialApp createAndroidWidget(BuildContext context) =>
      new GetMaterialApp(
        title: Get.find<SettingsService>().setting.value.appName,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        localizationsDelegates: [GlobalMaterialLocalizations.delegate],
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
      );
}