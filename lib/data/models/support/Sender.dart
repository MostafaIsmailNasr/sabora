class Sender {
  Sender({
      this.id, 
      this.fullName, 
      this.avatar,});

  Sender.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['full_name'];
    avatar = json['avatar'];
  }
  int? id;
  String? fullName;
  String? avatar;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['full_name'] = fullName;
    map['avatar'] = avatar;
    return map;
  }

}