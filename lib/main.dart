import 'dart:async';

import 'package:contact_scan/routes/app_pages.dart';
import 'package:contact_scan/utils/app_constants.dart';
import 'package:contact_scan/utils/app_fonts.dart';
import 'package:contact_scan/utils/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'utils/dependency_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: AppFonts.helveticaNeue,
        primarySwatch: AppColors.appColor,
      ),
      initialRoute: Routes.splash,
      getPages: AppPages.routes,
      title: AppConstants.appName,
    );
  }
}
