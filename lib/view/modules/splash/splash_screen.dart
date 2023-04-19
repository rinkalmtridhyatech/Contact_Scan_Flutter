import 'package:contact_scan/utils/app_dimensions.dart';
import 'package:contact_scan/utils/image_paths.dart';
import 'package:contact_scan/view/modules/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends GetView<SharedPreferences> {
  final SplashController _splashControllerController =
      Get.put(SplashController());

  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color:Colors.black,
        height: screenHeight,
        width: screenWidth,
        child: Image.asset(
          ImagePath.splashBg,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
