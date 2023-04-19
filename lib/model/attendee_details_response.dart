class AttendeeDetailsResponse {
  int? id;
  String? attendeeID;
  String? userGUID;
  String? userFirst;
  String? userLast;
  String? userMobile;
  String? userPhone;
  String? userWebsite;
  String? userEmail;
  String? userAddress;
  String? userCity;
  String? userZip;
  String? userCountry;
  String? userPosition;
  String? userState;
  String? userCompany;
  String? timeStampUserAdded;
  String? notes;
  dynamic eventId;
  String? eventName;

  AttendeeDetailsResponse({
    this.id,
    this.attendeeID,
    this.userGUID,
    this.userFirst,
    this.userLast,
    this.userMobile,
    this.userPhone,
    this.userWebsite,
    this.userEmail,
    this.userAddress,
    this.userCity,
    this.userZip,
    this.userState,
    this.userCountry,
    this.userPosition,
    this.userCompany,
    this.timeStampUserAdded,
    this.notes,
    this.eventId,
    this.eventName,
  });

  AttendeeDetailsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attendeeID = json['attendeeID'];
    userAddress = json['userAddress'] ?? '';
    userCompany = json['userCompany'] ?? '';
    userCity = json['userCity'] ?? '';
    userCountry = json['userCountry'] ?? '';
    userEmail = json['userEmail'] ?? '';
    userFirst = json['userFirst'] ?? '';
    userGUID = json['userGUID'];
    userLast = json['userLast'] ?? '';
    userMobile = json['userMobile'] ?? '';
    userPhone = json['userPhone'] ?? '';
    userPosition = json['userPosition'] ?? '';
    userState = json['userState'] ?? '';
    userWebsite = json['userWebsite'] ?? '';
    userZip = json['userZip'] ?? '';
    timeStampUserAdded = json['timeStampUserAdded'];
    notes = json['notes'] ?? '';
    eventId = json['eventID'] ?? '';
    eventName = json['title'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['attendeeID'] = this.attendeeID;
    data['userAddress'] = this.userAddress;
    data['userCompany'] = this.userCompany;
    data['userCity'] = this.userCity;
    data['userCountry'] = this.userCountry;
    data['userEmail'] = this.userEmail;
    data['userFirst'] = this.userFirst;
    data['userGUID'] = this.userGUID;
    data['userLast'] = this.userLast;
    data['userMobile'] = this.userMobile;
    data['userPhone'] = this.userPhone;
    data['userPosition'] = this.userPosition;
    data['userState'] = this.userState;
    data['userWebsite'] = this.userWebsite;
    data['userZip'] = this.userZip;
    data['timeStampUserAdded'] = this.timeStampUserAdded;
    data['notes'] = this.notes;
    data['eventID'] = this.eventId;
    data['title'] = this.eventName;
    return data;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'attendeeID': attendeeID ?? "",
      'userGUID': userGUID ?? "",
      'userFirst': userFirst ?? "",
      'userLast': userLast ?? "",
      'userMobile': userMobile ?? "",
      'userPhone': userPhone ?? "",
      'userWebsite': userWebsite ?? "",
      'userEmail': userEmail ?? "",
      'userAddress': userAddress ?? "",
      'userCity': userCity ?? "",
      'userZip': userZip ?? "",
      'userState': userState ?? "",
      'userCountry': userCountry ?? "",
      'userPosition': userPosition ?? "",
      'userCompany': userCompany ?? "",
      'timeStampUserAdded': timeStampUserAdded ?? "",
      'notes': notes ?? "",
      'eventID': eventId ?? "",
    };

    if (id != null) map['id'] = id;
    return map;
  }
}
