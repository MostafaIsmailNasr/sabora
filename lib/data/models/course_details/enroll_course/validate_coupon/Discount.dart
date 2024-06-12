class Discount {
  Discount({
      this.id, 
      this.creatorId, 
      this.instructorId, 
      this.title, 
      this.discountType, 
      this.source, 
      this.code, 
      this.percent, 
      this.amount, 
      this.maxAmount, 
      this.minimumOrder, 
      this.count, 
      this.userType, 
      this.forFirstPurchase, 
      this.status, 
      this.expiredAt, 
      this.createdAt, 
      this.discountGroups,});

  Discount.fromJson(dynamic json) {
    id = json['id'];
    creatorId = json['creator_id'];
    instructorId = json['instructor_id'];
    title = json['title'];
    discountType = json['discount_type'];
    source = json['source'];
    code = json['code'];
    percent = json['percent'];
    amount = json['amount'];
    maxAmount = json['max_amount'];
    minimumOrder = json['minimum_order'];
    count = json['count'];
    userType = json['user_type'];
    forFirstPurchase = json['for_first_purchase'];
    status = json['status'];
    expiredAt = json['expired_at'];
    createdAt = json['created_at'];
    if (json['discount_groups'] != null) {
      discountGroups = [];
      // json['discount_groups'].forEach((v) {
      //   discountGroups!.add(Dynamic.fromJson(v));
      // });
    }
  }
  int? id;
  int? creatorId;
  dynamic instructorId;
  String? title;
  String? discountType;
  String? source;
  String? code;
  dynamic percent;
  dynamic amount;
  dynamic maxAmount;
  dynamic minimumOrder;
  int? count;
  dynamic userType;
  int? forFirstPurchase;
  String? status;
  dynamic expiredAt;
  dynamic createdAt;
  List<dynamic>? discountGroups;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['creator_id'] = creatorId;
    map['instructor_id'] = instructorId;
    map['title'] = title;
    map['discount_type'] = discountType;
    map['source'] = source;
    map['code'] = code;
    map['percent'] = percent;
    map['amount'] = amount;
    map['max_amount'] = maxAmount;
    map['minimum_order'] = minimumOrder;
    map['count'] = count;
    map['user_type'] = userType;
    map['for_first_purchase'] = forFirstPurchase;
    map['status'] = status;
    map['expired_at'] = expiredAt;
    map['created_at'] = createdAt;
    if (discountGroups != null) {
      map['discount_groups'] = discountGroups!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}