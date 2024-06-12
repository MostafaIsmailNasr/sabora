import 'Teachersdata.dart';

class TeachersResponse {
  TeachersResponse({
      this.success, 
      this.status, 
      this.message, 
      this.teachersdata,});

  TeachersResponse.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    teachersdata = json['data'] != null ? Teachersdata.fromJson(json['data']) : null;
  }
  bool? success;
  String? status;
  String? message;
  Teachersdata? teachersdata;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (teachersdata != null) {
      map['data'] = teachersdata!.toJson();
    }
    return map;
  }

}