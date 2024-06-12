import '../home/course_details/Course.dart';

class MyCoursesData {
  MyCoursesData({
    this.webinars,});

  MyCoursesData.fromJson(dynamic json) {
    if (json['webinars'] != null) {
      webinars = [];
      json['webinars'].forEach((v) {
        webinars!.add(Course.fromJson(v));
      });
    }
  }
  List<Course>? webinars;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (webinars != null) {
      map['webinars'] = webinars!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}