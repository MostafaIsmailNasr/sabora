class Organization {
  Organization({
      this.organId, 
      this.organName,});

  Organization.fromJson(dynamic json) {
    organId = json['organ_id'];
    organName = json['organ_name'];
  }
  dynamic organId;
  dynamic organName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['organ_id'] = organId;
    map['organ_name'] = organName;
    return map;
  }

}