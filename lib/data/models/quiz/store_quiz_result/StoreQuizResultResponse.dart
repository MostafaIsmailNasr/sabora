import 'QuizResultData.dart';

class StoreQuizResultResponse {
  StoreQuizResultResponse({
      this.success, 
      this.status, 
      this.message, 
      this.quizResultData,});

  StoreQuizResultResponse.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    quizResultData = json['data'] != null ? QuizResultData.fromJson(json['data']) : null;
  }
  bool? success;
  String? status;
  String? message;
  QuizResultData? quizResultData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (quizResultData != null) {
      map['data'] = quizResultData!.toJson();
    }
    return map;
  }

}