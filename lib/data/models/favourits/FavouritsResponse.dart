import 'Favoritesdata.dart';

class FavouritsResponse {
  FavouritsResponse({
      this.success, 
      this.status, 
      this.message, 
      this.favoritesdata,});

  FavouritsResponse.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    favoritesdata = json['data'] != null ? Favoritesdata.fromJson(json['data']) : null;
  }
  bool? success;
  String? status;
  String? message;
  Favoritesdata? favoritesdata;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (favoritesdata != null) {
      map['data'] = favoritesdata!.toJson();
    }
    return map;
  }

}