import 'Groups.dart';

class GroupsData {
  GroupsData({
      this.groups,});

  GroupsData.fromJson(dynamic json) {
    if (json['groups'] != null) {
      groups = [];
      json['groups'].forEach((v) {
        groups!.add(Groups.fromJson(v));
      });
    }
  }
  List<Groups>? groups;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (groups != null) {
      map['groups'] = groups!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}