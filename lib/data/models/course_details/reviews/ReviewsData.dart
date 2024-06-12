import '../../auth/User.dart';
import '../enroll_course/RateType.dart';

class ReviewsData {
  ReviewsData({
      this.id, 
      this.auth, 
      this.user, 
      this.createAt,
      this.image,
      this.voice,
      this.description,
      this.rate, 
      this.rateType, 
      this.replies,});

  ReviewsData.fromJson(dynamic json) {
    id = json['id'];
    auth = json['auth'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    image = json['image'] != null ? json['user']: null;
    voice = json['voice'] != null ? json['voice']: null;
    createAt = json['created_at'];
    description = json['description'];
    rate = json['rate'];
    rateType = json['rate_type'] != null ? RateType.fromJson(json['rate_type']) : null;
    if (json['replies'] != null) {
      replies = [];
      replies!.map((v) => v.toJson()).toList();
    }
  }
  int? id;
  bool? auth;
  User? user;
  int? createAt;
  String? description;
  String? rate;
  String? image;
  String? voice;
  RateType? rateType;
  List<dynamic>? replies;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['auth'] = auth;
    if (user != null) {
      map['user'] = user!.toJson();
    }
    map['created_at'] = createAt;
    map['description'] = description;
    map['rate'] = rate;
    if (rateType != null) {
      map['rate_type'] = rateType!.toJson();
    }
    if (replies != null) {
      map['replies'] = replies!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}