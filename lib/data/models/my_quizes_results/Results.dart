import '../auth/User.dart';
import '../home/course_details/Course.dart';

import 'Quiz.dart';
import 'QuizReview.dart';

class Results {
  Results({
      this.id, 
      this.quiz, 
      this.webinar, 
      this.user, 
      this.userGrade, 
      this.status, 
      this.createdAt, 
      this.authCanTryAgain, 
      this.countTryAgain, 
      this.quizReview,});

  Results.fromJson(dynamic json) {
    id = json['id'];
    quiz = json['quiz'] != null ? Quiz.fromJson(json['quiz']) : null;
    webinar = json['webinar'] != null ? Course.fromJson(json['webinar']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    userGrade = json['user_grade'];
    status = json['status'];
    createdAt = json['created_at'];
    authCanTryAgain = json['auth_can_try_again'];
    countTryAgain = json['count_try_again'];
    if (json['quiz_review'] != null) {
      quizReview = [];
      json['quiz_review'].forEach((v) {
        quizReview!.add(QuizReview.fromJson(v));
      });
    }
  }
  int? id;
  Quiz? quiz;
  Course? webinar;
  User? user;
  int? userGrade;
  String? status;
  int? createdAt;
  bool? authCanTryAgain;
  int? countTryAgain;
  List<QuizReview>? quizReview;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (quiz != null) {
      map['quiz'] = quiz!.toJson();
    }
    if (webinar != null) {
      map['webinar'] = webinar!.toJson();
    }
    if (user != null) {
      map['user'] = user!.toJson();
    }
    map['user_grade'] = userGrade;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['auth_can_try_again'] = authCanTryAgain;
    map['count_try_again'] = countTryAgain;
    if (quizReview != null) {
      map['quiz_review'] = quizReview!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}