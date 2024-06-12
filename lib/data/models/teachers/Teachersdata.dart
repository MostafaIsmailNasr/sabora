import 'Teachers.dart';

class Teachersdata {
  Teachersdata({
      this.teachers,});

  Teachersdata.fromJson(dynamic json) {
    if (json['users'] != null) {
      teachers = [];
      json['users'].forEach((v) {
        teachers!.add(Teachers.fromJson(v));
      });
    }
  }
  List<Teachers>? teachers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (teachers != null) {
      map['users'] = teachers!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}