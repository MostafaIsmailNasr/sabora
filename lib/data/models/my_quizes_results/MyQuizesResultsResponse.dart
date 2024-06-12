import 'my_quiz_result_data.dart';


class MyQuizesResultsResponse {
  MyQuizesResultsResponse({
      this.success, 
      this.status, 
      this.message, 
      this.data,});

  MyQuizesResultsResponse.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? MyResultData.fromJson(json['data']) : null;
  }
  bool? success;
  String? status;
  String? message;
  MyResultData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    return map;
  }

}