import '../quiz/store_quiz_result/Result.dart';

class MyResultData {
  MyResultData({
    this.results,});

  MyResultData.fromJson(dynamic json) {
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results!.add(QuizResult.fromJson(v));
      });
    }
  }
  List<QuizResult>? results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (results != null) {
      map['results'] = results!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}