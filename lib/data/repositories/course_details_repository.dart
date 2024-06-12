import '../../domain/entities/user.dart';
import '../../domain/repositories/course_details_repository.dart';
import '../models/BaseResponse.dart';
import '../models/auth/ProfileResponse.dart';
import '../models/course_details/CourseContentResponse.dart';
import '../models/course_details/CourseDetailsResponse.dart';
import '../models/course_details/enroll_course/CheckCartResponse.dart';
import '../models/course_details/enroll_course/validate_coupon/ValidateCouponResponse.dart';
import '../models/course_details/reviews/CourseReviewResponse.dart';
import '../models/favourits/FavouritsResponse.dart';
import '../models/my_comments/CommentRequest.dart';
import '../models/my_comments/MyCommentsResponse.dart';
import '../models/my_quizes_results/QuizDetailsResponse.dart';
import '../models/rate/RateRequest.dart';
import '../providers/network/apis/auth_api.dart';
import '../providers/network/apis/course_api.dart';

class CourseDetailsRepositoryIml extends CourseDetailsRepository {
  @override
  Future<User> signUp(String username) async {
    //Fake sign up action
    await Future.delayed(Duration(seconds: 1));
    return User(username: username);
  }

  @override
  Future<ProfileResponse> getUserProfile(String userId) async{
    print(userId);

    var response = await AuthAPI.getUserProfile(userId).request();
    print(response);
    return ProfileResponse.fromJson(response);
  }



  @override
  Future<CheckCartResponse> checkCartData(int? groupID) async{
    var response = await CourseAPI.checkCartData(groupID).request();
    print(response);
    return CheckCartResponse.fromJson(response);
  }

  @override
  Future<BaseResponse> addCourseToCart(String courseId) async{
    var response = await CourseAPI.addCourseToCart(courseId).request();
    print(response);
    return BaseResponse.fromJson(response);
  }

  @override
  Future<BaseResponse> checkoutCourse(String coupon, String discountID) async{
    var response = await CourseAPI.checkoutCourse(coupon,discountID).request();
    print(response);
    return BaseResponse.fromJson(response);
  }

  @override
  Future<BaseResponse> deleteCart(String cartID) async{
    var response = await CourseAPI.deleteCart(cartID).request();
    print(response);
    return BaseResponse.fromJson(response);
  }

  @override
  Future<ValidateCouponResponse> validateCourseCoupon(String coupon) async{
    var response = await CourseAPI.validateCourseCoupon(coupon).request();
    print(response);
    return ValidateCouponResponse.fromJson(response);
  }

  @override
  Future<FavouritsResponse> getFavourits(String organID)async {
    var response = await CourseAPI.getFavourits(organID).request();
    print(response);
    return FavouritsResponse.fromJson(response);
  }

  @override
  Future<BaseResponse> toggleFavourite(String courseID) async{
    var response = await CourseAPI.toggleFavourite(courseID).request();
    print(response);
    return BaseResponse.fromJson(response);
  }


  @override
  Future<BaseResponse> addCourseComment(CommentRequest? commentRequest) async{
    var response = await CourseAPI.addCourseComment(commentRequest).request();
    print("response==>");
    print(response);
    return BaseResponse.fromJson(response);
  }

  @override
  Future<BaseResponse> addCourseRate(RateRequest? rateRequest)async {
    var response = await CourseAPI.addCourseRate(rateRequest).request();
    print(response);
    return BaseResponse.fromJson(response);
  }

  @override
  Future<CourseDetailsResponse> getCourseDetails(String courseID)async {
    var response = await CourseAPI.getCourseDetails(courseID).request();
    print(response);
    return CourseDetailsResponse.fromJson(response);
  }

  @override
  Future<CourseContentResponse> getCourseContents(String courseID) async{
    var response = await CourseAPI.getCourseContents(courseID).request();
    print(response);
    return CourseContentResponse.fromJson(response);
  }

  @override
  Future<MyCommentsResponse> getMyComments(String? commentType, String? fileID,int? page,int? pageSize) async {
    var response = await CourseAPI.getMyComments(commentType,fileID,page,pageSize).request();
    print(response);
    return MyCommentsResponse.fromJson(response);
  }

  @override
  Future<BaseResponse> sendUserViewToServer(String? fileID,String? courseID)async {
    var response = await CourseAPI.sendUserViewToServer(fileID,courseID).request();
    print(response);
    return BaseResponse.fromJson(response);
  }

  @override
  Future<CourseReviewResponse> getCourseReviews(String? courseID) async{
    var response = await CourseAPI.getCourseReviews(courseID).request();
    print(response);
    return CourseReviewResponse.fromJson(response);
  }

  @override
  Future<QuizDetailsResponse> getQuizDetails(String? quizID)async {
    var response = await CourseAPI.getQuizDetails(quizID).request();
    print(response);
    return QuizDetailsResponse.fromJson(response);
  }

  @override
  Future<BaseResponse> addFreeCourse(String? courseID) async{
    var response = await CourseAPI.addFreeCourse(courseID).request();
    print(response);
    return BaseResponse.fromJson(response);
  }

}
