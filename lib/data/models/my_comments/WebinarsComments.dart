import '../auth/User.dart';
import '../home/course_details/Course.dart';


class WebinarsComments {
  WebinarsComments({
      this.id, 
      this.status, 
      this.commentUserType, 
      this.createAt, 
      this.comment, 
      this.image, 
      this.voice, 
      this.blog, 
      this.user, 
      this.fileName, 
      this.webinar, 
      this.replies,});

  WebinarsComments.fromJson(dynamic json) {
    id = json['id'];
    status = json['status'];
    commentUserType = json['comment_user_type'];
    createAt = json['create_at'];
    comment = json['comment'];
    image = json['image'];
    voice = json['voice'];
    blog = json['blog'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    fileName = json['file_name'];
    webinar = json['webinar'] != null ? Course.fromJson(json['webinar']) : null;
    if (json['replies'] != null) {
      replies = [];
      json['replies'].forEach((v) {
        replies!.add(WebinarsComments.fromJson(v));
      });
    }
  }
  int? id;
  String? status;
  String? commentUserType;
  int? createAt;
  String? comment;
  dynamic image;
  dynamic voice;
  dynamic blog;
  User? user;
  dynamic fileName;
  Course? webinar;
  List<dynamic>? replies;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['status'] = status;
    map['comment_user_type'] = commentUserType;
    map['create_at'] = createAt;
    map['comment'] = comment;
    map['image'] = image;
    map['voice'] = voice;
    map['blog'] = blog;
    if (user != null) {
      map['user'] = user!.toJson();
    }
    map['file_name'] = fileName;
    if (webinar != null) {
      map['webinar'] = webinar!.toJson();
    }
    if (replies != null) {
      map['replies'] = replies!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}