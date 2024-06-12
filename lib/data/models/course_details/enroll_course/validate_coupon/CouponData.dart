import '../Amounts.dart';
import 'Discount.dart';

class CouponData {
  CouponData({
      this.amounts, 
      this.discount,});

  CouponData.fromJson(dynamic json) {
    amounts = json['amounts'] != null ? Amounts.fromJson(json['amounts']) : null;
    discount = json['discount'] != null ? Discount.fromJson(json['discount']) : null;
  }
  Amounts? amounts;
  Discount? discount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (amounts != null) {
      map['amounts'] = amounts!.toJson();
    }
    if (discount != null) {
      map['discount'] = discount!.toJson();
    }
    return map;
  }

}