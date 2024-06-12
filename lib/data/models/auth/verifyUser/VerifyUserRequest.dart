class VerifyUserRequest {
  VerifyUserRequest({
      this.user_id,});

  VerifyUserRequest.fromJson(dynamic json) {
    user_id = json['user_id'];
  }
  String? user_id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = user_id;
    return map;
  }

}