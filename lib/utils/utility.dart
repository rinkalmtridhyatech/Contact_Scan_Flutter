import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:contact_scan/routes/app_pages.dart';
import 'package:contact_scan/utils/app_dimensions.dart';
import 'package:contact_scan/utils/storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_constants.dart';
import 'color_constants.dart';

class Utility {
  static Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      if (kDebugMode) {
        print('Internet mode : mobile');
      }
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      if (kDebugMode) {
        print('Internet mode : wifi');
      }
      return true;
    }
    return false;
  }

  static Widget? hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    return null;
  }

  static setAPIKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConstants.apiKey, key);
  }

  static Future<String> getUserAPIKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userAPIKey = prefs.getString(AppConstants.apiKey);
    return userAPIKey!;
  }

  static setEventId(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConstants.eventIdNumber, id);
  }

  static Future<String> getEventId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? eventId = prefs.getString(AppConstants.eventIdNumber);
    return eventId ?? "";
  }

  static setEventName(String eventName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConstants.eventName, eventName);
  }

  static Future<String> getEventName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? eventName = prefs.getString(AppConstants.eventName);
    return eventName ?? "";
  }

  static checkEventDetailsFetched(bool isDataFetched) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(AppConstants.eventDataFetched, isDataFetched);
  }

  static Future<bool> isDataFetched() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isDataFetched = prefs.getBool(AppConstants.eventDataFetched);
    return isDataFetched ?? false;
  }

  void snackBar(String msg, BuildContext context) {
    var snackBar = SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Widget buildProgressIndicator() {
    return Container(
      height: screenHeight,
      color: AppColors.black.withOpacity(0.4),
      child: const Center(
        child: CircularProgressIndicator(
          backgroundColor: AppColors.blue,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
        ),
      ),
    );
  }

  static void getSessionExpiredDialog() {
    Platform.isAndroid
        ? Get.dialog(
            AlertDialog(
              title: Text(AppConstants.sessionExpired),
              actions: [
                TextButton(
                  child: Text(AppConstants.ok),
                  onPressed: () {
                    Get.back();
                    StorageService().clearAllData();
                    Get.offNamedUntil(Routes.auth, (route) => false);
                  },
                ),
              ],
            ),
            barrierDismissible: false,
          )
        : Get.dialog(
            CupertinoAlertDialog(
              title: Text(AppConstants.sessionExpired),
              actions: [
                CupertinoDialogAction(
                  child: Text(AppConstants.ok),
                  onPressed: () {
                    Get.back();
                    StorageService().clearAllData();
                    Get.offNamedUntil(Routes.auth, (route) => false);
                  },
                )
              ],
            ),
            barrierDismissible: false,
          );
  }
}
