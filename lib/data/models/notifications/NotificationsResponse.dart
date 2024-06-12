import 'NotificationsData.dart';

class NotificationsResponse {
  NotificationsResponse({
      this.success, 
      this.status, 
      this.message, 
      this.notificationsData,});

  NotificationsResponse.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    notificationsData = json['data'] != null ? NotificationsData.fromJson(json['data']) : null;
  }
  bool? success;
  String? status;
  String? message;
  NotificationsData? notificationsData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (notificationsData != null) {
      map['data'] = notificationsData!.toJson();
    }
    return map;
  }

}