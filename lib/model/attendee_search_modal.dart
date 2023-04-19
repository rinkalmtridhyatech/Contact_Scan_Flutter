class AttendeeSearchModal {
  String? success;
  List<Attendees>? attendees;

  AttendeeSearchModal({this.success, this.attendees});

  AttendeeSearchModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['attendees'] != null) {
      attendees = <Attendees>[];
      json['attendees'].forEach((v) {
        attendees!.add(Attendees.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.attendees != null) {
      data['attendees'] = this.attendees!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attendees {
  int? attendeeID;
  String? firstName;
  String? lastName;
  int? guestCount;
  String? icon;

  Attendees({this.attendeeID, this.firstName, this.lastName, this.guestCount, this.icon});

  Attendees.fromJson(Map<String, dynamic> json) {
    attendeeID = json['attendeeID'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    guestCount = json['guestCount'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attendeeID'] = this.attendeeID;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['guestCount'] = this.guestCount;
    data['icon'] = this.icon;
    return data;
  }
}
