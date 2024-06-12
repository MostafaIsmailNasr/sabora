import '../categories/Categories.dart';
import 'UserGroup.dart';
import 'Organization.dart';
import 'City.dart';

class Following {
  Following({
      this.id, 
      this.fullName, 
      this.roleName, 
      this.facebook, 
      this.mobile, 
      this.parentMobile, 
      this.deviceId, 
      this.sonCoursesCount, 
      this.sonQuizzesCount, 
      this.bio, 
      this.offline, 
      this.offlineMessage, 
      this.verified, 
      this.isVerified, 
      this.rate, 
      this.avatar, 
      this.meetingStatus, 
      this.authUserIsFollower, 
      this.address, 
      this.gender, 
      this.categories, 
      this.userGroup, 
      this.organization, 
      this.city,});

  Following.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['full_name'];
    roleName = json['role_name'];
    facebook = json['facebook'];
    mobile = json['mobile'];
    parentMobile = json['parent_mobile'];
    deviceId = json['device_id'];
    sonCoursesCount = json['son_courses_count'];
    sonQuizzesCount = json['son_quizzes_count'];
    bio = json['bio'];
    offline = json['offline'];
    offlineMessage = json['offline_message'];
    verified = json['verified'];
    isVerified = json['is_verified'];
    rate = json['rate'];
    avatar = json['avatar'];
    meetingStatus = json['meeting_status'];
    authUserIsFollower = json['auth_user_is_follower'];
    address = json['address'];
    gender = json['gender'];
    categories = json['categories'] != null ? Categories.fromJson(json['categories']) : null;
    userGroup = json['user_group'] != null ? UserGroup.fromJson(json['user_group']) : null;
    organization = json['organization'] != null ? Organization.fromJson(json['organization']) : null;
    city = json['city'] != null ? City.fromJson(json['city']) : null;
  }
  int? id;
  String? fullName;
  String? roleName;
  dynamic facebook;
  String? mobile;
  dynamic parentMobile;
  String? deviceId;
  int? sonCoursesCount;
  int? sonQuizzesCount;
  String? bio;
  int? offline;
  dynamic offlineMessage;
  int? verified;
  int? isVerified;
  String? rate;
  String? avatar;
  String? meetingStatus;
  bool? authUserIsFollower;
  dynamic address;
  dynamic gender;
  Categories? categories;
  UserGroup? userGroup;
  Organization? organization;
  City? city;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['full_name'] = fullName;
    map['role_name'] = roleName;
    map['facebook'] = facebook;
    map['mobile'] = mobile;
    map['parent_mobile'] = parentMobile;
    map['device_id'] = deviceId;
    map['son_courses_count'] = sonCoursesCount;
    map['son_quizzes_count'] = sonQuizzesCount;
    map['bio'] = bio;
    map['offline'] = offline;
    map['offline_message'] = offlineMessage;
    map['verified'] = verified;
    map['is_verified'] = isVerified;
    map['rate'] = rate;
    map['avatar'] = avatar;
    map['meeting_status'] = meetingStatus;
    map['auth_user_is_follower'] = authUserIsFollower;
    map['address'] = address;
    map['gender'] = gender;
    if (categories != null) {
      map['categories'] = categories!.toJson();
    }
    if (userGroup != null) {
      map['user_group'] = userGroup!.toJson();
    }
    if (organization != null) {
      map['organization'] = organization!.toJson();
    }
    if (city != null) {
      map['city'] = city!.toJson();
    }
    return map;
  }

}