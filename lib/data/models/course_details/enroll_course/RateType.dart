class RateType {
  RateType({
      this.contentQuality, 
      this.instructorSkills, 
      this.purchaseWorth, 
      this.supportQuality,});

  RateType.fromJson(dynamic json) {
    contentQuality = json['content_quality'];
    instructorSkills = json['instructor_skills'];
    purchaseWorth = json['purchase_worth'];
    supportQuality = json['support_quality'];
  }
  dynamic contentQuality;
  dynamic instructorSkills;
  dynamic purchaseWorth;
  dynamic supportQuality;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['content_quality'] = contentQuality;
    map['instructor_skills'] = instructorSkills;
    map['purchase_worth'] = purchaseWorth;
    map['support_quality'] = supportQuality;
    return map;
  }

}