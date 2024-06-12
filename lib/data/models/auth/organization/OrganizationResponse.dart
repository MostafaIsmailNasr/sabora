import 'OrganizationData.dart';

class OrganizationResponse {
  OrganizationResponse({
      this.success, 
      this.status, 
      this.message, 
      this.organizationData,});

  OrganizationResponse.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    organizationData = json['data'] != null ? OrganizationData.fromJson(json['data']) : null;
  }
  bool? success;
  String? status;
  String? message;
  OrganizationData? organizationData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (organizationData != null) {
      map['data'] = organizationData!.toJson();
    }
    return map;
  }

}