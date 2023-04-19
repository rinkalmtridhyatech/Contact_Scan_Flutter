class EventListModel {
  String? apiEndpoint;
  String? hostName;
  String? hostID;

  EventListModel({this.apiEndpoint, this.hostName, this.hostID});

  EventListModel.fromJson(Map<String, dynamic> json) {
    apiEndpoint = json['apiEndpoint'];
    hostName = json['hostName'];
    hostID = json['hostID'];
  }

// return list;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apiEndpoint'] = apiEndpoint;
    data['hostName'] = hostName;
    data['hostID'] = hostID;
    return data;
  }
}
