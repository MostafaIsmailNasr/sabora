import '../../domain/repositories/home_repository.dart';
import '../models/BaseResponse.dart';
import '../models/auth/ProfileResponse.dart';
import '../models/home/featured_courses/HomeCoursesResponse.dart';
import '../models/home/slider/HomeSliderResponse.dart';
import '../models/notifications/NotificationsResponse.dart';
import '../models/quick_info/quickInfo.dart';
import '../providers/network/apis/home_api.dart';

class HomeRepositoryIml extends HomeRepository {



  @override
  Future<ProfileResponse> getUserProfile(String userId) async{
    print(userId);

    var response = await HomeAPI.getUserProfile(userId).request();
    print(response);
    return ProfileResponse.fromJson(response);
  }


  @override
  Future<HomeSliderResponse> getHomeSliders(String? groupID, String? cityID, String sliderPosition) async{
    var response = await   HomeAPI.getHomeSliders(groupID,cityID,sliderPosition).request();
    print(response);
    return HomeSliderResponse.fromJson(response);
  }

  @override
  Future<HomeCoursesResponse> getFeaturedCourses(String? groupID, String? organ_id) async{
    var response = await   HomeAPI.getFeaturedCourses(groupID,organ_id).request();
    print(response);
    return HomeCoursesResponse.fromJson(response);
  }

  @override
  Future<HomeCoursesResponse> getNewestCourses(String? groupID, String? organ_id, String courseSort)async {
    var response = await   HomeAPI.getNewestCourses(groupID,organ_id,courseSort).request();
    print(response);
    return HomeCoursesResponse.fromJson(response);
  }

  @override
  Future<NotificationsResponse> getNotificationsList() async{
    var response = await   HomeAPI.getNotificationsList().request();
    print(response);
    return NotificationsResponse.fromJson(response);
  }

  @override
  Future<BaseResponse> sendFirbaseTokenToServer(String? androidToken)async {
    var response = await   HomeAPI.sendFirbaseTokenToServer(androidToken).request();
    print(response);
    return BaseResponse.fromJson(response);
  }

  @override
  Future<QuickInfoResponse> getQuickInfo() async{
    var response = await   HomeAPI.getQuickInfo().request();
    print(response);
    return QuickInfoResponse.fromJson(response);
  }

  @override
  Future<BaseResponse> markNotificationAsReaded(String? notificationID)async {
    var response = await   HomeAPI.markNotificationAsReaded(notificationID).request();
    print(response);
    return BaseResponse.fromJson(response);
  }
}
