import '../auth/User.dart';

class Users {
  Users({
      this.users, 
      this.count,});

  Users.fromJson(dynamic json) {
    if (json['users'] != null) {
      users = [];
      json['users'].forEach((v) {
        users!.add(User.fromJson(v));
      });
    }
    count = json['count'];
  }
  List<dynamic>? users;
  int? count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (users != null) {
      map['users'] = users!.map((v) => v.toJson()).toList();
    }
    map['count'] = count;
    return map;
  }

}