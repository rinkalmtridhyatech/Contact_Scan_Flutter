import 'package:contact_scan/utils/storage_service.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static Future<void> init() async {
    await Get.putAsync(() => StorageService().init());
  }
}
