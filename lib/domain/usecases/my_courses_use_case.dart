import 'dart:io';

import '../../data/models/BaseResponse.dart';
import '../../data/models/editComentModel/EditRequest.dart';
import '../../data/models/my_comments/CommentRequest.dart';
import '../../data/models/my_comments/MyCommentsResponse.dart';
import '../../data/models/my_courses/MyCoursesResponse.dart';
import '../../data/models/search/SearchResponse.dart';
import '../../data/models/suggested_courses/SuggestedCoursesResponse.dart';
import '../repositories/my_courses_repository.dart';

class MyCoursesUseCase  {
  final MyCoursesRepository _repo;
  MyCoursesUseCase(this._repo);

  Future<MyCoursesResponse> getMyCourses() {
    return _repo.getMyCourses();
  }

  Future<SearchResponse> search(String searchText,String? organID,String? groupID) {
    return _repo.search(searchText,organID,groupID);
  }

  Future<SuggestedCoursesResponse> getSuggestedCourses(String? organID,String? groupID) {
    return _repo.getSuggestedCourses(organID,groupID);
  }

  Future<MyCommentsResponse> getMyComments(String? commentType, String? fileID,int? page,int? pageSize ) {
    return _repo.getMyComments(commentType,fileID,page,pageSize);
  }

  // Future<BaseResponse> editComment(String? commentId, File? commentImag, String? commentSound, String? comment) {
  //   return _repo.editComment(commentId,commentImag,commentSound,comment);
  // }
  Future<BaseResponse> editComment(EditRequest? commentRequest) {
    return _repo.editComment(commentRequest);
  }


  Future<BaseResponse> deleteComment(String? commentId) {
    return _repo.deleteComment(commentId);
  }



}
