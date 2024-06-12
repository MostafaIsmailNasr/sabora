class CouponResponse {
  bool? success;
  String? message;
  int? balance;
  Data? data;

  CouponResponse({this.success, this.message, this.balance, this.data});

  CouponResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    balance = json['balance'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['balance'] = this.balance;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? creatorId;
  String? addedBy;
  String? title;
  String? discountType;
  String? source;
  String? code;
  int? percent;
  String? amount;
  String? userType;
  String? status;
  int? expiredAt;
  int? createdAt;
  int? id;
  int? codeLength;

  Data(
      {this.creatorId,
        this.addedBy,
        this.title,
        this.discountType,
        this.source,
        this.code,
        this.percent,
        this.amount,
        this.userType,
        this.status,
        this.expiredAt,
        this.createdAt,
        this.id,
        this.codeLength});

  Data.fromJson(Map<String, dynamic> json) {
    creatorId = json['creator_id'];
    addedBy = json['added_by'];
    title = json['title'];
    discountType = json['discount_type'];
    source = json['source'];
    code = json['code'];
    percent = json['percent'];
    amount = json['amount'];
    userType = json['user_type'];
    status = json['status'];
    expiredAt = json['expired_at'];
    createdAt = json['created_at'];
    id = json['id'];
    codeLength = json['code_length'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['creator_id'] = this.creatorId;
    data['added_by'] = this.addedBy;
    data['title'] = this.title;
    data['discount_type'] = this.discountType;
    data['source'] = this.source;
    data['code'] = this.code;
    data['percent'] = this.percent;
    data['amount'] = this.amount;
    data['user_type'] = this.userType;
    data['status'] = this.status;
    data['expired_at'] = this.expiredAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['code_length'] = this.codeLength;
    return data;
  }
}