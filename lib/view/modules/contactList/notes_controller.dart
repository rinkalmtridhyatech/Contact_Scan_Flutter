import 'package:contact_scan/model/attendee_details_response.dart';
import 'package:contact_scan/service/sql_service.dart';
import 'package:contact_scan/view/components/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotesController extends BaseController {
  dynamic argumentData = Get.arguments;
  TextEditingController notesTextEditingController = TextEditingController();
  var data = AttendeeDetailsResponse();
  var userGUID = "";
  var userName = "";
  var userCompany = "";
  var userPosition = "";

  @override
  void onInit() {
    super.onInit();
    if (argumentData['contactData'] != null) {
      data = argumentData['contactData'] ?? AttendeeDetailsResponse();
      userName = data.userFirst.toString() + " " + data.userLast.toString();
      userCompany = data.userCompany.toString();
      userPosition = data.userPosition.toString();
    }
    debugPrint("Notes: " + data.notes.toString());
    notesTextEditingController.text = data.notes ?? "";
  }

  void updateNotes(String data, String id) async {
    debugPrint("Data Updated");
    await SQLService.instance.updateNotes(data, id);
    update();
  }
}
