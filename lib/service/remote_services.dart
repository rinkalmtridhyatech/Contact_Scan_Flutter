import 'dart:convert';

import 'package:contact_scan/model/event_list_model.dart';
import 'package:contact_scan/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  static var client = http.Client();

  static Future<List?> fetchEventHosts() async {
    var response = await client.get(Uri.parse(AppConstants.getEvents));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      debugPrint("Hosts=======>" + jsonString);
      List jsonList = json.decode(jsonString) as List;
      List<EventListModel> eventList = [];
      for (int i = 0; i < jsonList.length; i++) {
        eventList.add(EventListModel(
            hostID: jsonList[i]["hostID"],
            hostName: jsonList[i]["hostName"],
            apiEndpoint: jsonList[i]["apiEndpoint"]));
      }
      return jsonList;
    } else {
      //show error message
      return null;
    }
  }
}
