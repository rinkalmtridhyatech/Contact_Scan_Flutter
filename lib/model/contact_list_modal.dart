class ScanResponseModel {
  String? status;
  List<ContactListModel>? data;

  ScanResponseModel({this.status, this.data});

  ScanResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ContactListModel>[];
      json['data'].forEach((v) {
        data!.add(new ContactListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] =
          this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContactListModel {
  dynamic? id;
  String? firstName;
  String? lastName;
  String? designation;
  String? organization;

  ContactListModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.designation,
      this.organization});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'designation': designation,
      'organization': organization
    };
  }

  ContactListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    designation = json['designation'];
    organization = json['organization'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['designation'] = this.designation;
    data['organization'] = this.organization;
    return data;
  }
}
