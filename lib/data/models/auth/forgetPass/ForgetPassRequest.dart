class ForgetPassRequest {
  ForgetPassRequest({
      this.mobile,});

  ForgetPassRequest.fromJson(dynamic json) {
    mobile = json['mobile'];
  }
  String? mobile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobile'] = mobile;
    return map;
  }

}