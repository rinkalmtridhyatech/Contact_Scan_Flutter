class EventAuthModel {
  double? autoAdvanceRevert;
  String? apiKey;
  bool? success;
  int? multiDayCheckIn;
  int? autoAdvance;

  EventAuthModel(
      {this.autoAdvanceRevert,
        this.apiKey,
        this.success,
        this.multiDayCheckIn,
        this.autoAdvance});

  EventAuthModel.fromJson(Map<String, dynamic> json) {
    autoAdvanceRevert = json['autoAdvanceRevert'];
    apiKey = json['apiKey'];
    success = json['success'];
    multiDayCheckIn = json['multiDayCheckIn'];
    autoAdvance = json['autoAdvance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['autoAdvanceRevert'] = this.autoAdvanceRevert;
    data['apiKey'] = this.apiKey;
    data['success'] = this.success;
    data['multiDayCheckIn'] = this.multiDayCheckIn;
    data['autoAdvance'] = this.autoAdvance;
    return data;
  }
}
