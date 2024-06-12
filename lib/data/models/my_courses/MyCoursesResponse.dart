import 'MyCoursesData.dart';

class MyCoursesResponse {
  MyCoursesResponse({
      this.success, 
      this.status, 
      this.message, 
      this.data,});

  MyCoursesResponse.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? MyCoursesData.fromJson(json['data']) : null;
  }
  bool? success;
  String? status;
  String? message;
  MyCoursesData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    return map;
  }

}