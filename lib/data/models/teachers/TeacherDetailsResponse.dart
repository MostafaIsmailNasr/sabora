import 'TeacherDetailsdata.dart';

class TeacherDetailsResponse {
  TeacherDetailsResponse({
      this.success, 
      this.status, 
      this.message, 
      this.teacherDetailsdata,});

  TeacherDetailsResponse.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    teacherDetailsdata = json['data'] != null ? TeacherDetailsdata.fromJson(json['data']) : null;
  }
  bool? success;
  String? status;
  String? message;
  TeacherDetailsdata? teacherDetailsdata;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (teacherDetailsdata != null) {
      map['data'] = teacherDetailsdata!.toJson();
    }
    return map;
  }

}