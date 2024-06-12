class RateRequest {
  RateRequest({
    this.webinarId,
    this.description,
    this.contentQuality,
    this.instructorSkills,
    this.purchaseWorth,
    this.supportQuality
  });



  String? webinarId;
  String? description;
  String? contentQuality;
  String? instructorSkills;
  String? purchaseWorth;
  String? supportQuality;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['webinar_id'] = webinarId;
    map['description'] = description;
    map['content_quality'] = contentQuality;
    map['instructor_skills'] = instructorSkills;
    map['purchase_worth'] = purchaseWorth;
    map['support_quality'] = supportQuality;

    return map;
  }
}
