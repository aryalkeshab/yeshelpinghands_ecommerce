import 'dart:io';

// import 'package:firebase_core/firebase_core.dart';
import 'package:yeshelpinghand/core/presentation/resources/app_theme.dart';
import 'package:yeshelpinghand/core/presentation/routes/app_pages.dart';
import 'package:yeshelpinghand/core/presentation/translation/language.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import 'core/utils/constants.dart';

Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: kAppName,
      debugShowCheckedModeBanner: false,
      translations: Localization(),
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: (context, child) {
        final previewChild = DevicePreview.appBuilder(context, child);
        // final mediaQueryData = MediaQuery.of(context).copyWith(
        //   gestureSettings: const DeviceGestureSettings(touchSlop: kTouchSlop),
        // );
        return previewChild;

        // MediaQuery(
        //   // data: mediaQueryData,

        //   child: previewChild,
        // );
      },
      fallbackLocale: const Locale('en', 'US'),
      supportedLocales: const [Locale('en', 'US')],
      themeMode: ThemeMode.light,
      theme: AppThemes.lightThemeData,
      darkTheme: AppThemes.darkThemeData,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
