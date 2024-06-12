class Badges {
  Badges({
      this.id, 
      this.title, 
      this.type, 
      this.condition, 
      this.image, 
      this.locale, 
      this.description, 
      this.createdAt,});

  Badges.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    condition = json['condition'];
    image = json['image'];
    locale = json['locale'];
    description = json['description'];
    createdAt = json['created_at'];
  }
  int? id;
  String? title;
  String? type;
  String? condition;
  String? image;
  String? locale;
  String? description;
  int? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['type'] = type;
    map['condition'] = condition;
    map['image'] = image;
    map['locale'] = locale;
    map['description'] = description;
    map['created_at'] = createdAt;
    return map;
  }

}