import '../home/course_details/Course.dart';


class SuggestedCoursesResponse {
  SuggestedCoursesResponse({
      this.success, 
      this.status, 
      this.message, 
      this.data,});

  SuggestedCoursesResponse.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(Course.fromJson(v));
      });
    }
  }
  bool? success;
  String? status;
  String? message;
  List<Course>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;

    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}