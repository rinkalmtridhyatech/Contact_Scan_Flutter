import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_constants.dart';

class StorageService extends GetxService {
  Future<SharedPreferences> init() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> clearApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(AppConstants.apiKey);
  }

  Future<void> clearEventData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(AppConstants.eventAuthData);
  }

  Future<void> clearEventCred() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(AppConstants.eventIdNumber);
    preferences.remove(AppConstants.eventAuthPassword);
  }

  Future<void> clearAllData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

}
