import '../../app/core/usecases/pram_usecase.dart';
import '../../data/models/BaseResponse.dart';
import '../../data/models/auth/ProfileResponse.dart';
import '../../data/models/home/featured_courses/HomeCoursesResponse.dart';
import '../../data/models/home/slider/HomeSliderResponse.dart';
import '../../data/models/notifications/NotificationsResponse.dart';
import '../../data/models/quick_info/quickInfo.dart';
import '../repositories/home_repository.dart';

class HomeUseCase extends ParamUseCase<ProfileResponse, String> {
  final HomeRepository _repo;
  HomeUseCase(this._repo);

  @override
  Future<ProfileResponse> execute(String userID) {
    return _repo.getUserProfile(userID);
  }

  @override
  Future<HomeSliderResponse> getHomeSliders(String? groupID,String? cityID,String sliderPosition) {
    return _repo.getHomeSliders(groupID,cityID,sliderPosition);
  }

  @override
  Future<HomeCoursesResponse> getNewestCourses(String? groupID,String? organ_id,String courseSort){
    return _repo.getNewestCourses(groupID,organ_id,courseSort);
  }

  @override
  Future<HomeCoursesResponse> getFeaturedCourses(String? groupID,String? organ_id){
    return _repo.getFeaturedCourses(groupID,organ_id);
  }

  @override
  Future<NotificationsResponse> getNotificationsList(){
    return _repo.getNotificationsList();
  }

  @override
  Future<BaseResponse> sendFirbaseTokenToServer(String? androidToken){
    return _repo.sendFirbaseTokenToServer(androidToken);
  }


  @override
  Future<QuickInfoResponse> getQuickInfo(){
    return _repo.getQuickInfo();
  }


  @override
  Future<BaseResponse> markNotificationAsReaded(String? notificationID){
    return _repo.markNotificationAsReaded(notificationID);
  }



}
