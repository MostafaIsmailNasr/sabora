class AnswerSheet {
  AnswerSheet({
      this.answer, 
      this.grade, 
      this.status, 
      this.questionId,});

  AnswerSheet.fromJson(dynamic json) {
    answer = json['answer'];
    grade = json['grade'];
    status = json['status'];
    questionId = json['question_id'];
  }
  String? answer;
  double? grade=0.0;
  bool? status;
  int? questionId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['answer'] = answer;
    map['grade'] = grade;
    map['status'] = status;
    map['question_id'] = questionId;
    return map;
  }

}