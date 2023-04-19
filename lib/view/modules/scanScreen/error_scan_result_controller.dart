import 'package:contact_scan/model/attendee_details_response.dart';
import 'package:contact_scan/view/components/base_controller.dart';
import 'package:get/get.dart';

class ErrorScanResultController extends BaseController {
  dynamic argumentData = Get.arguments;
  var data = AttendeeDetailsResponse();
  var isEventNotAuthorized = false.obs;
  var isForEmail = false.obs;
  var isForWrongScan = false.obs;

  @override
  void onInit() {
    if (argumentData['isEventNotAuthorized'] != null) {
      isEventNotAuthorized.value =
          argumentData['isEventNotAuthorized '] ?? false;
    }
    if (argumentData['isForEmail'] != null) {
      isForEmail.value = argumentData['isForEmail'] ?? false;
    }
    if (argumentData['isForWrongScan'] != null) {
      isForWrongScan.value = argumentData['isForWrongScan'] ?? false;
    }
    super.onInit();
  }
}
