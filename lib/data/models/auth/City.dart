class City {
  City({
      this.cityId, 
      this.cityName,});

  City.fromJson(dynamic json) {
    cityId = json['city_id'];
    cityName = json['city_name'];
  }
  dynamic cityId;
  dynamic cityName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['city_id'] = cityId;
    map['city_name'] = cityName;
    return map;
  }

}