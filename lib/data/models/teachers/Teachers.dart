import '../auth/Badges.dart';
import '../auth/City.dart';
import '../auth/Organization.dart';
import '../auth/UserGroup.dart';
import '../home/course_details/Course.dart';

import '../categories/Categories.dart';

class Teachers {
  Teachers({
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
      this.city, 
      this.status, 
      this.email, 
      this.language, 
      this.newsletter, 
      this.publicMessage, 
      this.activeSubscription, 
      this.headline, 
      this.coursesCount, 
      this.reviewsCount, 
      this.appointmentsCount, 
      this.studentsCount, 
      this.followersCount, 
      this.followingCount, 
      this.badges, 
      this.followers, 
      this.following, 
      this.referral, 
      this.education, 
      this.experience, 
      this.occupations, 
      this.about, 
      this.webinars, 
      this.meeting, 
      this.organizationTeachers, 
      this.countryId, 
      this.provinceId, 
      this.cityId, 
      this.districtId, 
      this.accountType, 
      this.iban, 
      this.accountId, 
      this.identityScan, 
      this.certificate,});

  Teachers.fromJson(dynamic json) {
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
    status = json['status'];
    email = json['email'];
    language = json['language'];
    newsletter = json['newsletter'];
    publicMessage = json['public_message'];
    activeSubscription = json['active_subscription'];
    headline = json['headline'];
    coursesCount = json['courses_count'];
    reviewsCount = json['reviews_count'];
    appointmentsCount = json['appointments_count'];
    studentsCount = json['students_count'];
    followersCount = json['followers_count'];
    followingCount = json['following_count'];
    if (json['badges'] != null) {
      badges = [];
      json['badges'].forEach((v) {
        badges!.add(Badges.fromJson(v));
      });
    }
    if (json['followers'] != null) {
      followers = [];
      json['followers'].forEach((v) {
        //followers.add(Dynamic.fromJson(v));
      });
    }
    if (json['following'] != null) {
      following = [];
      json['following'].forEach((v) {
        //following.add(Dynamic.fromJson(v));
      });
    }
    referral = json['referral'];
    if (json['education'] != null) {
      education = [];
      json['education'].forEach((v) {
       // education.add(Dynamic.fromJson(v));
      });
    }
    if (json['experience'] != null) {
      experience = [];
      json['experience'].forEach((v) {
       // experience.add(Dynamic.fromJson(v));
      });
    }
    if (json['occupations'] != null) {
      occupations = [];
      json['occupations'].forEach((v) {
        //occupations.add(Dynamic.fromJson(v));
      });
    }
    about = json['about'];
    if (json['webinars'] != null) {
      webinars = [];
      json['webinars'].forEach((v) {
        webinars!.add(Course.fromJson(v));
      });
    }
    meeting = json['meeting'];
    if (json['organization_teachers'] != null) {
      organizationTeachers = [];
      json['organization_teachers'].forEach((v) {
       // organizationTeachers!.add(Dynamic.fromJson(v));
      });
    }
    countryId = json['country_id'];
    provinceId = json['province_id'];
    cityId = json['city_id'];
    districtId = json['district_id'];
    accountType = json['account_type'];
    iban = json['iban'];
    accountId = json['account_id'];
    identityScan = json['identity_scan'];
    certificate = json['certificate'];
  }
  int? id;
  String? fullName;
  String? roleName;
  dynamic facebook;
  String? mobile;
  dynamic parentMobile;
  dynamic deviceId;
  int? sonCoursesCount;
  int? sonQuizzesCount;
  dynamic bio;
  int? offline;
  dynamic offlineMessage;
  int? verified;
  int? isVerified;
  String? rate;
  String? avatar;
  String? meetingStatus;
  bool? authUserIsFollower;
  dynamic address;
  String? gender;
  Categories? categories;
  UserGroup? userGroup;
  Organization? organization;
  City? city;
  String? status;
  String? email;
  dynamic language;
  bool? newsletter;
  int? publicMessage;
  dynamic activeSubscription;
  dynamic headline;
  int? coursesCount;
  int? reviewsCount;
  int? appointmentsCount;
  int? studentsCount;
  int? followersCount;
  int? followingCount;
  List<Badges>? badges;
  List<dynamic>? followers;
  List<dynamic>? following;
  dynamic referral;
  List<dynamic>? education;
  List<dynamic>? experience;
  List<dynamic>? occupations;
  dynamic about;
  List<Course>? webinars;
  dynamic meeting;
  List<dynamic>? organizationTeachers;
  dynamic countryId;
  dynamic provinceId;
  dynamic cityId;
  dynamic districtId;
  dynamic accountType;
  dynamic iban;
  dynamic accountId;
  dynamic identityScan;
  dynamic certificate;

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
    map['status'] = status;
    map['email'] = email;
    map['language'] = language;
    map['newsletter'] = newsletter;
    map['public_message'] = publicMessage;
    map['active_subscription'] = activeSubscription;
    map['headline'] = headline;
    map['courses_count'] = coursesCount;
    map['reviews_count'] = reviewsCount;
    map['appointments_count'] = appointmentsCount;
    map['students_count'] = studentsCount;
    map['followers_count'] = followersCount;
    map['following_count'] = followingCount;
    if (badges != null) {
      map['badges'] = badges!.map((v) => v.toJson()).toList();
    }
    if (followers != null) {
      map['followers'] = followers!.map((v) => v.toJson()).toList();
    }
    if (following != null) {
      map['following'] = following!.map((v) => v.toJson()).toList();
    }
    map['referral'] = referral;
    if (education != null) {
      map['education'] = education!.map((v) => v.toJson()).toList();
    }
    if (experience != null) {
      map['experience'] = experience!.map((v) => v.toJson()).toList();
    }
    if (occupations != null) {
      map['occupations'] = occupations!.map((v) => v.toJson()).toList();
    }
    map['about'] = about;
    if (webinars != null) {
      map['webinars'] = webinars!.map((v) => v.toJson()).toList();
    }
    map['meeting'] = meeting;
    if (organizationTeachers != null) {
      map['organization_teachers'] = organizationTeachers!.map((v) => v.toJson()).toList();
    }
    map['country_id'] = countryId;
    map['province_id'] = provinceId;
    map['city_id'] = cityId;
    map['district_id'] = districtId;
    map['account_type'] = accountType;
    map['iban'] = iban;
    map['account_id'] = accountId;
    map['identity_scan'] = identityScan;
    map['certificate'] = certificate;
    return map;
  }

}