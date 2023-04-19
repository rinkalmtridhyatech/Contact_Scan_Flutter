import 'package:contact_scan/routes/app_pages.dart';
import 'package:contact_scan/view/components/base_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../model/attendee_details_response.dart';
import '../../../service/sql_service.dart';
import '../../../utils/utility.dart';

class ContactListController extends BaseController {
  var searchTextEditingController = TextEditingController();
  var onTextChange = false.obs;
  var contactList = <AttendeeDetailsResponse>[].obs;
  var attendeeId = "".obs;
  var eventId = "".obs;
  var eventIdLogged = "";
  var eventName = "";
  Rx<List<AttendeeDetailsResponse>> filteredContact =
      Rx<List<AttendeeDetailsResponse>>([]);

  @override
  void onInit() {
    super.onInit();
    getData();
    filteredContact.value = contactList;
  }

  void getId(String attendeeID, String eventID) {
    attendeeId.value = attendeeID;
    eventId.value = eventID;
  }

  Future<void> getData() async {
    eventIdLogged = await Utility.getEventId();
    if (await SQLService.instance.tableIsEmpty()) {
      contactList.value = [];
    } else {
      SQLService.instance.queryAllRows(eventIdLogged).then((value) {
        for (var element in value) {
          contactList.add(AttendeeDetailsResponse(
            id: element['id'],
            attendeeID: element['attendeeID'],
            userGUID: element['userGUID'],
            userFirst: element['userFirst'],
            userLast: element['userLast'],
            userMobile: element['userMobile'],
            userPhone: element['userPhone'],
            userWebsite: element['userWebsite'],
            userEmail: element['userEmail'],
            userAddress: element['userAddress'],
            userCity: element['userCity'],
            userZip: element['userZip'],
            userState: element['userState'],
            userCountry: element['userCountry'],
            userPosition: element['userPosition'],
            userCompany: element['userCompany'],
            timeStampUserAdded: element['timeStampUserAdded'],
            notes: element['notes'],
            eventId: element['eventID'],
          ));
        }
      });
    }
  }

  void filterContact(String contactName) {
    List<AttendeeDetailsResponse> results = [];
    if (contactName.isEmpty) {
      results = contactList;
    } else {
      results = contactList
          .where((element) =>
              element.userFirst
                  .toString()
                  .toLowerCase()
                  .contains(contactName.toLowerCase()) ||
              element.userLast
                  .toString()
                  .toLowerCase()
                  .contains(contactName.toLowerCase()) ||
              element.userPosition
                  .toString()
                  .toLowerCase()
                  .contains(contactName.toLowerCase()) ||
              element.userCompany
                  .toString()
                  .toLowerCase()
                  .contains(contactName.toLowerCase()))
          .toList();
    }
    filteredContact.value = results;
  }

  void addData(AttendeeDetailsResponse contactListData) async {
    eventIdLogged = await Utility.getEventId();
    Utility.setEventName(contactListData.eventName.toString());
    try {
      if (eventIdLogged == eventId.value) {
        if (await SQLService.instance
            .isAlreadySaved(contactListData.attendeeID!)) {
          debugPrint("Data Updated Having Id = " + attendeeId.toString());
          await SQLService.instance.update(AttendeeDetailsResponse(
            attendeeID: contactListData.attendeeID,
            userGUID: contactListData.userGUID,
            userFirst: contactListData.userFirst,
            userLast: contactListData.userLast,
            userMobile: contactListData.userMobile,
            userPhone: contactListData.userPhone,
            userWebsite: contactListData.userWebsite,
            userEmail: contactListData.userEmail,
            userAddress: contactListData.userAddress,
            userCity: contactListData.userCity,
            userZip: contactListData.userZip,
            userState: contactListData.userState,
            userCountry: contactListData.userCountry,
            userPosition: contactListData.userPosition,
            userCompany: contactListData.userCompany,
            timeStampUserAdded: DateTime.now().toString(),
            eventId: contactListData.eventId.toString(),
          ));
          debugPrint("Data Updated Having Id = " +
              contactListData.userCompany.toString());
          var index = contactList.indexWhere(
              (element) => element.attendeeID == contactListData.attendeeID);
          contactList[index] = contactListData;
        } else {
          debugPrint("Data Added Having Id = " + attendeeId.toString());
          contactList.insert(
              0,
              AttendeeDetailsResponse(
                attendeeID: contactListData.attendeeID,
                userGUID: contactListData.userGUID,
                userFirst: contactListData.userFirst,
                userLast: contactListData.userLast,
                userMobile: contactListData.userMobile,
                userPhone: contactListData.userPhone,
                userWebsite: contactListData.userWebsite,
                userEmail: contactListData.userEmail,
                userAddress: contactListData.userAddress,
                userCity: contactListData.userCity,
                userZip: contactListData.userZip,
                userState: contactListData.userState,
                userCountry: contactListData.userCountry,
                userPosition: contactListData.userPosition,
                userCompany: contactListData.userCompany,
                timeStampUserAdded: DateTime.now().toString(),
                eventId: contactListData.eventId.toString(),
              ));
          await SQLService.instance.insert(AttendeeDetailsResponse(
            attendeeID: contactListData.attendeeID,
            userGUID: contactListData.userGUID,
            userFirst: contactListData.userFirst,
            userLast: contactListData.userLast,
            userMobile: contactListData.userMobile,
            userPhone: contactListData.userPhone,
            userWebsite: contactListData.userWebsite,
            userEmail: contactListData.userEmail,
            userAddress: contactListData.userAddress,
            userCity: contactListData.userCity,
            userZip: contactListData.userZip,
            userState: contactListData.userState,
            userCountry: contactListData.userCountry,
            userPosition: contactListData.userPosition,
            userCompany: contactListData.userCompany,
            timeStampUserAdded: DateTime.now().toString(),
            eventId: contactListData.eventId.toString(),
          ));
        }
        filteredContact.value = contactList;
        update();
      } else {
        Get.toNamed(Routes.errorScanResultScreen, arguments: {
          'isEventNotAuthorized': false,
          'isForEmail': false,
          'isForWrongScan': true
        });
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }

  void deleteContact(String id) async {
    debugPrint("Data Deleted");
    await SQLService.instance.delete(id);
    contactList.removeWhere((element) => element.userGUID == id);
    update();
  }
}
