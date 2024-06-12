import 'ContentData.dart';

class CourseContentResponse {
  CourseContentResponse({
      this.success, 
      this.status, 
      this.message, 
      this.contentData,});

  CourseContentResponse.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      contentData = [];
      json['data'].forEach((v) {
        contentData!.add(ContentData.fromJson(v));
      });
    }
  }
  bool? success;
  String? status;
  String? message;
  List<ContentData>? contentData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (contentData != null) {
      map['data'] = contentData!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}