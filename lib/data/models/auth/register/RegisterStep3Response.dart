import 'DataStep3.dart';

class RegisterStep3Response {
  RegisterStep3Response({
      this.success, 
      this.status, 
      this.message, 
      this.dataStep3,});

  RegisterStep3Response.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    dataStep3 = json['data'] != null ? DataStep3.fromJson(json['data']) : null;
  }
  bool? success;
  String? status;
  String? message;
  DataStep3? dataStep3;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (dataStep3 != null) {
      map['data'] = dataStep3!.toJson();
    }
    return map;
  }

}