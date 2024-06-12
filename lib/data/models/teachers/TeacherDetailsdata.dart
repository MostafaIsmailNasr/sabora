import 'Teachers.dart';

class TeacherDetailsdata {
  TeacherDetailsdata({
      this.teachers,});

  TeacherDetailsdata.fromJson(dynamic json) {
    teachers = json['user'] != null ? Teachers.fromJson(json['user']) : null;
  }
  Teachers? teachers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (teachers != null) {
      map['user'] = teachers!.toJson();
    }
    return map;
  }

}