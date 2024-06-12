import 'Organizations.dart';

class OrganizationData {
  OrganizationData({
      this.organizations,});

  OrganizationData.fromJson(dynamic json) {
    if (json['organizations'] != null) {
      organizations = [];
      json['organizations'].forEach((v) {
        organizations!.add(Organizations.fromJson(v));
      });
    }
  }
  List<Organizations>? organizations;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (organizations != null) {
      map['organizations'] = organizations!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}