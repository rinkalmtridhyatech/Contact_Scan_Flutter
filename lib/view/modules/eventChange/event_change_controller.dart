import 'package:contact_scan/utils/storage_service.dart';
import 'package:contact_scan/view/components/base_controller.dart';
import 'package:get/get.dart';

class EventChangeController extends BaseController {
  dynamic argumentData = Get.arguments;
  String isFromScan = '';

  @override
  void onInit() {
    if (argumentData['isFromScan'] != null) {
      isFromScan = argumentData['isFromScan'] ?? '';
    }
    super.onInit();
  }

  void clearAllPreference() {
    StorageService().clearAllData();
  }
}
