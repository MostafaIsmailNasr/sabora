import '../../data/models/BaseResponse.dart';
import '../../data/models/auth/ProfileResponse.dart';
import '../../data/models/home/featured_courses/HomeCoursesResponse.dart';
import '../../data/models/home/slider/HomeSliderResponse.dart';
import '../../data/models/notifications/NotificationsResponse.dart';
import '../../data/models/quick_info/quickInfo.dart';

abstract class HomeRepository {

  Future<ProfileResponse> getUserProfile(String userId);

  Future<HomeSliderResponse> getHomeSliders(String? groupID,String? cityID,String sliderPosition);

  Future<HomeCoursesResponse> getNewestCourses(String? groupID,String? organ_id,String courseSort);

  Future<HomeCoursesResponse> getFeaturedCourses(String? groupID,String? organ_id);

  Future<NotificationsResponse> getNotificationsList();

  Future<BaseResponse> sendFirbaseTokenToServer(String? androidToken);

  Future<QuickInfoResponse> getQuickInfo();

  Future<BaseResponse> markNotificationAsReaded(String? notificationID) ;
}
