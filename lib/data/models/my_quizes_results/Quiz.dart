import '../home/course_details/Course.dart';
import 'Questions.dart';

class Quiz {
  Quiz({
    this.id,
    this.fileId,
    this.chapterId,
    this.position,
    this.title,
    this.time,
    this.questionCount,
    this.totalMark,
    this.passMark,
    this.studentCount,
    this.successRate,
    this.authStatus,
    this.status,
    this.attempt,
    this.createdAt,
    this.certificate,
    this.showResults,
    this.mustPass,
    this.questions,
    this.authAttemptCount,
    this.attemptState,
    this.authCanStart,
    this.locked,
    this.webinar,});

  Quiz.fromJson(dynamic json) {
    id = json['id'];
    fileId = json['file_id'];
    chapterId = json['chapter_id'];
    position = json['position'];
    title = json['title'];
    time = json['time'];
    questionCount = json['question_count'];
    totalMark = json['total_mark'];
    passMark = json['pass_mark'];
    studentCount = json['student_count'];
    successRate = json['success_rate'];
    authStatus = json['auth_status'];
    status = json['status'];
    attempt = json['attempt'];
    createdAt = json['created_at'];
    certificate = json['certificate'];
    showResults = json['show_results'];
    mustPass = json['must_pass'];
    if (json['questions'] != null) {
      questions = [];
      json['questions'].forEach((v) {
        questions!.add(Questions.fromJson(v));
      });
    }
    authAttemptCount = json['auth_attempt_count'];
    attemptState = json['attempt_state'];
    authCanStart = json['auth_can_start'];
    locked =json['locked'] ?? false;
    webinar = json['webinar'] != null ? Course.fromJson(json['webinar']) : null;
  }
  int? id;
  int? fileId;
  int? chapterId;
  String? position;
  String? title;
  int? time;
  int? questionCount;
  int? totalMark;
  int? passMark;
  int? studentCount;
  int? successRate;
  String? authStatus;
  String? status;
  int? attempt;
  int? createdAt;
  int? certificate;
  int? showResults;
  int? mustPass;
  List<Questions>? questions;
  int? authAttemptCount;
  String? attemptState;
  bool? authCanStart;
  bool? locked;
  Course? webinar;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['file_id'] = fileId;
    map['chapter_id'] = chapterId;
    map['position'] = position;
    map['title'] = title;
    map['time'] = time;
    map['question_count'] = questionCount;
    map['total_mark'] = totalMark;
    map['pass_mark'] = passMark;
    map['student_count'] = studentCount;
    map['success_rate'] = successRate;
    map['auth_status'] = authStatus;
    map['status'] = status;
    map['attempt'] = attempt;
    map['created_at'] = createdAt;
    map['certificate'] = certificate;
    map['show_results'] = showResults;
    map['must_pass'] = mustPass;
    if (questions != null) {
      map['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    map['auth_attempt_count'] = authAttemptCount;
    map['attempt_state'] = attemptState;
    map['auth_can_start'] = authCanStart;
    map['locked'] = locked;
    if (webinar != null) {
      map['webinar'] = webinar!.toJson();
    }
    return map;
  }

}