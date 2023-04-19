import 'dart:async';
import 'dart:io';

import 'package:contact_scan/utils/utility.dart';
import 'package:contact_scan/view/components/base_controller.dart';
import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../model/attendee_details_response.dart';
import '../../../routes/app_pages.dart';

class ListExportController extends BaseController {
  final formKey = GlobalKey<FormState>();
  late TextEditingController recipientController;
  dynamic argumentData = Get.arguments;
  var contactList = <AttendeeDetailsResponse>[].obs;
  var attachments = [].obs;
  var eventName = "";
  bool isHTML = false;

  @override
  void onInit() {
    recipientController = TextEditingController();
    super.onInit();
  }

  Future<void> validate() async {
    final isValid = formKey.currentState!.validate();
    Get.focusScope!.unfocus();
    if (argumentData['contactList'] != null) {
      contactList.value = argumentData['contactList'] ?? [];
    }
    eventName = await Utility.getEventName();
    debugPrint("contactList length: " + contactList.length.toString());

    if (isValid) {
      Utility.isConnected().then((internet) {
        if (internet) {
          getCsvExported(contactList);
        } else {
          Get.toNamed(Routes.errorScanResultScreen, arguments: {
            'isEventNotAuthorized': false,
            'isForEmail': true,
            'isForWrongScan': false
          });
        }
      });
    }
  }

  getCsvExported(List<AttendeeDetailsResponse> contactList) async {
    List<List<dynamic>> rows = <List<dynamic>>[];
    List<dynamic> nameRow = [];
    nameRow.add("Attendee ID");
    nameRow.add("First Name");
    nameRow.add("Last Name");
    nameRow.add("Mobile");
    nameRow.add("Phone");
    nameRow.add("Email");
    nameRow.add("Company");
    nameRow.add("Position");
    nameRow.add("City");
    nameRow.add("State");
    nameRow.add("Zip");
    nameRow.add("Country");
    nameRow.add("Notes");
    rows.add(nameRow);
    for (int i = 0; i < contactList.length; i++) {
      List<dynamic> row = [];
      row.add(contactList[i].attendeeID);
      row.add(contactList[i].userFirst!.replaceAll("’", "\’"));
      row.add(contactList[i].userLast!.replaceAll("’", "\’"));
      row.add(contactList[i].userMobile);
      row.add(contactList[i].userPhone);
      row.add(contactList[i].userEmail);
      row.add(contactList[i].userCompany!.replaceAll("’", "\’"));
      row.add(contactList[i].userPosition!.replaceAll("’", "\’"));
      row.add(contactList[i].userCity!.replaceAll("’", "\’"));
      row.add(contactList[i].userState);
      row.add(contactList[i].userZip);
      row.add(contactList[i].userCountry);
      row.add(contactList[i].notes?.replaceAll("’", "\’") ?? "");
      rows.add(row);
    }
    debugPrint("Data Exported " + rows.toString());
    if (await Permission.storage.request().isGranted) {
      //store file in documents folder
      Directory? directory = Platform.isAndroid
          ? await getExternalStorageDirectory() //FOR ANDROID
          : await getApplicationSupportDirectory();
      String dir = (directory)!.path + "/contacts.csv";
      String file = dir;

      File f = File(file);
      // convert rows to String and write as csv file
      String csv = const ListToCsvConverter().convert(rows);
      f.writeAsString(csv);
      attachments.add(f.path);
      send();
      attachments.clear();
      // ShareExtend.share(f.path, "CsvFile");
    } else {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
    }
  }

  Future<void> send() async {
    final Email email = Email(
      subject: "Contacts from $eventName",
      recipients: [recipientController.text],
      attachmentPaths: attachments.cast<String>(),
      isHTML: isHTML,
    );

    String platformResponse;
    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }
    debugPrint("Error" + platformResponse);
  }

  @override
  void dispose() {
    recipientController.dispose();
    super.dispose();
  }
}
