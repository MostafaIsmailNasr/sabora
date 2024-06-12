import '../auth/Organization.dart';

class Organizations {
  Organizations({
      this.organizations, 
      this.count,});

  Organizations.fromJson(dynamic json) {
    if (json['organizations'] != null) {
      organizations = [];
      json['organizations'].forEach((v) {
        organizations!.add(Organization.fromJson(v));
      });
    }
    count = json['count'];
  }
  List<dynamic>? organizations;
  int? count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (organizations != null) {
      map['organizations'] = organizations!.map((v) => v.toJson()).toList();
    }
    map['count'] = count;
    return map;
  }

}