class UserAnswer {
  UserAnswer({
      this.grade, 
      this.status, 
      this.answer,});

  UserAnswer.fromJson(dynamic json) {
    grade = json['grade'];
    status = json['status'];
    answer = json['answer'];
  }
  String? grade;
  dynamic status;
  dynamic answer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['grade'] = grade;
    map['status'] = status;
    map['answer'] = answer;
    return map;
  }

}