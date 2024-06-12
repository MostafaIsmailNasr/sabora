import 'MyComment.dart';
import 'WebinarsComments.dart';

class MyCommentData {
  MyCommentData({
      this.myComment, 
      this.classComment,});

  MyCommentData.fromJson(dynamic json) {
    myComment = json['my_comment'] != null ? MyComment.fromJson(json['my_comment']) : null;
    if (json['class_comment'] != null) {
      classComment = [];
      json['class_comment'].forEach((v) {
        classComment!.add(WebinarsComments.fromJson(v));
      });
    }
  }
  MyComment? myComment;
  List<dynamic>? classComment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (myComment != null) {
      map['my_comment'] = myComment!.toJson();
    }
    if (classComment != null) {
      map['class_comment'] = classComment!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}