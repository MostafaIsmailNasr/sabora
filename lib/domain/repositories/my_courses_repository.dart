import 'dart:io';

import '../../data/models/BaseResponse.dart';
import '../../data/models/editComentModel/EditRequest.dart';
import '../../data/models/my_comments/CommentRequest.dart';
import '../../data/models/my_comments/MyCommentsResponse.dart';
import '../../data/models/my_courses/MyCoursesResponse.dart';
import '../../data/models/search/SearchResponse.dart';
import '../../data/models/suggested_courses/SuggestedCoursesResponse.dart';

abstract class MyCoursesRepository {
  Future<MyCoursesResponse> getMyCourses();

  Future<SearchResponse> search(String searchText, String? organID,String? groupID);

  Future<SuggestedCoursesResponse> getSuggestedCourses(String? organID, String? groupID);

  Future<MyCommentsResponse> getMyComments(String? commentType, String? fileID,int? page,int? pageSize);

 // Future<BaseResponse> editComment(String? commentId, File? commentImag, String? commentSound, String? comment);
  Future<BaseResponse> editComment(EditRequest? commentRequest);

  Future<BaseResponse> deleteComment(String? commentId);


}
