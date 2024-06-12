import 'Searchdata.dart';

class SearchResponse {
  SearchResponse({
      this.success, 
      this.status, 
      this.message, 
      this.searchdata,});

  SearchResponse.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    searchdata = json['data'] != null ? Searchdata.fromJson(json['data']) : null;
  }
  bool? success;
  String? status;
  String? message;
  Searchdata? searchdata;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (searchdata != null) {
      map['data'] = searchdata!.toJson();
    }
    return map;
  }

}