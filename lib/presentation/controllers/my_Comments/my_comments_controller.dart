import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/base/base_controller/BaseController.dart';
import '../../../data/models/editComentModel/EditRequest.dart';
import '../../../data/models/my_comments/CommentRequest.dart';
import '../../../domain/usecases/my_courses_use_case.dart';
import '../../widgets/custom_toast/custom_toast.dart';

class MyCommentsController extends BaseController {
  MyCommentsController(this._myCoursesUseCase);

  final MyCoursesUseCase _myCoursesUseCase;

  RxList myCommentsList = [].obs;

  ScrollController scrollController = ScrollController();

   final int? initailPage=1;
   int? currentPage;
   final int? perPage=10;
   bool isLastPage=false;
  bool isLoadingComments=false;
  @override
  void onInit() async {
    super.onInit();
    currentPage=initailPage;
    myCommentsList.value=[];
    addScollListner();
    

  }

  void addScollListner() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (!isLoadingComments) {
          //isLoadingComments = !isLoadingComments;
          //currentPage=(currentPage!)+1;
          if(!isLastPage) {
            print("getMyComments==>1");
            getMyComments();
          }
          // Perform event when user reach at the end of list (e.g. do Api call)
        }
      }
    });
  }


  getMyComments() async {
    try {
      isLoadingComments=true;

      // isLoading.value = true;
      final _myCommentsResponse =
          await _myCoursesUseCase.getMyComments("all", "",currentPage,perPage);
      isLoading.value = false;
      print("_myCommentsResponse");
      print(_myCommentsResponse.toJson());
      switch ((_myCommentsResponse).success) {
        case true:
          var webinersList=_myCommentsResponse
              .myCommentData?.myComment?.webinarsComments as List;
          myCommentsList.value.addAll(webinersList );
          var fileCommentList=_myCommentsResponse
              .myCommentData?.myComment?.filesComments as List;
          myCommentsList.value.addAll(fileCommentList);
          var blogsList=_myCommentsResponse
              .myCommentData?.myComment?.blogsComments as List;
          myCommentsList.value.addAll(blogsList);
          myCommentsList.refresh();
          currentPage=currentPage!+1;
          if(webinersList.isEmpty&&fileCommentList.isEmpty&&blogsList.isEmpty){
            isLastPage=true;
          }else{
            isLastPage=false;
          }
          break;
        case false:
          isLastPage=false;
          dismissLoading();
          showToast(_myCommentsResponse.message.toString(),
              gravity: Toast.bottom,isSuccess: false);
          break;
      }
      isLoadingComments=false;

    } catch (error) {
      print(error);
      getMyComments();
      // showToast(error.toString(), gravity: Toast.bottom);
    }
  }

  deleteComment(String? commentId,BuildContext context) async {
    try {
      loading();
      //isLoading.value = true;
      final _deleteCommentResponse =
          await _myCoursesUseCase.deleteComment(commentId);
     // isLoading.value = false;
      print("_deleteCommentResponse");
      print(_deleteCommentResponse.toJson());
      switch ((_deleteCommentResponse).success) {
        case true:
          dismissLoading();
          Navigator.pop(context,true);
          break;
        case false:
          dismissLoading();
          showToast(_deleteCommentResponse.message.toString(),
              gravity: Toast.bottom,isSuccess: false);
          break;
      }
    } catch (error) {
      print(error);
      deleteComment(commentId,context);
      //showToast(error.toString(), gravity: Toast.bottom);
    }
  }

  // editComment(String? commentId, File? commentImag, String? commentSound, String? comment) async {
  //   try {
  //     isLoading.value = true;
  //     final _editCommentResponse =
  //     await _myCoursesUseCase.editComment(commentId,commentImag,commentSound,comment);
  //     isLoading.value = false;
  //     print("_editCommentResponse");
  //     print(_editCommentResponse.toJson());
  //     switch ((_editCommentResponse).success) {
  //
  //       case true:
  //         showToast(_editCommentResponse.message.toString(),
  //             gravity: Toast.bottom);
  //         break;
  //       case false:
  //         dismissLoading();
  //         showToast(_editCommentResponse.message.toString(),
  //             gravity: Toast.bottom,isSuccess: false);
  //         break;
  //     }
  //   } catch (error) {
  //     print(error);
  //     editComment(commentId,commentImag,commentSound,comment);
  //     //showToast(error.toString(), gravity: Toast.bottom);
  //   }
  // }

  editComment(String? commentId,
      File? commentImag, String? commentSound, String? comment) async {
    try {
      //isLoading.value = true;
      loading();
      EditRequest commentRequest = EditRequest(
          comment: comment,
          commentImag: commentImag,
          commentSound: commentSound,
      comment_id: commentId);
      final _editCommentResponse =
      await _myCoursesUseCase.editComment(commentRequest);
      //isLoading.value = false;
      print("_editCommentResponse");
      dismissLoading();
      print(_editCommentResponse.toJson());
      switch ((_editCommentResponse).success) {
        case true:
        // showToast(_addCommentResponse.message.toString(),
        //     gravity: Toast.bottom);
          showToast(getLocale().your_question_has_been_submitted_successfully,
              gravity: Toast.bottom);
          break;
        case false:
          dismissLoading();
          showToast(_editCommentResponse.message.toString(),
              gravity: Toast.bottom, isSuccess: false);
          break;
      }
    } catch (error) {
      print("editCommentError");
      print(error);
      editComment(commentId, commentImag, commentSound, comment);
      //showToast(error.toString(), gravity: Toast.bottom);
    }
  }





  @override
  void dispose() {
    //  videoPlayerController.dispose();
    //controllerVideo.dispose();
    print("dispose");
    super.dispose();
  }


}
