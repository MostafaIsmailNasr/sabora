import 'not_participated_quiz_data.dart';


class MyNotPQuizResponse {
  MyNotPQuizResponse({
      this.success, 
      this.status, 
      this.message, 
      this.data,});

  MyNotPQuizResponse.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? NotPQuizData.fromJson(json['data']) : null;
  }
  bool? success;
  String? status;
  String? message;
  NotPQuizData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    return map;
  }

}