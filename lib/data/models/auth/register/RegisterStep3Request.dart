class RegisterStep3Request {
  RegisterStep3Request({
      this.userId, 
      this.fullName,});

  RegisterStep3Request.fromJson(dynamic json) {
    userId = json['user_id'];
    fullName = json['full_name'];
  }
  String? userId;
  String? fullName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['full_name'] = fullName;
    return map;
  }

}