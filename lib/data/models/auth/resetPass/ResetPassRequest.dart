class ResetPassRequest {
  ResetPassRequest({
      this.mobile, 
      this.password, 
      this.passwordConfirmation,});

  ResetPassRequest.fromJson(dynamic json) {
    mobile = json['mobile'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
  }
  String? mobile;
  String? password;
  String? passwordConfirmation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobile'] = mobile;
    map['password'] = password;
    map['password_confirmation'] = passwordConfirmation;
    return map;
  }

}