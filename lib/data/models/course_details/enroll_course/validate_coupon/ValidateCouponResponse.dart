import 'CouponData.dart';

class ValidateCouponResponse {
  ValidateCouponResponse({
      this.success, 
      this.status, 
      this.message, 
      this.couponData,});

  ValidateCouponResponse.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    couponData = json['data'] != null ? CouponData.fromJson(json['data']) : null;
  }
  dynamic success;
  String? status;
  String? message;
  CouponData? couponData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (couponData != null) {
      map['data'] = couponData!.toJson();
    }
    return map;
  }

}