import 'WebinarsComments.dart';

class MyComment {
  MyComment({
      this.webinarsComments, 
      this.filesComments, 
      this.blogsComments,});

  MyComment.fromJson(dynamic json) {
    if (json['webinars'] != null) {
      webinarsComments = [];
      json['webinars'].forEach((v) {
        webinarsComments!.add(WebinarsComments.fromJson(v));
      });
    }
    if (json['files'] != null) {
      filesComments = [];
      json['files'].forEach((v) {
        filesComments!.add(WebinarsComments.fromJson(v));
      });
    }
    if (json['blogs'] != null) {
      blogsComments = [];
      json['blogs'].forEach((v) {
        blogsComments!.add(WebinarsComments.fromJson(v));
      });
    }
  }
  List<dynamic>? webinarsComments;
  List<dynamic>? filesComments;
  List<dynamic>? blogsComments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (webinarsComments != null) {
      map['webinars'] = webinarsComments!.map((v) => v.toJson()).toList();
    }
    if (filesComments != null) {
      map['files'] = filesComments!.map((v) => v.toJson()).toList();
    }
    if (blogsComments != null) {
      map['blogs'] = blogsComments!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}