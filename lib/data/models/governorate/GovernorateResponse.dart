import 'GovernorateData.dart';

class GovernorateResponse {
  GovernorateResponse({
      this.success, 
      this.status, 
      this.message, 
      this.governorateData,});

  GovernorateResponse.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    governorateData = json['data'] != null ? GovernorateData.fromJson(json['data']) : null;
  }
  bool? success;
  String? status;
  String? message;
  GovernorateData? governorateData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (governorateData != null) {
      map['data'] = governorateData!.toJson();
    }
    return map;
  }

}