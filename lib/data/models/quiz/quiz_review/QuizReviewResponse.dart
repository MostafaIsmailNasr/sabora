import '../store_quiz_result/Result.dart';


class QuizReviewResponse {
  QuizReviewResponse({
      this.success, 
      this.status, 
      this.message, 
      this.quizResult,});

  QuizReviewResponse.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    quizResult = json['data'] != null ? QuizResult.fromJson(json['data']) : null;
  }
  bool? success;
  String? status;
  String? message;
  QuizResult? quizResult;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (quizResult != null) {
      map['data'] = quizResult!.toJson();
    }
    return map;
  }

}