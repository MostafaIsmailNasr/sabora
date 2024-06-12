class UserGroup {
  UserGroup({
      this.id, 
      this.name, 
      this.status, 
      this.commission, 
      this.discount,});

  UserGroup.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    commission = json['commission'];
    discount = json['discount'];
  }
  int? id;
  String? name;
  String? status;
  dynamic commission;
  dynamic discount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['status'] = status;
    map['commission'] = commission;
    map['discount'] = discount;
    return map;
  }

}