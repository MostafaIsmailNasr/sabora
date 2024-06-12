import 'dart:convert';
/// register_method : "mobile"
/// offline_bank_account : ["Qatar National Bank","State Bank of India","JPMorgan"]
/// user_language : {"AR":"Arabic"}
/// public_verification_code : ["112233","121212"]
/// screenshot_count : "200"
/// duration_seconds : "20"
/// must_update_android : false
/// must_update_ios : true
/// otp : true
/// show_ticket : true
/// visa_payment : false
/// ios_version : null
/// payment_channels : {"active":[{"id":1,"title":"Paypal","class_name":"Paypal","status":"active","image":"/store/1/default_images/gateways/paypal.png","settings":"","created_at":"1617345734"},{"id":4,"title":"Payu","class_name":"Payu","status":"active","image":"/store/1/default_images/gateways/payu.png","settings":"","created_at":"1617345734"},{"id":5,"title":"Razorpay","class_name":"Razorpay","status":"active","image":"/store/1/default_images/gateways/razorpay.png","settings":"","created_at":"1617345734"}]}
/// minimum_payout_amount : "50"
/// currency : {"sign":"جنيه","name":"EGP"}
/// price_display : "only_price"
/// socials : [{"title":"Whatsapp","image":"/store/1/whatsapp.png","link":["+20 155 766 0273","+20 155 766 0881","01282173740"],"order":"1"},{"title":"hotline","image":"/store/1222/phone_PNG49006.png","link":["01282173740"],"order":"2"}]

SettingsResponse settingsResponseFromJson(dynamic str) => SettingsResponse.fromJson(json.decode(str));
dynamic settingsResponseToJson(SettingsResponse data) => json.encode(data.toJson());
class SettingsResponse {
  SettingsResponse({
    dynamic? registerMethod,
      List<dynamic>? offlineBankAccount,
      //UserLanguage? userLanguage,
      List<dynamic>? publicVerificationCode,
    dynamic? screenshotCount,
    dynamic? durationSeconds,
      bool? mustUpdateAndroid, 
      bool? mustUpdateIos, 
      bool? otp, 
      bool? showTicket, 
      bool? visaPayment, 
      bool? showSkip,
      dynamic iosVersion,
      PaymentChannels? paymentChannels,
    dynamic? minimumPayoutAmount,
      Currency? currency,
    dynamic? priceDisplay,
      List<Socials>? socials,}){
    _registerMethod = registerMethod;
    _offlineBankAccount = offlineBankAccount;
    //_userLanguage = userLanguage;
    _publicVerificationCode = publicVerificationCode;
    _screenshotCount = screenshotCount;
    _durationSeconds = durationSeconds;
    _showSkip = showSkip;
    _codeLength=
    _mustUpdateAndroid = mustUpdateAndroid;
    _mustUpdateIos = mustUpdateIos;
    _otp = otp;
    _showTicket = showTicket;
    _visaPayment = visaPayment;
    _iosVersion = iosVersion;
    _paymentChannels = paymentChannels;
    _minimumPayoutAmount = minimumPayoutAmount;
    _currency = currency;
    _priceDisplay = priceDisplay;
    _socials = socials;
}

  SettingsResponse.fromJson(dynamic json) {
    _registerMethod = json['register_method'];
    _offlineBankAccount = json['offline_bank_account'] != null ? json['offline_bank_account'].cast<dynamic>() : [];
    //_userLanguage = json['user_language'] != null ? UserLanguage.fromJson(json['user_language']) : null;
    _publicVerificationCode = json['public_verification_code'] != null ? json['public_verification_code'].cast<dynamic>() : [];
    _screenshotCount = json['screenshot_count'];
    _durationSeconds = json['duration_seconds'];
    _showSkip = json['login_skip'];
    _codeLength = json['code_length'];
    _mustUpdateAndroid = json['must_update_android'];
    _mustUpdateIos = json['must_update_ios'];
    _otp = json['otp'];
    _showTicket = json['show_ticket'];
    _visaPayment = json['visa_payment'];
    _iosVersion = json['ios_version'];
    _paymentChannels = json['payment_channels'] != null ? PaymentChannels.fromJson(json['payment_channels']) : null;
    _minimumPayoutAmount = json['minimum_payout_amount'];
    _currency = json['currency'] != null ? Currency.fromJson(json['currency']) : null;
    _priceDisplay = json['price_display'];
    if (json['socials'] != null) {
      _socials = [];
      json['socials'].forEach((v) {
        _socials?.add(Socials.fromJson(v));
      });
    }
  }
  dynamic? _registerMethod;
  List<dynamic>? _offlineBankAccount;
  //UserLanguage? _userLanguage;
  List<dynamic>? _publicVerificationCode;
  dynamic? _screenshotCount;
  dynamic? _durationSeconds;
  bool? _mustUpdateAndroid;
  bool? _showSkip;
  dynamic? _codeLength;
  bool? _mustUpdateIos;
  bool? _otp;
  bool? _showTicket;
  bool? _visaPayment;
  dynamic _iosVersion;
  PaymentChannels? _paymentChannels;
  dynamic? _minimumPayoutAmount;
  Currency? _currency;
  dynamic? _priceDisplay;
  List<Socials>? _socials;
SettingsResponse copyWith({  dynamic? registerMethod,
  List<dynamic>? offlineBankAccount,
  //UserLanguage? userLanguage,
  List<dynamic>? publicVerificationCode,
  dynamic? screenshotCount,
  dynamic? durationSeconds,
  bool? mustUpdateAndroid,
  bool? mustUpdateIos,
  bool? otp,
  bool? showTicket,
  bool? visaPayment,
  dynamic iosVersion,
  PaymentChannels? paymentChannels,
  dynamic? minimumPayoutAmount,
  Currency? currency,
  dynamic? priceDisplay,
  List<Socials>? socials,
}) => SettingsResponse(  registerMethod: registerMethod ?? _registerMethod,
  offlineBankAccount: offlineBankAccount ?? _offlineBankAccount,
  //userLanguage: userLanguage ?? _userLanguage,
  publicVerificationCode: publicVerificationCode ?? _publicVerificationCode,
  screenshotCount: screenshotCount ?? _screenshotCount,
  durationSeconds: durationSeconds ?? _durationSeconds,
  mustUpdateAndroid: mustUpdateAndroid ?? _mustUpdateAndroid,
  mustUpdateIos: mustUpdateIos ?? _mustUpdateIos,
  otp: otp ?? _otp,
  showTicket: showTicket ?? _showTicket,
  visaPayment: visaPayment ?? _visaPayment,
  iosVersion: iosVersion ?? _iosVersion,
  paymentChannels: paymentChannels ?? _paymentChannels,
  minimumPayoutAmount: minimumPayoutAmount ?? _minimumPayoutAmount,
  currency: currency ?? _currency,
  priceDisplay: priceDisplay ?? _priceDisplay,
  socials: socials ?? _socials,
);
  dynamic? get registerMethod => _registerMethod;
  List<dynamic>? get offlineBankAccount => _offlineBankAccount;
  //UserLanguage? get userLanguage => _userLanguage;
  List<dynamic>? get publicVerificationCode => _publicVerificationCode;
  dynamic? get screenshotCount => _screenshotCount;
  dynamic? get durationSeconds => _durationSeconds;
  bool? get mustUpdateAndroid => _mustUpdateAndroid;
  bool? get showSkip => _showSkip;
  bool? get codeLength=>_codeLength;
  bool? get mustUpdateIos => _mustUpdateIos;
  bool? get otp => _otp;
  bool? get showTicket => _showTicket;
  bool? get visaPayment => _visaPayment;
  dynamic get iosVersion => _iosVersion;
  PaymentChannels? get paymentChannels => _paymentChannels;
  dynamic? get minimumPayoutAmount => _minimumPayoutAmount;
  Currency? get currency => _currency;
  dynamic? get priceDisplay => _priceDisplay;
  List<Socials>? get socials => _socials;

  Map<dynamic, dynamic> toJson() {
    final map = <dynamic, dynamic>{};
    map['register_method'] = _registerMethod;
    map['offline_bank_account'] = _offlineBankAccount;
    // if (_userLanguage != null) {
    //   map['user_language'] = _userLanguage?.toJson();
    // }
    map['public_verification_code'] = _publicVerificationCode;
    map['screenshot_count'] = _screenshotCount;
    map['duration_seconds'] = _durationSeconds;
    map['login_skip'] = _showSkip;
    map['code_length'] = _codeLength;
    map['must_update_android'] = _mustUpdateAndroid;
    map['must_update_ios'] = _mustUpdateIos;
    map['otp'] = _otp;
    map['show_ticket'] = _showTicket;
    map['visa_payment'] = _visaPayment;
    map['ios_version'] = _iosVersion;
    if (_paymentChannels != null) {
      map['payment_channels'] = _paymentChannels?.toJson();
    }
    map['minimum_payout_amount'] = _minimumPayoutAmount;
    if (_currency != null) {
      map['currency'] = _currency?.toJson();
    }
    map['price_display'] = _priceDisplay;
    if (_socials != null) {
      map['socials'] = _socials?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// title : "Whatsapp"
/// image : "/store/1/whatsapp.png"
/// link : ["+20 155 766 0273","+20 155 766 0881","01282173740"]
/// order : "1"

Socials socialsFromJson(dynamic str) => Socials.fromJson(json.decode(str));
dynamic socialsToJson(Socials data) => json.encode(data.toJson());
class Socials {
  Socials({
      dynamic? title,
    dynamic? image,
      List<dynamic>? link,
    dynamic? order,}){
    _title = title;
    _image = image;
    _link = link;
    _order = order;
}

  Socials.fromJson(dynamic json) {
    _title = json['title'];
    _image = json['image'];
    _link = json['link'] != null ? json['link'].cast<dynamic>() : [];
    _order = json['order'];
  }
  dynamic? _title;
  dynamic? _image;
  List<dynamic>? _link;
  dynamic? _order;
Socials copyWith({  dynamic? title,
  dynamic? image,
  List<dynamic>? link,
  dynamic? order,
}) => Socials(  title: title ?? _title,
  image: image ?? _image,
  link: link ?? _link,
  order: order ?? _order,
);
  dynamic? get title => _title;
  dynamic? get image => _image;
  List<dynamic>? get link => _link;
  dynamic? get order => _order;

  Map<dynamic, dynamic> toJson() {
    final map = <dynamic, dynamic>{};
    map['title'] = _title;
    map['image'] = _image;
    map['link'] = _link;
    map['order'] = _order;
    return map;
  }

}

/// sign : "جنيه"
/// name : "EGP"

Currency currencyFromJson(dynamic str) => Currency.fromJson(json.decode(str));
dynamic currencyToJson(Currency data) => json.encode(data.toJson());
class Currency {
  Currency({
    dynamic? sign,
    dynamic? name,}){
    _sign = sign;
    _name = name;
}

  Currency.fromJson(dynamic json) {
    _sign = json['sign'];
    _name = json['name'];
  }
  dynamic? _sign;
  dynamic? _name;
Currency copyWith({  dynamic? sign,
  dynamic? name,
}) => Currency(  sign: sign ?? _sign,
  name: name ?? _name,
);
  dynamic? get sign => _sign;
  dynamic? get name => _name;

  Map<dynamic, dynamic> toJson() {
    final map = <dynamic, dynamic>{};
    map['sign'] = _sign;
    map['name'] = _name;
    return map;
  }

}

/// active : [{"id":1,"title":"Paypal","class_name":"Paypal","status":"active","image":"/store/1/default_images/gateways/paypal.png","settings":"","created_at":"1617345734"},{"id":4,"title":"Payu","class_name":"Payu","status":"active","image":"/store/1/default_images/gateways/payu.png","settings":"","created_at":"1617345734"},{"id":5,"title":"Razorpay","class_name":"Razorpay","status":"active","image":"/store/1/default_images/gateways/razorpay.png","settings":"","created_at":"1617345734"}]

PaymentChannels paymentChannelsFromJson(dynamic str) => PaymentChannels.fromJson(json.decode(str));
dynamic paymentChannelsToJson(PaymentChannels data) => json.encode(data.toJson());
class PaymentChannels {
  PaymentChannels({
      List<Active>? active,}){
    _active = active;
}

  PaymentChannels.fromJson(dynamic json) {
    if (json['active'] != null) {
      _active = [];
      json['active'].forEach((v) {
        _active?.add(Active.fromJson(v));
      });
    }
  }
  List<Active>? _active;
PaymentChannels copyWith({  List<Active>? active,
}) => PaymentChannels(  active: active ?? _active,
);
  List<Active>? get active => _active;

  Map<dynamic, dynamic> toJson() {
    final map = <dynamic, dynamic>{};
    if (_active != null) {
      map['active'] = _active?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// title : "Paypal"
/// class_name : "Paypal"
/// status : "active"
/// image : "/store/1/default_images/gateways/paypal.png"
/// settings : ""
/// created_at : "1617345734"

Active activeFromJson(dynamic str) => Active.fromJson(json.decode(str));
dynamic activeToJson(Active data) => json.encode(data.toJson());
class Active {
  Active({
    dynamic? id,
    dynamic? title,
    dynamic? className,
    dynamic? status,
    dynamic? image,
    dynamic? settings,
    dynamic? createdAt,}){
    _id = id;
    _title = title;
    _className = className;
    _status = status;
    _image = image;
    _settings = settings;
    _createdAt = createdAt;
}

  Active.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _className = json['class_name'];
    _status = json['status'];
    _image = json['image'];
    _settings = json['settings'];
    _createdAt = json['created_at'];
  }
  dynamic? _id;
  dynamic? _title;
  dynamic? _className;
  dynamic? _status;
  dynamic? _image;
  dynamic? _settings;
  dynamic? _createdAt;
Active copyWith({  num? id,
  dynamic? title,
  dynamic? className,
  dynamic? status,
  dynamic? image,
  dynamic? settings,
  dynamic? createdAt,
}) => Active(  id: id ?? _id,
  title: title ?? _title,
  className: className ?? _className,
  status: status ?? _status,
  image: image ?? _image,
  settings: settings ?? _settings,
  createdAt: createdAt ?? _createdAt,
);
  dynamic? get id => _id;
  dynamic? get title => _title;
  dynamic? get className => _className;
  dynamic? get status => _status;
  dynamic? get image => _image;
  dynamic? get settings => _settings;
  dynamic? get createdAt => _createdAt;

  Map<dynamic, dynamic> toJson() {
    final map = <dynamic, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['class_name'] = _className;
    map['status'] = _status;
    map['image'] = _image;
    map['settings'] = _settings;
    map['created_at'] = _createdAt;
    return map;
  }

}

/// AR : "Arabic"

// UserLanguage userLanguageFromJson(dynamic str) => UserLanguage.fromJson(json.decode(str));
// dynamic userLanguageToJson(UserLanguage data) => json.encode(data.toJson());
// class UserLanguage {
//   UserLanguage({
//     dynamic? ar,}){
//     _ar = ar;
// }
//
//   UserLanguage.fromJson(dynamic json) {
//     _ar = json['AR'];
//   }
//   dynamic? _ar;
// UserLanguage copyWith({  dynamic? ar,
// }) => UserLanguage(  ar: ar ?? _ar,
// );
//   dynamic? get ar => _ar;
//
//   Map<dynamic, dynamic> toJson() {
//     final map = <dynamic, dynamic>{};
//     map['AR'] = _ar;
//     return map;
//   }
//
// }