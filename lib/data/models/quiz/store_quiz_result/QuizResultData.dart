import 'Result.dart';

class QuizResultData {
  QuizResultData({
      this.result,});

  QuizResultData.fromJson(dynamic json) {
    result = json['result'] != null ? QuizResult.fromJson(json['result']) : null;
  }
  QuizResult? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (result != null) {
      map['result'] = result!.toJson();
    }
    return map;
  }

}