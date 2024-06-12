import 'Cart.dart';

class Cartdata {
  Cartdata({
      this.cart,});

  Cartdata.fromJson(dynamic json) {
    cart = json['cart'] != null ? Cart.fromJson(json['cart']) : null;
  }
  Cart? cart;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (cart != null) {
      map['cart'] = cart!.toJson();
    }
    return map;
  }

}