class LoginRequest {
  LoginRequest({
      this.username, 
      this.password, 
      this.deviceId,});

  LoginRequest.fromJson(dynamic json) {
    username = json['username'];
    password = json['password'];
    deviceId = json['device_id'];
  }
  String? username;
  String? password;
  String? deviceId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['password'] = password;
    map['device_id'] = deviceId;
    return map;
  }

}