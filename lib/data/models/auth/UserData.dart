import 'User.dart';

class UserData {
  UserData({
      this.user,});

  UserData.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user!.toJson();
    }
    return map;
  }

}