import '../../data/models/BaseResponse.dart';
import '../../data/models/auth/ProfileResponse.dart';
import '../../data/models/course_details/CourseContentResponse.dart';
import '../../data/models/course_details/CourseDetailsResponse.dart';
import '../../data/models/course_details/enroll_course/CheckCartResponse.dart';
import '../../data/models/course_details/enroll_course/validate_coupon/ValidateCouponResponse.dart';
import '../../data/models/course_details/reviews/CourseReviewResponse.dart';
import '../../data/models/favourits/FavouritsResponse.dart';
import '../../data/models/my_comments/CommentRequest.dart';
import '../../data/models/my_comments/MyCommentsResponse.dart';
import '../../data/models/my_quizes_results/QuizDetailsResponse.dart';
import '../../data/models/rate/RateRequest.dart';
import '../entities/user.dart';

abstract class CourseDetailsRepository {
  Future<User> signUp(String username);
  Future<ProfileResponse> getUserProfile(String userId);

  Future<CheckCartResponse> checkCartData(int? groupID);
  Future<BaseResponse> addCourseToCart(String courseId);

  Future<BaseResponse> deleteCart(String cartID);

  Future<BaseResponse> checkoutCourse(String coupon,String discountID);


  Future<ValidateCouponResponse> validateCourseCoupon(String coupon);

  Future<FavouritsResponse> getFavourits(String organID);

  Future<BaseResponse> toggleFavourite(String courseID);

  Future<BaseResponse> addCourseComment(CommentRequest? commentRequest);

  Future<BaseResponse> addCourseRate(RateRequest? rateRequest);

  Future<CourseDetailsResponse> getCourseDetails(String courseID);

  Future<CourseContentResponse> getCourseContents(String courseID);

  Future<MyCommentsResponse> getMyComments(String? commentType, String? fileID,int? page,int? pageSize);

  Future<BaseResponse> sendUserViewToServer(String? fileID,String? courseID);

  Future<CourseReviewResponse> getCourseReviews(String? courseID);

  Future<QuizDetailsResponse> getQuizDetails(String? quizID);

  Future<BaseResponse> addFreeCourse(String? courseID);



}
