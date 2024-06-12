import 'Amounts.dart';
import 'Items.dart';

class Cart {
  Cart({
      this.items, 
      this.amounts,});

  Cart.fromJson(dynamic json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    amounts = json['amounts'] != null ? Amounts.fromJson(json['amounts']) : null;
  }
  List<Items>? items;
  Amounts? amounts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (items != null) {
      map['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (amounts != null) {
      map['amounts'] = amounts!.toJson();
    }
    return map;
  }

}