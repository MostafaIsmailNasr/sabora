import 'Sliderdata.dart';

class HomeSliderResponse {
  HomeSliderResponse({
      this.success, 
      this.status, 
      this.message, 
      this.sliderdata,});

  HomeSliderResponse.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    sliderdata = json['data'] != null ? Sliderdata.fromJson(json['data']) : null;
  }
  bool? success;
  String? status;
  String? message;
  Sliderdata? sliderdata;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (sliderdata != null) {
      map['data'] = sliderdata!.toJson();
    }
    return map;
  }

}