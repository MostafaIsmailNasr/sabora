import 'GroupsData.dart';

class GroupsResponse {
  GroupsResponse({
      this.success, 
      this.status, 
      this.message, 
      this.groupsData,});

  GroupsResponse.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    groupsData = json['data'] != null ? GroupsData.fromJson(json['data']) : null;
  }
  bool? success;
  String? status;
  String? message;
  GroupsData? groupsData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (groupsData != null) {
      map['data'] = groupsData!.toJson();
    }
    return map;
  }

}