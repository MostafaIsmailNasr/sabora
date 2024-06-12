import 'dart:io';

import '../../domain/repositories/my_courses_repository.dart';
import '../models/BaseResponse.dart';
import '../models/editComentModel/EditRequest.dart';
import '../models/my_comments/CommentRequest.dart';
import '../models/my_comments/MyCommentsResponse.dart';
import '../models/my_courses/MyCoursesResponse.dart';
import '../models/search/SearchResponse.dart';
import '../models/suggested_courses/SuggestedCoursesResponse.dart';
import '../providers/network/apis/course_api.dart';

class MyCoursesRepositoryIml extends MyCoursesRepository {

  @override
  Future<MyCoursesResponse> getMyCourses() async {
    var response = await CourseAPI.getMyCourses().request();
    print(response);
    return MyCoursesResponse.fromJson(response);
  }

  @override
  Future<SuggestedCoursesResponse> getSuggestedCourses(String? organID, String? groupID) async{
    var response = await CourseAPI.getSuggestedCourses(organID,groupID).request();
    print(response);
    return SuggestedCoursesResponse.fromJson(response);
  }

  @override
  Future<SearchResponse> search(String searchText, String? organID,String? groupID)async {
    var response = await CourseAPI.search(searchText,organID,groupID).request();
    print(response);
    return SearchResponse.fromJson(response);
  }

  @override
  Future<MyCommentsResponse> getMyComments(String? commentType, String? fileID,int? page,int? pageSize)async {
    var response = await CourseAPI.getMyComments(commentType,fileID,page,pageSize).request();
    print(response);
    return MyCommentsResponse.fromJson(response);
  }

  // @override
  // Future<BaseResponse> editComment(String? commentId, File? commentImag, String? commentSound, String? comment) async{
  //   var response = await CourseAPI.editComment(CommentRequest(comment:comment,commentId:commentId,commentImag:commentImag,commentSound:commentSound)).request();
  //   print(response);
  //   return BaseResponse.fromJson(response);
  // }

  @override
  Future<BaseResponse> editComment(EditRequest? commentRequest) async{
    var response = await CourseAPI.editComment(commentRequest).request();
    print("response==>");
    print(response);
    return BaseResponse.fromJson(response);
  }

  @override
  Future<BaseResponse> deleteComment(String? commentId) async {
    var response = await CourseAPI.deleteComment(commentId).request();
    print(response);
    return BaseResponse.fromJson(response);
  }

}
