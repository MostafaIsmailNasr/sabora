class Organizations {
  Organizations({
      this.id, 
      this.name,});

  Organizations.fromJson(dynamic json) {
    id = json['id'];
    name = json['full_name'];
  }
  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['full_name'] = name;
    return map;
  }

}