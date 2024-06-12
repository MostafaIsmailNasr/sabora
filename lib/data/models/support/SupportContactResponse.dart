import 'Supportdata.dart';

class SupportContactResponse {
  SupportContactResponse({
      this.success, 
      this.status, 
      this.message, 
      this.supportdata,});

  SupportContactResponse.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      supportdata = [];
      json['data'].forEach((v) {
        supportdata!.add(Supportdata.fromJson(v));
      });
    }
  }
  bool? success;
  String? status;
  String? message;
  List<Supportdata>? supportdata;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (supportdata != null) {
      map['data'] = supportdata!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}