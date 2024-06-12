
import '../home/course_details/Course.dart';

class Favorites {
  Favorites({
      this.id, 
      this.webinar, 
      this.createdAt,});

  Favorites.fromJson(dynamic json) {
    id = json['id'];
    webinar = json['webinar'] != null ? Course.fromJson(json['webinar']) : null;
    createdAt = json['created_at'];
  }
  int? id;
  Course? webinar;
  int? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (webinar != null) {
      map['webinar'] = webinar!.toJson();
    }
    map['created_at'] = createdAt;
    return map;
  }

}