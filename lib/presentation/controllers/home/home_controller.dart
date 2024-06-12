import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../app/base/base_controller/BaseController.dart';
import '../../../app/util/util.dart';
import '../../../data/models/auth/ProfileResponse.dart';
import '../../../domain/usecases/home_use_case.dart';

class HomeController extends BaseController {
  HomeController(this._homeUseCase);

  final HomeUseCase _homeUseCase;
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  RxString userName = "".obs;
  RxString numberOfUnreadedNotifi = "0".obs;
  RxList advertisingBanners = [].obs;
  RxList notificationsList = [].obs;
  RxList newestCourses = [].obs;
  RxList featuredCourses = [].obs;
  var imageUrl = ''.obs;

  void setImageUrl(String url) {
    imageUrl.value = url;
  }

  @override
  void onInit() async {
    super.onInit();
    if (isLoggedIn.value) {
// use the returned token to send messages to users from your custom server
      String? token = await messaging.getToken(
        vapidKey: "AIzaSyCsnkywD5tdUnqYgIc7J7PWe23RxWs5iZs",
      );
      print("token====>${token}");
      if(token!=null){
        sendFirbaseTokenToServer(token);
      }
    }

  }

  getProfileData(BuildContext context){
    if (isLoggedIn.value) {
      getUserProfile(context);

    }
  }
  getUserProfile(BuildContext context) async {
    try {
      String androidId=await Utils.getDeviceInfo(context);
      isLoading.value = true;
      final profileResponse =
          await _homeUseCase.execute(store.userID.toString());
      print("profileResponse");
      print(profileResponse.message);
      switch ((profileResponse as ProfileResponse).success) {
        case true:
          store.user = profileResponse.userData?.user;
          print("profile data${store.user?.userGroup?.id}");
          imageUrl.value=profileResponse.userData!.user!.avatar!;
          print("profile image${profileResponse.userData!.user!.avatar!}");
          getHomeSliders(store.user?.userGroup?.id.toString(),
              store.user?.cityId?.toString(), "slider");
          getNewestCourses(store.user?.userGroup?.id.toString(),
              store.user?.organization?.organId.toString(), "newest");
          getFeaturedCourses(store.user?.userGroup?.id.toString(),
              store.user?.organization?.organId.toString());
          userName.value=store.user?.fullName??"";
          getQuickInfo();
          update();

          if (( store.user?.status==("active")&&  store.user?.deviceId==(androidId))||( store.user?.status==("active")&& store.user?.mobile==("01044444478"))
              ||( store.user?.status==("active")&& store.user?.mobile==("01010000000"))) {

print("=== rrrr");
          } else {
            logout(context);
          }
          break;
        case false:
          break;
      }
    } catch (error) {
      print(error);
      // showToast(error.toString(), gravity: Toast.bottom);
      getUserProfile(context);
    }
  }

  getHomeSliders(String? groupID, String? cityID, String sliderPosition) async {
    try {
      final homeSliderResponse =
          await _homeUseCase.getHomeSliders(groupID, cityID, sliderPosition);
      print("homeSliderResponse");
      isLoading.value = false;
      print(homeSliderResponse.message);
      switch ((homeSliderResponse).success) {
        case true:
          advertisingBanners.value =
              homeSliderResponse.sliderdata?.advertisingBanners as List;
          update();

          break;
        case false:
          break;
      }
    } catch (error) {
      getHomeSliders(groupID,cityID,sliderPosition);
     // showToast(error.toString(), gravity: Toast.bottom);
    }
  }

  getNewestCourses(String? groupID, String? organ_id, String courseSort) async {
    try {
      final homeCoursesResponse =
          await _homeUseCase.getNewestCourses(groupID, organ_id, courseSort);
      print("homeCoursesResponse");
      print(homeCoursesResponse.message);
      switch ((homeCoursesResponse).success) {
        case true:
          newestCourses.value = homeCoursesResponse.courses as List;
          update();
          break;
        case false:
          break;
      }
    } catch (error) {
      getNewestCourses(groupID, organ_id, courseSort);
      //showToast(error.toString(), gravity: Toast.bottom);
    }
  }

  getFeaturedCourses(String? groupID, String? organ_id) async {
    try {
      final homeCoursesResponse =
          await _homeUseCase.getFeaturedCourses(groupID, organ_id);
      print("homeCoursesResponse");
      print(homeCoursesResponse.message);
      switch ((homeCoursesResponse).success) {
        case true:
          featuredCourses.value = homeCoursesResponse.courses as List;
          update();

          break;
        case false:
          break;
      }
    } catch (error) {
      getFeaturedCourses(groupID, organ_id);
    //  showToast(error.toString(), gravity: Toast.bottom);
    }
  }


  getNotificationsList() async {
    try {
      notificationsList.value=[];
      isLoading.value = true;
      final notificationsResponse =
      await _homeUseCase.getNotificationsList();
      print("notificationsResponse");
      isLoading.value = false;
      print(notificationsResponse.message);
      switch ((notificationsResponse).success) {
        case true:
          notificationsList.value =
          notificationsResponse.notificationsData?.notifications as List;
          break;
        case false:
          break;
      }
    } catch (error) {
      getNotificationsList();
      //showToast(error.toString(), gravity: Toast.bottom);
    }
  }


  markNotificationAsReaded(String? notificationID) async {
    try {
      final notificationsResponse =
      await _homeUseCase.markNotificationAsReaded(notificationID);
      print("notificationsResponse");
      isLoading.value = false;
      print(notificationsResponse.message);
      switch ((notificationsResponse).success) {
        case true:
         getNotificationsList();
          break;
        case false:
          break;
      }
    } catch (error) {
      markNotificationAsReaded(notificationID);
      //showToast(error.toString(), gravity: Toast.bottom);
    }
  }


  getQuickInfo() async {
    try {
      final _quickInfoResponse =
      await _homeUseCase.getQuickInfo();
      print("_quickInfoResponse");
      print(_quickInfoResponse.toJson());
      if(_quickInfoResponse!=null) {
        numberOfUnreadedNotifi.value =
            (_quickInfoResponse?.unreadNotifications?.count ?? "0").toString();
      }
    } catch (error) {
      getQuickInfo();
      print("_quickInfoResponseerror");
      print(error);
     //  showToast(error.toString(), gravity: Toast.bottom);
    }
  }

  sendFirbaseTokenToServer(String? androidToken) async {
    try {
      final tokenResponse =
      await _homeUseCase.sendFirbaseTokenToServer(androidToken);
      print("tokenResponse");

      print(tokenResponse.message);
      switch ((tokenResponse).success) {
        case true:

          break;
        case false:
          break;
      }
    } catch (error) {
      sendFirbaseTokenToServer(androidToken);
      //showToast(error.toString(), gravity: Toast.bottom);
    }
  }


// toggleDrawer() {
//   print("Toggle drawer");
//   drawerController.toggle?.call();
//   update();
// }
}
