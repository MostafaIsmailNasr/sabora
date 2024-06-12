class Notifications {
  Notifications({
      this.id, 
      this.title, 
      this.message, 
      this.type, 
      this.image, 
      this.status, 
      this.createdAt,});

  Notifications.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    type = json['type'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
  }
  int? id;
  String? title;
  String? message;
  String? type;
  dynamic image;
  String? status;
  int? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['message'] = message;
    map['type'] = type;
    map['image'] = image;
    map['status'] = status;
    map['created_at'] = createdAt;
    return map;
  }

}