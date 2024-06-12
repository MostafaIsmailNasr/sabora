import 'StartQData.dart';

class StartQuizResponse {
  StartQuizResponse({
      this.success, 
      this.status, 
      this.message, 
      this.startQData,});

  StartQuizResponse.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    startQData = json['data'] != null ? StartQData.fromJson(json['data']) : null;
  }
  bool? success;
  String? status;
  String? message;
  StartQData? startQData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (startQData != null) {
      map['data'] = startQData!.toJson();
    }
    return map;
  }

}