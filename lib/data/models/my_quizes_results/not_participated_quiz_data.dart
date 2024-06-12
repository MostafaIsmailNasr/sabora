import 'Quiz.dart';

class NotPQuizData {
  NotPQuizData({
    this.quizzes,});

  NotPQuizData.fromJson(dynamic json) {
    if (json['quizzes'] != null) {
      quizzes = [];
      json['quizzes'].forEach((v) {
        quizzes!.add(Quiz.fromJson(v));
      });
    }
  }
  List<dynamic>? quizzes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (quizzes != null) {
      map['quizzes'] = quizzes!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}