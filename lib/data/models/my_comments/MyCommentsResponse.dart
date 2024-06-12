import 'MyCommentData.dart';

class MyCommentsResponse {
  MyCommentsResponse({
      this.success, 
      this.status, 
      this.message, 
      this.myCommentData,});

  MyCommentsResponse.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    myCommentData = json['data'] != null ? MyCommentData.fromJson(json['data']) : null;
  }
  bool? success;
  String? status;
  String? message;
  MyCommentData? myCommentData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (myCommentData != null) {
      map['data'] = myCommentData!.toJson();
    }
    return map;
  }

}