import 'dart:convert';
/// success : true
/// status : "login"
/// message : "Login"
/// data : {"token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9tZWdhLm10anJzYWhsLWtzYS5jb21cL2FwaVwvZGV2ZWxvcG1lbnRcL2xvZ2luIiwiaWF0IjoxNjc4NzAwNzU4LCJuYmYiOjE2Nzg3MDA3NTgsImp0aSI6IkhMMVlhVlBxTjRZV1FGdGIiLCJzdWIiOjExNDMsInBydiI6IjQwYTk3ZmNhMmQ0MjRlNzc4YTA3YTBhMmYxMmRjNTE3YTg1Y2JkYzEifQ.QT7r0BYyMCW8wAvaS4-sd9E-1JzB_FtdcR-d4-wlVqk","user_id":1143,"type":"user","group_id":3}




LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));
String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());
class LoginResponse {
  LoginResponse({
      bool? success, 
      String? status, 
      String? message, 
      LoginData? loginData,}){
    _success = success;
    _status = status;
    _message = message;
    _loginData = loginData;
}

  LoginResponse.fromJson(dynamic json) {
    _success = json['success'];
    _status = json['status'];
    _message = json['message'];
    _loginData = json['data'] != null ? LoginData.fromJson(json['data']) : null;
  }
  bool? _success;
  String? _status;
  String? _message;
  LoginData? _loginData;
LoginResponse copyWith({  bool? success,
  String? status,
  String? message,
  LoginData? loginData,
}) => LoginResponse(  success: success ?? _success,
  status: status ?? _status,
  message: message ?? _message,
  loginData: loginData ?? _loginData,
);
  bool? get success => _success;
  String? get status => _status;
  String? get message => _message;
  LoginData? get loginData => _loginData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['status'] = _status;
    map['message'] = _message;
    if (_loginData != null) {
      map['data'] = _loginData?.toJson();
    }
    return map;
  }

}

/// token : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9tZWdhLm10anJzYWhsLWtzYS5jb21cL2FwaVwvZGV2ZWxvcG1lbnRcL2xvZ2luIiwiaWF0IjoxNjc4NzAwNzU4LCJuYmYiOjE2Nzg3MDA3NTgsImp0aSI6IkhMMVlhVlBxTjRZV1FGdGIiLCJzdWIiOjExNDMsInBydiI6IjQwYTk3ZmNhMmQ0MjRlNzc4YTA3YTBhMmYxMmRjNTE3YTg1Y2JkYzEifQ.QT7r0BYyMCW8wAvaS4-sd9E-1JzB_FtdcR-d4-wlVqk"
/// user_id : 1143
/// type : "user"
/// group_id : 3

LoginData loginDataFromJson(String str) => LoginData.fromJson(json.decode(str));
String loginDataToJson(LoginData data) => json.encode(data.toJson());
class LoginData {
  LoginData({
    String? token,
    dynamic userId,
    String? type,
    dynamic groupId,}) {
    _token = token;
    _userId = userId;
    _type = type;
    _groupId = groupId;
  }

  LoginData.fromJson(dynamic json) {
    _token = json['token'];
    _userId = json['user_id'];
    _type = json['type'];
    _groupId = json['group_id'];
  }

  String? _token;
  dynamic _userId;
  String? _type;
  dynamic _groupId;

  LoginData copyWith({ String? token,
    dynamic userId,
    String? type,
    dynamic groupId,
  }) =>
      LoginData(token: token ?? _token,
        userId: userId ?? _userId,
        type: type ?? _type,
        groupId: groupId ?? _groupId,
      );

  String? get token => _token;

  dynamic get userId => _userId;

  String? get type => _type;

  dynamic get groupId => _groupId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = _token;
    map['user_id'] = _userId;
    map['type'] = _type;
    map['group_id'] = _groupId;
    return map;
  }
}
