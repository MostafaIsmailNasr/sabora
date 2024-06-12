import 'Quiz.dart';


class QuizDetailsResponse {
  QuizDetailsResponse({
      this.success, 
      this.status, 
      this.message, 
      this.data,});

  QuizDetailsResponse.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Quiz.fromJson(json['data']) : null;
  }
  bool? success;
  String? status;
  String? message;
  Quiz? data;

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