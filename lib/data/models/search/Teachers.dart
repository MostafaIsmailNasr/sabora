
import '../teachers/Teachers.dart';

class TeachersSearch {
  TeachersSearch({
      this.teachers, 
      this.count,});

  TeachersSearch.fromJson(dynamic json) {
    if (json['teachers'] != null) {
      teachers = [];
      json['teachers'].forEach((v) {
        teachers!.add(Teachers.fromJson(v));
      });
    }
    count = json['count'];
  }
  List<dynamic>? teachers;
  int? count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (teachers != null) {
      map['teachers'] = teachers!.map((v) => v.toJson()).toList();
    }
    map['count'] = count;
    return map;
  }

}