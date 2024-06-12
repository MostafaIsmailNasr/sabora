import 'AnswerSheet.dart';

class QuizAnswer {
  QuizAnswer({
      this.answerSheet, 
      this.quizResultId,});

  QuizAnswer.fromJson(dynamic json) {
    if (json['answer_sheet'] != null) {
      answerSheet = [];
      json['answer_sheet'].forEach((v) {
        answerSheet!.add(AnswerSheet.fromJson(v));
      });
    }
    quizResultId = json['quiz_result_id'];
  }
  List<AnswerSheet?>? answerSheet;
  int? quizResultId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (answerSheet != null) {
      map['answer_sheet'] = answerSheet!.map((v) => v!.toJson()).toList();
    }
    map['quiz_result_id'] = quizResultId;
    return map;
  }

}