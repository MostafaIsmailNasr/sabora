import 'dart:io';

import 'package:get/get.dart';

import '../../../../app/services/local_storage.dart';
import '../api_endpoint.dart';
import '../api_provider.dart';
import '../api_request_representable.dart';

enum AuthType {
  slider,
  newestCourse,
  featuredCourse,
  login,
  logout,
  userProfile,
  settings,
  register,
  registerStep3,
  forgetPass,
  resetPass,
  verifyUser,
  educationLevels,
  notifications,
  androidToken,
  quickInfo,
  notificationRead,
  governorate
}

class HomeAPI implements APIRequestRepresentable {
  final AuthType type;
  final storage = Get.find<LocalStorageService>();

  Map<String, dynamic>? loginRequest;

  String? cityId;
  String? groupId;
  String? sliderPosition;
  String? userID;
  String? androidToken;
  String? notificationID;

  String? organ_id;
  String? courseSort;

  HomeAPI._(
      {required this.type,
      this.loginRequest,
      this.groupId,
      this.sliderPosition,
      this.cityId,
      this.userID,
      this.androidToken,
      this.notificationID,
      this.organ_id,
      this.courseSort});

  HomeAPI.getUserProfile(String userID)
      : this._(userID: userID, type: AuthType.userProfile);

  HomeAPI.getHomeSliders(String? groupID, String? cityID, String sliderPosition)
      : this._(
            groupId: groupID,
            cityId: cityID,
            sliderPosition: sliderPosition,
            type: AuthType.slider);

  HomeAPI.getNewestCourses(String? groupID, String? orgId, String? courseSort)
      : this._(
            groupId: groupID,
            organ_id: orgId,
            courseSort: courseSort,
            type: AuthType.newestCourse);

  HomeAPI.getFeaturedCourses(String? groupID, String? orgId)
      : this._(
            groupId: groupID, organ_id: orgId, type: AuthType.featuredCourse);


  HomeAPI.getNotificationsList()
      : this._(type: AuthType.notifications);

  HomeAPI.sendFirbaseTokenToServer(String? androidToken)
      : this._(
      androidToken: androidToken, type: AuthType.androidToken);

  HomeAPI.markNotificationAsReaded(String? notificationID)
      : this._(
      notificationID: notificationID, type: AuthType.notificationRead);


  HomeAPI.getQuickInfo()
      : this._(type: AuthType.quickInfo);


  @override
  String get endpoint => APIEndpoint.apiURL;

  String get path {
    switch (type) {
      case AuthType.slider:
        return "/development/advertising-banner";
      case AuthType.userProfile:
        return "/development/users/${userID}/profile";
      case AuthType.newestCourse:
        return "/development/courses";
      case AuthType.featuredCourse:
        return "/development/featured-courses";
      case AuthType.notifications:
        return "/development/panel/notifications";
      case AuthType.androidToken:
        return "/development/users/update_device_token";

      case AuthType.quickInfo:
        return "/development/panel/quick-info";

      case AuthType.notificationRead:
        return "/development/panel/notifications/${notificationID}/seen";

      default:
        return "";
    }
  }

  @override
  HTTPMethod get method {
    switch (type) {
      case AuthType.userProfile:
      case AuthType.slider:
      case AuthType.newestCourse:
      case AuthType.featuredCourse:
      case AuthType.notifications:
      case AuthType.quickInfo:
        return HTTPMethod.get;
      default:
        return HTTPMethod.post;
    }
  }

  Map<String, String> get headers => {
        HttpHeaders.contentTypeHeader: 'application/json',
        'x-api-key': '1234321',
        "User-Agent": "PostmanRuntime/7.31.3",
        "Accept": "*/*",
    "X-Locale" : storage.lang??"ar",
        "Connection": "keep-alive",
        "Authorization":
            "Bearer " + (storage.apiToken == null ? "" : storage.apiToken!)
      };

  Map<String, String> get query {
    switch (type) {
      case AuthType.slider:
        return {
          HttpHeaders.contentTypeHeader: 'application/json',
          "group_id": groupId.toString(),
          "city_id": cityId.toString(),
          "position": sliderPosition.toString()
        };
      case AuthType.newestCourse:
        return {
          HttpHeaders.contentTypeHeader: 'application/json',
          "group_id": groupId.toString(),
          "organ_id": organ_id.toString(),
          "sort": courseSort.toString()
        };
      case AuthType.featuredCourse:
        return {
          HttpHeaders.contentTypeHeader: 'application/json',
          "group_id": groupId.toString(),
          "organ_id": organ_id.toString(),
        };
      default:
        return {HttpHeaders.contentTypeHeader: 'application/json'};
    }
  }

  @override
  Map<dynamic, dynamic>? get body {
    switch (type) {
      case AuthType.login:
        return loginRequest;
      case AuthType.androidToken:
        return <String,String?>{
          "android_token"  : androidToken
        };

      default:
        return null;
    }
  }

  Future request() {
    return APIProvider.instance.request(this);
  }

  @override
  String get url => endpoint + path;

  @override
  String? get contentType => null;





}
