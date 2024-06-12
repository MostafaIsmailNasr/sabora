

import '../Governorate/Cities.dart';

class GovernorateData {
  GovernorateData({
      this.cities,});

  GovernorateData.fromJson(dynamic json) {
    if (json['cities'] != null) {
      cities = [];
      json['cities'].forEach((v) {
        cities!.add(Cities.fromJson(v));
      });
    }
  }
  List<Cities>? cities;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (cities != null) {
      map['cities'] = cities!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}