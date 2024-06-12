import 'TokenData.dart';

class ForgetPassResponse {
  ForgetPassResponse({
      this.success, 
      this.status, 
      this.message, 
      this.tokenData,});

  ForgetPassResponse.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    tokenData = json['data'] != null ? TokenData.fromJson(json['data']) : null;
  }
  bool? success;
  String? status;
  String? message;
  TokenData? tokenData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (tokenData != null) {
      map['data'] = tokenData!.toJson();
    }
    return map;
  }

}