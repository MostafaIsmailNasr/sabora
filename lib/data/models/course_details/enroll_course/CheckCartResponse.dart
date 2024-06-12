import 'Cartdata.dart';

class CheckCartResponse {
  CheckCartResponse({
      this.success, 
      this.status, 
      this.message, 
      this.cartdata,});

  CheckCartResponse.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    cartdata = json['data'] != null ? Cartdata.fromJson(json['data']) : null;
  }
  bool? success;
  String? status;
  String? message;
  Cartdata? cartdata;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (cartdata != null) {
      map['data'] = cartdata!.toJson();
    }
    return map;
  }

}