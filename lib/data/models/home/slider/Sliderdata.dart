import 'AdvertisingBanners.dart';

class Sliderdata {
  Sliderdata({
      this.count, 
      this.advertisingBanners,});

  Sliderdata.fromJson(dynamic json) {
    count = json['count'];
    if (json['advertising_banners'] != null) {
      advertisingBanners = [];
      json['advertising_banners'].forEach((v) {
        advertisingBanners!.add(AdvertisingBanners.fromJson(v));
      });
    }
  }
  int? count;
  List<AdvertisingBanners>? advertisingBanners;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    if (advertisingBanners != null) {
      map['advertising_banners'] = advertisingBanners!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}