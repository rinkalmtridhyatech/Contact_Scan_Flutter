import 'package:contact_scan/model/attendee_details_response.dart';
import 'package:contact_scan/view/components/base_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ContactOptionsController extends BaseController {
  dynamic argumentData = Get.arguments;
  var data = AttendeeDetailsResponse();
  var mobileNumber = "";
  var emailId = "";
  var userName = "";
  var userCompany = "";
  var userPosition = "";

  @override
  void onInit() {
    super.onInit();
    if (argumentData['contactData'] != null) {
      data = argumentData['contactData'] ?? AttendeeDetailsResponse();
      debugPrint("contactMobile : " + data.userMobile.toString());
      debugPrint("contactPhone : " + data.userPhone.toString());
      if (data.userMobile.toString().isNotEmpty &&
          data.userPhone.toString().isNotEmpty) {
        mobileNumber = data.userMobile.toString();
      } else if (data.userMobile.toString().isNotEmpty) {
        mobileNumber = data.userMobile.toString();
      } else {
        mobileNumber = data.userPhone.toString();
      }
      userName = data.userFirst.toString()+" "+ data.userLast.toString();
      userCompany = data.userCompany.toString();
      userPosition = data.userPosition.toString();
    }
      debugPrint("contactEmail : " + data.userEmail.toString());
      emailId = data.userEmail.toString();
    }
}
