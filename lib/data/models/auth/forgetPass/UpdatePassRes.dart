class UpdatePassRes {
  bool? success;
  String? status;
  String? message;
  TokenData? tokenData;

  UpdatePassRes({this.success, this.status, this.message, this.tokenData});

  UpdatePassRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    tokenData = json['data'] != null
        ? new TokenData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.tokenData != null) {
      data['data'] = this.tokenData!.toJson();
    }
    return data;
  }
}

class TokenData {
  String? token;

  TokenData({this.token});

  TokenData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}