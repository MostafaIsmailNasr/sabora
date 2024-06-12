class BaseResponse {
  BaseResponse({
      this.success, 
      this.status, 
      this.message,});

  BaseResponse.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
  }
  bool? success;
  String? status;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    return map;
  }

}