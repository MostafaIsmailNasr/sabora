import 'UserData.dart';

class ProfileResponse {
  ProfileResponse({
      this.success, 
      this.status, 
      this.message, 
      this.userData,});

  ProfileResponse.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    userData = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
  bool? success;
  String? status;
  String? message;
  UserData? userData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (userData != null) {
      map['data'] = userData!.toJson();
    }
    return map;
  }

}