
import '../../my_quizes_results/Quiz.dart';

class StartQData {
  StartQData({
      this.quizResultId, 
      this.quiz, 
      this.attemptNumber,});

  StartQData.fromJson(dynamic json) {
    quizResultId = json['quiz_result_id'];
    quiz = json['quiz'] != null ? Quiz.fromJson(json['quiz']) : null;
    attemptNumber = json['attempt_number'];
  }
  int? quizResultId;
  Quiz? quiz;
  int? attemptNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['quiz_result_id'] = quizResultId;
    if (quiz != null) {
      map['quiz'] = quiz!.toJson();
    }
    map['attempt_number'] = attemptNumber;
    return map;
  }

}