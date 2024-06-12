class ListPointsResponse {
  bool? success;
  String? message;
  String? balance;
  List<Points>? data;
  List<Coupons>? coupons;

  ListPointsResponse(
      {this.success, this.message, this.balance, this.data, this.coupons});

  ListPointsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    balance = json['balance'];
    if (json['data'] != null) {
      data = <Points>[];
      json['data'].forEach((v) {
        data!.add(new Points.fromJson(v));
      });
    }
    if (json['coupons'] != null) {
      coupons = <Coupons>[];
      json['coupons'].forEach((v) {
        coupons!.add(new Coupons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['balance'] = this.balance;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.coupons != null) {
      data['coupons'] = this.coupons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Points {
  int? id;
  String? name;
  String? image;
  int? pointsNumber;
  String? value;
  int? createdAt;
  int? updatedAt;
  String? message;

  Points(
      {this.id,
        this.name,
        this.image,
        this.pointsNumber,
        this.value,
        this.createdAt,
        this.updatedAt,
        this.message});

  Points.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    pointsNumber = json['points_number'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['points_number'] = this.pointsNumber;
    data['value'] = this.value;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['message'] = this.message;
    return data;
  }
}

class Coupons {
  int? id;
  int? creatorId;
  String? addedBy;
  Null? instructorId;
  Null? cityId;
  Null? organId;
  String? title;
  String? discountType;
  String? source;
  String? code;
  int? percent;
  int? amount;
  Null? maxAmount;
  Null? minimumOrder;
  int? count;
  String? userType;
  int? forFirstPurchase;
  String? status;
  int? expiredAt;
  int? createdAt;
  int? codeLength;

  Coupons(
      {this.id,
        this.creatorId,
        this.addedBy,
        this.instructorId,
        this.cityId,
        this.organId,
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
        this.codeLength});

  Coupons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creatorId = json['creator_id'];
    addedBy = json['added_by'];
    instructorId = json['instructor_id'];
    cityId = json['city_id'];
    organId = json['organ_id'];
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
    codeLength = json['code_length'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['creator_id'] = this.creatorId;
    data['added_by'] = this.addedBy;
    data['instructor_id'] = this.instructorId;
    data['city_id'] = this.cityId;
    data['organ_id'] = this.organId;
    data['title'] = this.title;
    data['discount_type'] = this.discountType;
    data['source'] = this.source;
    data['code'] = this.code;
    data['percent'] = this.percent;
    data['amount'] = this.amount;
    data['max_amount'] = this.maxAmount;
    data['minimum_order'] = this.minimumOrder;
    data['count'] = this.count;
    data['user_type'] = this.userType;
    data['for_first_purchase'] = this.forFirstPurchase;
    data['status'] = this.status;
    data['expired_at'] = this.expiredAt;
    data['created_at'] = this.createdAt;
    data['code_length'] = this.codeLength;
    return data;
  }
}