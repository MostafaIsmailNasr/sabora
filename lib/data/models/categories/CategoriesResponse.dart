import 'Categoriesdata.dart';

class CategoriesResponse {
  CategoriesResponse({
      this.success, 
      this.status, 
      this.message, 
      this.categoriesdata,});

  CategoriesResponse.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    categoriesdata = json['data'] != null ? Categoriesdata.fromJson(json['data']) : null;
  }
  bool? success;
  String? status;
  String? message;
  Categoriesdata? categoriesdata;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (categoriesdata != null) {
      map['data'] = categoriesdata!.toJson();
    }
    return map;
  }

}