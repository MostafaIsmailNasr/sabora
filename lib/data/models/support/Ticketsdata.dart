import '../auth/User.dart';

import 'Conversations.dart';

class Ticketsdata {
  Ticketsdata({
      this.id, 
      this.department, 
      this.status, 
      this.type, 
      this.title, 
      this.webinar, 
      this.user, 
      this.conversations, 
      this.createdAt, 
      this.updatedAt,});

  Ticketsdata.fromJson(dynamic json) {
    id = json['id'];
    department = json['department'];
    status = json['status'];
    type = json['type'];
    title = json['title'];
    webinar = json['webinar'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['conversations'] != null) {
      conversations = [];
      json['conversations'].forEach((v) {
        conversations!.add(Conversations.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? department;
  String? status;
  String? type;
  String? title;
  dynamic webinar;
  User? user;
  List<Conversations>? conversations;
  int? createdAt;
  int? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['department'] = department;
    map['status'] = status;
    map['type'] = type;
    map['title'] = title;
    map['webinar'] = webinar;
    if (user != null) {
      map['user'] = user!.toJson();
    }
    if (conversations != null) {
      map['conversations'] = conversations!.map((v) => v.toJson()).toList();
    }
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}