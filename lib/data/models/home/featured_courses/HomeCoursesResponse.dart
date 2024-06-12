import '../course_details/Course.dart';

class HomeCoursesResponse {
  HomeCoursesResponse({
      this.success, 
      this.status, 
      this.message, 
      this.courses,});

  HomeCoursesResponse.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      courses = [];
      json['data'].forEach((v) {
        courses!.add(Course.fromJson(v));
      });
    }
  }
  bool? success;
  String? status;
  String? message;
  List<Course>? courses;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (courses != null) {
      map['data'] = courses!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}