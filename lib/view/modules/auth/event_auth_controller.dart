import 'dart:convert';

import 'package:contact_scan/model/event_auth_model.dart';
import 'package:contact_scan/model/event_list_model.dart';
import 'package:contact_scan/service/remote_services.dart';
import 'package:contact_scan/service/web_service.dart';
import 'package:contact_scan/utils/app_constants.dart';
import 'package:contact_scan/utils/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_pages.dart';
import '../../components/base_controller.dart';

class EventAuthController extends BaseController {
  final formKey = GlobalKey<FormState>();
  var hostNameList = [].obs;
  List<EventListModel> modelList = <EventListModel>[].obs;
  late EventAuthModel eventAuthModel;
  late TextEditingController eventIdController;
  late TextEditingController authCodeController;
  var dropDownValue = "".obs;
  var isFromDrawer = "";
  late BuildContext context;
  var _storeEventData;
  var _eventIdNumber = "";
  var _authCode = "";
  var _dropdownValue = "";

  @override
  void onInit() {
    _storeEventData = Get.find<SharedPreferences>();
    Utility.isConnected().then((internet) {
      if (internet) {
        if (isFromDrawer.toString() != "true") {
          fetchEventHosts();
        } else {}
      }
    });
    getSavedData();
    eventIdController = TextEditingController();
    authCodeController = TextEditingController();
    eventAuthModel = EventAuthModel();
    isFromDrawer = Get.parameters['isFromDrawer'].toString();
    if (isFromDrawer == "true") {
      eventIdController.text = _eventIdNumber;
      authCodeController.text = _authCode;
    } else {
      eventIdController.text = "";
      authCodeController.text = "";
    }
    super.onInit();
  }

  void validate() {
    final isValid = formKey.currentState!.validate();
    Get.focusScope!.unfocus();

    if (isValid) {
      Utility.isConnected().then((internet) {
        if (internet) {
          fetchAuthoriseApi();
        } else {
          Get.snackbar(
            'No Internet connection',
            'Please connect to internet and try again!',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      });
    }
  }

  void fetchEventHosts() async {
    try {
      isLoading(true);
      var events = await RemoteServices.fetchEventHosts();
      if (events != null) {
        for (int i = 0; i < events.length; i++) {
          modelList.add(EventListModel(
              hostID: events[i]["hostID"],
              hostName: events[i]["hostName"],
              apiEndpoint: events[i]["apiEndpoint"]));
        }
        for (int i = 0; i < modelList.length; i++) {
          hostNameList.add(modelList[i].hostName);
          hostNameList.sort((a, b) => a.compareTo(b));
        }
        dropDownValue.value = hostNameList.first;
      }
    } finally {
      isLoading(false);
    }
  }

  fetchAuthoriseApi() async {
    isLoading(true);
    for (int i = 0; i < modelList.length; i++) {
      if (dropDownValue.value.toString() == modelList[i].hostName) {
        AppConstants.baseApi = modelList[i].apiEndpoint.toString();
      }
    }
    final queryParameter = {
      "eventID": eventIdController.value.text.toString(),
      "authCode": authCodeController.value.text.toString(),
      "app": "cs"
    };
    Utility.setEventId(eventIdController.value.text.toString());
    Utility.checkEventDetailsFetched(false);
    final jsonString = json.encode(queryParameter);
    debugPrint("-----authCredentialsMap--------" + queryParameter.toString());
    Webservice().loadPost(authoriseUsers, jsonString).then(
          (model) => {},
        );
  }

  Resource<EventAuthModel> get authoriseUsers {
    return Resource(
        url: AppConstants.baseApi + "public" + AppConstants.authenticate,
        parse: (response) {
          final result = json.decode(response.body);
          debugPrint(
              AppConstants.baseApi + "public" + AppConstants.authenticate);
          debugPrint(".......eventAuthorise........" + result.toString());
          if (result.toString().contains("apiKey")) {
            isLoading(false);
            EventAuthModel model =
                EventAuthModel.fromJson(json.decode(response.body));
            eventAuthModel = model;
            saveInPref();
            Utility.setAPIKey(eventAuthModel.apiKey.toString());
            Get.offAndToNamed(Routes.home);
            return eventAuthModel;
          } else {
            isLoading(false);
            Get.snackbar(
              AppConstants.authDenied,
              AppConstants.userAuthFailed,
              messageText: Text(
                AppConstants.userAuthFailed,
                style: TextStyle(fontSize: 14),
              ),
              snackPosition: SnackPosition.BOTTOM,
              margin: const EdgeInsets.symmetric(vertical: 12,horizontal:6),
            );
            return EventAuthModel();
          }
        });
  }

  saveInPref() async {
    var date = DateTime.now();
    debugPrint('---------------------' + date.toIso8601String());
    await _storeEventData.setString(
        AppConstants.currentTime, date.toIso8601String());
    await _storeEventData.setString(AppConstants.baseUrl, AppConstants.baseApi);
    await _storeEventData.setString(
        AppConstants.apiKey, eventAuthModel.apiKey.toString());

    String modelString = jsonEncode(eventAuthModel);
    await _storeEventData.setString(AppConstants.eventAuthData, modelString);

    await _storeEventData.setString(
        AppConstants.eventIdNumber, eventIdController.value.text.toString());

    await _storeEventData.setString(AppConstants.eventAuthPassword,
        authCodeController.value.text.toString());

    await _storeEventData.setString(
        AppConstants.dropdownValue, dropDownValue.value.toString());

    await _storeEventData.setBool(AppConstants.showInstruction, true);
  }

  getSavedData() async {
    if (_storeEventData.getString(AppConstants.eventIdNumber) != null &&
        _storeEventData.getString(AppConstants.eventAuthPassword) != null) {
      _eventIdNumber =
          await _storeEventData.getString(AppConstants.eventIdNumber);
      _authCode =
          await _storeEventData.getString(AppConstants.eventAuthPassword);
      _dropdownValue =
          await _storeEventData.getString(AppConstants.dropdownValue);
      eventIdController.text = _eventIdNumber;
      authCodeController.text = _authCode;
      dropDownValue.value = _dropdownValue;
    }
  }
}
