class DataStep3 {
  DataStep3({
      this.userId, 
      this.fullName, 
      this.token,});

  DataStep3.fromJson(dynamic json) {
    userId = json['user_id'];
    fullName = json['full_name'];
    token = json['token'];
  }
  int? userId;
  String? fullName;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['full_name'] = fullName;
    map['token'] = token;
    return map;
  }

}