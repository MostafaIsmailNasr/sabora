import '../home/course_details/Course.dart';

class Webinars {
  Webinars({
      this.webinars, 
      this.count,});

  Webinars.fromJson(dynamic json) {
    if (json['webinars'] != null) {
      webinars = [];
      json['webinars'].forEach((v) {
        webinars!.add(Course.fromJson(v));
      });
    }
    count = json['count'];
  }
  List<dynamic>? webinars;
  int? count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (webinars != null) {
      map['webinars'] = webinars!.map((v) => v.toJson()).toList();
    }
    map['count'] = count;
    return map;
  }

}