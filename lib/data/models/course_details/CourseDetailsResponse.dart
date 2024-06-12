import '../home/course_details/Course.dart';

class CourseDetailsResponse {
  CourseDetailsResponse({
      this.success, 
      this.status, 
      this.message, 
      this.course,});

  CourseDetailsResponse.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    course = json['data'] != null ? Course.fromJson(json['data']) : null;
  }
  bool? success;
  String? status;
  String? message;
  Course? course;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (course != null) {
      map['data'] = course!.toJson();
    }
    return map;
  }

}