class RegisterRequest {
  RegisterRequest({
      this.type, 
      this.fullName, 
      this.mobile, 
      this.countryCode, 
      this.password, 
      this.passwordConfirmation, 
      this.deviceId, 
      this.cityId, 
      this.groupId, 
      this.organId, 
      this.gender,});

  RegisterRequest.fromJson(dynamic json) {
    type = json['type'];
    fullName = json['full_name'];
    mobile = json['mobile'];
    countryCode = json['country_code'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
    deviceId = json['device_id'];
    cityId = json['city_id'];
    groupId = json['group_id'];
    organId = json['organ_id'];
    gender = json['gender'];
  }
  String? type;
  String? fullName;
  String? mobile;
  String? countryCode;
  String? password;
  String? passwordConfirmation;
  String? deviceId;
  String? cityId;
  String? groupId;
  String? organId;
  String? gender;

  Map<String, dynamic> toJson(bool isRegister) {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['full_name'] = fullName;
    map['mobile'] = mobile;
    map['country_code'] = countryCode;
    if (isRegister){
      map['password'] = password;
    map['password_confirmation'] = passwordConfirmation;
  }
    map['device_id'] = deviceId;
    map['city_id'] = cityId;
    map['group_id'] = groupId;
    map['organ_id'] = organId;
    map['gender'] = gender;
    return map;
  }

}