class Supportdata {
  Supportdata({
      this.id, 
      this.title, 
      this.number, 
      this.type, 
      this.status, 
      this.createdAt,});

  Supportdata.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    number = json['number'];
    type = json['type'];
    status = json['status'];
    createdAt = json['created_at'];
  }
  int? id;
  String? title;
  String? number;
  String? type;
  String? status;
  int? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['number'] = number;
    map['type'] = type;
    map['status'] = status;
    map['created_at'] = createdAt;
    return map;
  }

}