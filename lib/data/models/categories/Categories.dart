import '../teachers/Teachers.dart';

class Categories {
  Categories({
    this.id,
    this.title,
    this.icon,
    this.teachers,
  });

  Categories.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    icon = json['icon'];
    if (json['teachers'] != null) {
      teachers = [];
      json['teachers'].forEach((v) {
        teachers!.add(Teachers.fromJson(v));
      });
    }
  }

  int? id;
  dynamic title;
  String? icon;
  List<Teachers>? teachers;
  bool isExpanded = false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['icon'] = icon;
    if (teachers != null) {
      map['teachers'] = teachers!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
