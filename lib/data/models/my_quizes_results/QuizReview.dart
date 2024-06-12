import 'UserAnswer.dart';

class QuizReview {
  QuizReview({
      this.id, 
      this.title, 
      this.image, 
      this.type, 
      this.descriptiveCorrectAnswer, 
      this.grade, 
      this.createdAt, 
      this.updatedAt, 
      this.answers, 
      this.quizzesHeaders, 
      this.userAnswer, 
      this.multipleCorrectAnswer,});

  QuizReview.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    type = json['type'];
    descriptiveCorrectAnswer = json['descriptive_correct_answer'];
    grade = json['grade'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['answers'] != null) {
      answers = [];
      json['answers'].forEach((v) {
        //answers.add(Dynamic.fromJson(v));
      });
    }
    quizzesHeaders = json['quizzes_headers'];
    userAnswer = json['user_answer'] != null ? UserAnswer.fromJson(json['user_answer']) : null;
    multipleCorrectAnswer = json['multiple_correct_answer'];
  }
  int? id;
  String? title;
  String? image;
  String? type;
  String? descriptiveCorrectAnswer;
  String? grade;
  int? createdAt;
  dynamic updatedAt;
  List<dynamic>? answers;
  dynamic quizzesHeaders;
  UserAnswer? userAnswer;
  dynamic multipleCorrectAnswer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['image'] = image;
    map['type'] = type;
    map['descriptive_correct_answer'] = descriptiveCorrectAnswer;
    map['grade'] = grade;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (answers != null) {
      map['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    map['quizzes_headers'] = quizzesHeaders;
    if (userAnswer != null) {
      map['user_answer'] = userAnswer!.toJson();
    }
    map['multiple_correct_answer'] = multipleCorrectAnswer;
    return map;
  }

}