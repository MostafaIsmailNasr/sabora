class Cities {
  Cities({
      this.id, 
      this.title,});

  Cities.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
  }
  int? id;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    return map;
  }

}