class EventDetailsModel {
  String? affiliateGUID;
  String? eventGUID;
  String? endsTime;
  String? startsDate;
  String? eventContact;
  String? eventEmail;
  String? endsDate;
  dynamic? eventID;
  dynamic? indoorEvent;
  String? eventPhone;
  String? title;
  String? firstPublished;
  dynamic? guestType;
  dynamic? maxGuests;
  String? registrationEndTime;
  String? registrationEndDate;
  String? registrationStartTime;
  String? registrationStartDate;
  String? startsTime;
  dynamic? userID;
  String? volunteerEnd;
  String? volunteerStart;
  dynamic? isPublished;
  String? timeZone;
  String? eventType;
  String? eventTypeCategory;
  String? eventTypeSubCategory;
  String? venueCity;
  String? venueCountry;
  double? venueLat;
  double? venueLong;
  String? venueName;
  String? venueRegion;
  String? venueAddress;
  String? currency;
  String? lastUpdated;
  List<Profiles>? profiles;
  String? registrationStartDateISO;
  String? registrationEndDateISO;
  String? startsDateISO;
  String? endsDateISO;
  List<Items>? items;
  dynamic? contestantReg;

  EventDetailsModel(
      {this.affiliateGUID,
        this.eventGUID,
        this.endsTime,
        this.startsDate,
        this.eventContact,
        this.eventEmail,
        this.endsDate,
        this.eventID,
        this.indoorEvent,
        this.eventPhone,
        this.title,
        this.firstPublished,
        this.guestType,
        this.maxGuests,
        this.registrationEndTime,
        this.registrationEndDate,
        this.registrationStartTime,
        this.registrationStartDate,
        this.startsTime,
        this.userID,
        this.volunteerEnd,
        this.volunteerStart,
        this.isPublished,
        this.timeZone,
        this.eventType,
        this.eventTypeCategory,
        this.eventTypeSubCategory,
        this.venueCity,
        this.venueCountry,
        this.venueLat,
        this.venueLong,
        this.venueName,
        this.venueRegion,
        this.venueAddress,
        this.currency,
        this.lastUpdated,
        this.profiles,
        this.registrationStartDateISO,
        this.registrationEndDateISO,
        this.startsDateISO,
        this.endsDateISO,
        this.items,
        this.contestantReg});

  EventDetailsModel.fromJson(Map<String, dynamic> json) {
    affiliateGUID = json['affiliateGUID'];
    eventGUID = json['eventGUID'];
    endsTime = json['endsTime'];
    startsDate = json['startsDate'];
    eventContact = json['eventContact'];
    eventEmail = json['eventEmail'];
    endsDate = json['endsDate'];
    eventID = json['eventID'];
    indoorEvent = json['indoorEvent'];
    eventPhone = json['eventPhone'];
    title = json['title'];
    firstPublished = json['firstPublished'];
    guestType = json['guestType'];
    maxGuests = json['maxGuests'];
    registrationEndTime = json['registrationEndTime'];
    registrationEndDate = json['registrationEndDate'];
    registrationStartTime = json['registrationStartTime'];
    registrationStartDate = json['registrationStartDate'];
    startsTime = json['startsTime'];
    userID = json['userID'];
    volunteerEnd = json['volunteerEnd'];
    volunteerStart = json['volunteerStart'];
    isPublished = json['isPublished'];
    timeZone = json['timeZone'];
    eventType = json['eventType'];
    eventTypeCategory = json['eventTypeCategory'];
    eventTypeSubCategory = json['eventTypeSubCategory'];
    venueCity = json['venueCity'];
    venueCountry = json['venueCountry'];
    venueLat = json['venueLat'];
    venueLong = json['venueLong'];
    venueName = json['venueName'];
    venueRegion = json['venueRegion'];
    venueAddress = json['venueAddress'];
    currency = json['currency'];
    lastUpdated = json['lastUpdated'];
    if (json['profiles'] != null) {
      profiles = <Profiles>[];
      json['profiles'].forEach((v) {
        profiles!.add(new Profiles.fromJson(v));
      });
    }
    registrationStartDateISO = json['registrationStartDateISO'];
    registrationEndDateISO = json['registrationEndDateISO'];
    startsDateISO = json['startsDateISO'];
    endsDateISO = json['endsDateISO'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    contestantReg = json['contestantReg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['affiliateGUID'] = this.affiliateGUID;
    data['eventGUID'] = this.eventGUID;
    data['endsTime'] = this.endsTime;
    data['startsDate'] = this.startsDate;
    data['eventContact'] = this.eventContact;
    data['eventEmail'] = this.eventEmail;
    data['endsDate'] = this.endsDate;
    data['eventID'] = this.eventID;
    data['indoorEvent'] = this.indoorEvent;
    data['eventPhone'] = this.eventPhone;
    data['title'] = this.title;
    data['firstPublished'] = this.firstPublished;
    data['guestType'] = this.guestType;
    data['maxGuests'] = this.maxGuests;
    data['registrationEndTime'] = this.registrationEndTime;
    data['registrationEndDate'] = this.registrationEndDate;
    data['registrationStartTime'] = this.registrationStartTime;
    data['registrationStartDate'] = this.registrationStartDate;
    data['startsTime'] = this.startsTime;
    data['userID'] = this.userID;
    data['volunteerEnd'] = this.volunteerEnd;
    data['volunteerStart'] = this.volunteerStart;
    data['isPublished'] = this.isPublished;
    data['timeZone'] = this.timeZone;
    data['eventType'] = this.eventType;
    data['eventTypeCategory'] = this.eventTypeCategory;
    data['eventTypeSubCategory'] = this.eventTypeSubCategory;
    data['venueCity'] = this.venueCity;
    data['venueCountry'] = this.venueCountry;
    data['venueLat'] = this.venueLat;
    data['venueLong'] = this.venueLong;
    data['venueName'] = this.venueName;
    data['venueRegion'] = this.venueRegion;
    data['venueAddress'] = this.venueAddress;
    data['currency'] = this.currency;
    data['lastUpdated'] = this.lastUpdated;
    if (this.profiles != null) {
      data['profiles'] = this.profiles!.map((v) => v.toJson()).toList();
    }
    data['registrationStartDateISO'] = this.registrationStartDateISO;
    data['registrationEndDateISO'] = this.registrationEndDateISO;
    data['startsDateISO'] = this.startsDateISO;
    data['endsDateISO'] = this.endsDateISO;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['contestantReg'] = this.contestantReg;
    return data;
  }
}

class Profiles {
  dynamic? profileID;
  String? profileName;
  String? profileGUID;
  dynamic? na;

  Profiles({this.profileID, this.profileName, this.profileGUID, this.na});

  Profiles.fromJson(Map<String, dynamic> json) {
    profileID = json['profileID'];
    profileName = json['profileName'];
    profileGUID = json['profileGUID'];
    na = json['na'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profileID'] = this.profileID;
    data['profileName'] = this.profileName;
    data['profileGUID'] = this.profileGUID;
    data['na'] = this.na;
    return data;
  }
}

class Items {
  dynamic? itemID;
  String? itemName;
  String? isp;
  String? description;
  String? htmlDescription;
  String? itemCategory;
  String? fgn;
  dynamic? gri;
  dynamic? fgo;
  dynamic? fr;
  String? fcs;
  dynamic? price;
  dynamic? itemActive;
  dynamic? minAge;
  dynamic? maxAge;
  dynamic? quantityLeft;
  dynamic? limitPerReg;
  bool? hideFromCheckInApp;
  bool? disableDecrementing;
  String? venueCity;
  String? venueCountry;
  double? venueLat;
  double? venueLong;
  String? venueName;
  String? venueRegion;
  String? venueAddress;
  String? venueDirections;

  Items(
      {this.itemID,
        this.itemName,
        this.isp,
        this.description,
        this.htmlDescription,
        this.itemCategory,
        this.fgn,
        this.gri,
        this.fgo,
        this.fr,
        this.fcs,
        this.price,
        this.itemActive,
        this.minAge,
        this.maxAge,
        this.quantityLeft,
        this.limitPerReg,
        this.hideFromCheckInApp,
        this.disableDecrementing,
        this.venueCity,
        this.venueCountry,
        this.venueLat,
        this.venueLong,
        this.venueName,
        this.venueRegion,
        this.venueAddress,
        this.venueDirections});

  Items.fromJson(Map<String, dynamic> json) {
    itemID = json['itemID'];
    itemName = json['itemName'];
    isp = json['isp'];
    description = json['description'];
    htmlDescription = json['htmlDescription'];
    itemCategory = json['itemCategory'];
    fgn = json['fgn'];
    gri = json['gri'];
    fgo = json['fgo'];
    fr = json['fr'];
    fcs = json['fcs'];
    price = json['price'];
    itemActive = json['itemActive'];
    minAge = json['minAge'];
    maxAge = json['maxAge'];
    quantityLeft = json['quantityLeft'];
    limitPerReg = json['limitPerReg'];
    hideFromCheckInApp = json['hideFromCheckInApp'];
    disableDecrementing = json['disableDecrementing'];
    venueCity = json['venueCity'];
    venueCountry = json['venueCountry'];
    venueLat = json['venueLat'];
    venueLong = json['venueLong'];
    venueName = json['venueName'];
    venueRegion = json['venueRegion'];
    venueAddress = json['venueAddress'];
    venueDirections = json['venueDirections'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemID'] = this.itemID;
    data['itemName'] = this.itemName;
    data['isp'] = this.isp;
    data['description'] = this.description;
    data['htmlDescription'] = this.htmlDescription;
    data['itemCategory'] = this.itemCategory;
    data['fgn'] = this.fgn;
    data['gri'] = this.gri;
    data['fgo'] = this.fgo;
    data['fr'] = this.fr;
    data['fcs'] = this.fcs;
    data['price'] = this.price;
    data['itemActive'] = this.itemActive;
    data['minAge'] = this.minAge;
    data['maxAge'] = this.maxAge;
    data['quantityLeft'] = this.quantityLeft;
    data['limitPerReg'] = this.limitPerReg;
    data['hideFromCheckInApp'] = this.hideFromCheckInApp;
    data['disableDecrementing'] = this.disableDecrementing;
    data['venueCity'] = this.venueCity;
    data['venueCountry'] = this.venueCountry;
    data['venueLat'] = this.venueLat;
    data['venueLong'] = this.venueLong;
    data['venueName'] = this.venueName;
    data['venueRegion'] = this.venueRegion;
    data['venueAddress'] = this.venueAddress;
    data['venueDirections'] = this.venueDirections;
    return data;
  }
}
