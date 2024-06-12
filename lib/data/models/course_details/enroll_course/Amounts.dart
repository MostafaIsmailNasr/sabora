class Amounts {
  Amounts({
      this.subTotal, 
      this.totalDiscount, 
      this.tax, 
      this.taxPrice, 
      this.commission, 
      this.commissionPrice, 
      this.total,});

  Amounts.fromJson(dynamic json) {
    subTotal = json['sub_total'];
    totalDiscount = json['total_discount'];
    tax = json['tax'];
    taxPrice = json['tax_price'];
    commission = json['commission'];
    commissionPrice = json['commission_price'];
    total = json['total'];
  }
  dynamic subTotal;
  dynamic totalDiscount;
  dynamic tax;
  dynamic taxPrice;
  dynamic commission;
  dynamic commissionPrice;
  dynamic total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sub_total'] = subTotal;
    map['total_discount'] = totalDiscount;
    map['tax'] = tax;
    map['tax_price'] = taxPrice;
    map['commission'] = commission;
    map['commission_price'] = commissionPrice;
    map['total'] = total;
    return map;
  }

}