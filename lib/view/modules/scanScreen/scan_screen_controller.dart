import 'dart:convert';

import 'package:contact_scan/routes/app_pages.dart';
import 'package:contact_scan/service/web_service.dart';
import 'package:contact_scan/utils/utility.dart';
import 'package:contact_scan/view/components/base_controller.dart';
import 'package:contact_scan/view/modules/contactList/contact_list_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../model/attendee_details_response.dart';
import '../../../model/select_scope_model.dart';
import '../../../utils/app_constants.dart';

class ScanScreenController extends BaseController {
  final ContactListController _contactListController =
      Get.put(ContactListController());

  var resultString = "".obs;
  var attendeeID = "".obs;
  var eventID = "".obs;
  var eventName = "".obs;
  var eventIdLogged = "".obs;
  var isScannedData = false.obs;
  AttendeeDetailsResponse attendeeDetailsResponse = AttendeeDetailsResponse();
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  bool isFirstTimeCall = false;

  @override
  void onInit() {
    getEventName();
    super.onInit();
  }

  Future<void> getEventName() async {
    await Utility.isDataFetched()
        ? eventName.value = await Utility.getEventName()
        : Utility.isConnected().then((internet) {
            if (internet) {
              fetchEventDetailsApi();
              Utility.checkEventDetailsFetched(true);
            }
          });
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (isFirstTimeCall == false) {
        isFirstTimeCall = true;
        result = scanData;
        if (result != null && result.toString().isNotEmpty) {
          isScannedData.value = true;
        }
        if (kDebugMode) {
          print("QR Scanned Data: ======>" + result!.code.toString());
        }
        var uri = Uri.dataFromString(result!.code.toString());
        controller.dispose();
        if (uri.queryParameters['cid'] != null &&
            uri.queryParameters['eid'] != null) {
          attendeeID.value = uri.queryParameters['cid']!;
          eventID.value = uri.queryParameters['eid']!;
          if (kDebugMode) {
            print("Attendee ID====> " + attendeeID.value);
            print("Event ID====> " + eventID.value);
          }
          Utility.isConnected().then((internet) {
            if (internet) {
              fetchAttendeeDetailsApi();
            } else {
              Get.snackbar(
                'No Internet connection',
                'Please connect to internet and try again!',
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          });
        } else {
          isScannedData.value = false;
          isFirstTimeCall == false;
          Get.toNamed(Routes.errorScanResultScreen, arguments: {
            'isEventNotAuthorized': false,
            'isForEmail': false,
            'isForWrongScan': true
          })?.then((value) {
            controller.resumeCamera();
          });
        }
      }
    });
  }

  void onPermissionSet(QRViewController ctrl, bool p) {
    debugPrint('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      Get.snackbar(
        AppConstants.somethingWentWrong,
        AppConstants.userPermissionFailed,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  fetchAttendeeDetailsApi() async {
    Webservice().loadGetWithHeader(attendeeDetails).then(
          (model) => {
            isScannedData.value = false,
          },
        );
  }

  Resource<AttendeeDetailsResponse> get attendeeDetails {
    return Resource(
        url: AppConstants.baseApi + "attendee/" + attendeeID.value,
        parse: (response) {
          isScannedData.value = false;
          final result = json.decode(response.body);
          debugPrint(AppConstants.baseApi + "attendee/" + attendeeID.value);
          debugPrint(".......attendeeDetails........" + result.toString());
          if (response.statusCode == 200) {
            isFirstTimeCall = false;
            Get.toNamed(Routes.contactList)?.then((value) {
              controller?.resumeCamera();
            });
            if (!result.toString().contains('error')) {
              AttendeeDetailsResponse model = AttendeeDetailsResponse.fromJson(
                  json.decode(response.body)[0]);
              attendeeDetailsResponse = model;
              _contactListController.getId(attendeeID.value, eventID.value);
              _contactListController.addData(attendeeDetailsResponse);
              debugPrint("AttendeeDetailsResponse ==================> " +
                  attendeeDetailsResponse.toString());
              return attendeeDetailsResponse;
            } else {
              isFirstTimeCall = false;
              String error = result["error"];
              Get.snackbar(
                AppConstants.failed,
                error,
                snackPosition: SnackPosition.BOTTOM,
              );
              return AttendeeDetailsResponse();
            }
          } else {
            isFirstTimeCall = false;
            Get.snackbar(
              AppConstants.failed,
              'Something went wrong',
              snackPosition: SnackPosition.BOTTOM,
            );
            return AttendeeDetailsResponse();
          }
        });
  }

  fetchEventDetailsApi() async {
    eventIdLogged.value = await Utility.getEventId();
    Webservice().loadGetWithHeader(eventDetails).then(
          (model) => {},
        );
  }

  Resource<EventDetailsModel> get eventDetails {
    return Resource(
        url: AppConstants.baseApi + "event/" + eventIdLogged.value,
        parse: (response) {
          final result = json.decode(response.body);
          debugPrint(
              AppConstants.baseApi + "event/" + eventIdLogged.value.toString());
          debugPrint(".......Event Details........" + result.toString());
          if (response.statusCode == 200) {
            EventDetailsModel model =
                EventDetailsModel.fromJson(json.decode(response.body)[0]);
            eventName.value = model.title ?? "";
            Utility.setEventName(eventName.value);
            return model;
          } else {
            return EventDetailsModel();
          }
        });
  }

  @override
  void dispose() {
    isFirstTimeCall = false;
    controller?.stopCamera();
    controller?.dispose();
    super.dispose();
  }
}
