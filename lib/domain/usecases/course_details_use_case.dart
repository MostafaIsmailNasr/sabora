import '../../app/core/usecases/pram_usecase.dart';
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
import '../repositories/course_details_repository.dart';

class CourseDetailsUseCase extends ParamUseCase<ProfileResponse, String> {
  final CourseDetailsRepository _repo;
  CourseDetailsUseCase(this._repo);

  @override
  Future<ProfileResponse> execute(String userID) {
    return _repo.getUserProfile(userID);
  }


  Future<CheckCartResponse> checkCartData(int? groupID){
    return _repo.checkCartData(groupID);
  }

  Future<BaseResponse> addCourseToCart(String courseId){
    return _repo.addCourseToCart(courseId);
  }

  Future<BaseResponse> checkoutCourse(String coupon, String discountID) async{
    return _repo.checkoutCourse(coupon,discountID);
  }

  Future<BaseResponse> deleteCart(String cartID) async{
    return _repo.deleteCart(cartID);
  }

  Future<ValidateCouponResponse> validateCourseCoupon(String coupon) async{
    return _repo.validateCourseCoupon(coupon);
  }

  Future<FavouritsResponse> getFavourits(String organID) async{
    return _repo.getFavourits(organID);
  }

  Future<BaseResponse>  toggleFavourits(String courseID)  async{
    return _repo.toggleFavourite(courseID);
  }

  Future<BaseResponse> addCourseComment(CommentRequest? commentRequest) {
    return _repo.addCourseComment(commentRequest);
  }

  Future<BaseResponse> addCourseRate(RateRequest? rateRequest) {
    return _repo.addCourseRate(rateRequest);
  }

  Future<CourseDetailsResponse> getCourseDetails(String courseID)  {
    return _repo.getCourseDetails(courseID);
  }

  Future<CourseContentResponse>  getCourseContents(String courseID)  {
    return _repo.getCourseContents(courseID);
  }

  Future<MyCommentsResponse> getMyComments(String? commentType, String? fileID,int? page,int? pageSize) {
    return _repo.getMyComments(commentType,fileID,page,pageSize);
  }
  Future<BaseResponse> sendUserViewToServer( String? fileID,String? courseID) {
    return _repo.sendUserViewToServer(fileID,courseID);
  }

  Future<CourseReviewResponse> getCourseReviews( String? courseID) {
    return _repo.getCourseReviews(courseID);
  }

  Future<QuizDetailsResponse> getQuizDetails( String? quizID) {
    return _repo.getQuizDetails(quizID);
  }

  Future<BaseResponse> addFreeCourse( String? courseID) {
    return _repo.addFreeCourse(courseID);
  }





}
