import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/base/base_controller/BaseController.dart';
import '../../../data/models/course_details/ContentData.dart';
import '../../../data/models/home/course_details/Course.dart';
import '../../../data/models/my_comments/CommentRequest.dart';
import '../../../data/models/rate/RateRequest.dart';
import '../../../data/providers/web_servies/WebServies.dart';
import '../../../data/repositories/Redmee_points_repository.dart';
import '../../../domain/usecases/course_details_use_case.dart';
import '../../pages/course_details/enroll_bottom_sheet/enroll_bottom_sheet.dart';
import '../../pages/course_details/video_controller/video_controller.dart';
import '../../pages/main/my_exams/quiz_details/quiz_details.dart';
import '../../pages/main/my_exams/quiz_status/quiz_status.dart';
import '../../widgets/custom_toast/custom_toast.dart';
import '../../widgets/enroll_course_success/enroll_course_success.dart';
import '../my_quizes/quize_binding.dart';

enum CheckCartType { check, setData }

class CourseDetailsController extends BaseController
    with GetSingleTickerProviderStateMixin {
  CourseDetailsController(this._courseDetailsUseCase);

  GlobalKey stickyKey = GlobalKey();
  GlobalKey stickyKeyChapter = GlobalKey();

  final CourseDetailsUseCase _courseDetailsUseCase;

  late TabController tabController;
  MyVideoViewerController? courseDetailsVideoController;
  MyVideoViewerController? chapterDetailsVideoController;

  RxInt widthPos = 165.obs;
  RxInt heightPos = 165.obs;

//  late VideoPlayerController videoPlayerController;
  bool startedPlaying = false;
  bool isVideoPlayed = false;
  bool sendViewToServer = true;
  RxInt selectedTabIndex = 0.obs;
  String? courseID;
  Course? courseToBeEnrolled;
  ContentData? mFile;
  Rx<Course?> courseDetails = Course().obs;
  Timer? timer;
  Timer? randomPositionTimer;
  late BuildContext mContext;
  RxBool isFavourite = false.obs;
  RxBool isVideoPlayed2 = true.obs;
  int i = 1;
  late TextEditingController couponTextController = TextEditingController();

  RxList myQuestionsList = [].obs;
  RxList reviewsList = [].obs;
  RxList courseContentList = [].obs;

  String? commentsType, chapterIdForComment;
  //pagination var
  ScrollController scrollController = ScrollController();
  final int? initailPage = 1;
  int? currentPage;
  final int? perPage = 10;
  bool isLastPage = false;
  var isLoadingComments = false;
  var contentid;
  PointsRepository repo = PointsRepository(WebService());

  @override
  void onInit() async {
    super.onInit();
    addScollListner();
    // courseDetailsVideoController = MyVideoViewerController();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      print("--->${tabController.index}");
      selectedTabIndex.value = tabController.index;
    });

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      addVideoTimeChangeListner();
      myQuestionsList.value = [];
      isLastPage=false;
      currentPage=1;
      isVideoPlayed2.value = true;
      getChaptersQuestions("files",contentid);
    });
  }

  setOnPlayPauseCallBack() {
    if (chapterDetailsVideoController != null) {
      chapterDetailsVideoController!.setOnPlayPauseCallBack((isPlayed) {
        print("object==>minutes$isPlayed");
        isVideoPlayed = isPlayed;
        isVideoPlayed2.value = isPlayed;
      });
    }
    if (courseDetailsVideoController != null) {
      courseDetailsVideoController!.setOnPlayPauseCallBack((isPlayed) {
        print("object==>minutes2$isPlayed");
        isVideoPlayed2.value = isPlayed;
      });
    }
  }

  void addScollListner() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (!isLoadingComments) {
          isLoadingComments = !isLoadingComments;
          // currentPage=(currentPage!)+1;
          if (!isLastPage) {
            getChaptersQuestions(commentsType!, chapterIdForComment!);
          }
          // Perform event when user reach at the end of list (e.g. do Api call)
        }
      }
    });
  }

  addVideoTimeChangeListner() {
    /// chapterDetailsVideoController = MyVideoViewerController();
    executeOnMinute(() {
      if (chapterDetailsVideoController?.video != null) {
        if (chapterDetailsVideoController?.isPlaying ?? false) {
          var viewPercentage =
              (int.parse((store.settingsConfig?.durationSeconds) ?? "0") *
                          chapterDetailsVideoController!.duration.inSeconds)
                      .toDouble() /
                  100;
          print("viewPercentage");
          print("viewPercentage$viewPercentage");
          if (i >= viewPercentage) {
            if (mFile!.accessibility == "paid" &&
                (courseDetails.value?.authHasBought ??
                    false)) if (sendViewToServer) {
              // Log.d("TAG", "onUpdateCurrentPosition: viewSent"+durationViewed)
              sendUserViewToServer();
              sendViewToServer = false;
            }
          }
          print(
              "object==>minutes${i++}===>${chapterDetailsVideoController!.duration.inSeconds}");
        }
      }
    });
  }

  void executeOnMinute(void Function() callback) {
    var now = DateTime.now();
    var nextMinute = DateTime(
        now.year, now.month, now.day, now.hour, now.minute, now.second + 1);
    Timer(nextMinute.difference(now), () {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        callback();
      });

      // Execute the callback on the first minute after the initial time.
      //
      // This should be done *after* registering the periodic [Timer] so that it
      // is unaffected by how long [callback] takes to execute.
      // callback();
    });
  }

  void randomPositionForNumber(/*void Function() callback*/) {
    var now = DateTime.now();
    var nextMinute = DateTime(
        now.year, now.month, now.day, now.hour, now.minute, now.second + 15);
    Timer(nextMinute.difference(now), () {
      randomPositionTimer =
          Timer.periodic(const Duration(seconds: 15), (timer) {
        //callback();
        final keyContext = stickyKey.currentContext;
        final keyContext2 = stickyKeyChapter.currentContext;
        if (keyContext != null || keyContext2 != null) {
          // widget is visible
          final box = keyContext != null
              ? (keyContext.findRenderObject() as RenderBox)
              : (keyContext2?.findRenderObject() as RenderBox);
          final pos = box.localToGlobal(Offset.zero);
          widthPos.value = ((Random()
                  .nextInt(box.size.width.toInt() - 50)
                  .toDouble()) /*+ pos.dx.toDouble()*/)
              .toInt(); // Value is >= 50 and < 950.
          heightPos.value = ((Random()
                  .nextInt(box.size.height.toInt() - 40)
                  .toDouble()) /*+ pos.dy.toDouble()*/)
              .toInt(); // Value is >= 50 and < 650.
          //print(box.size.width);
          //print(heightPos.value);
          print("pos.dx");
          print(pos.dx);
          print("pos.dy");
          print(pos.dy);
          print("box.size.width.toInt(");
          print(box.size.width.toInt());
          print("box.size.height.toInt()");
          print(box.size.height.toInt());

          print("widthPos.value");
          print(widthPos.value);
          print("heightPos.value");
          print(heightPos.value);
        }
        // widthPos.value= Random().nextInt(900) + 50; // Value is >= 50 and < 950.
        // heightPos.value=  Random().nextInt(300) + 50; // Value is >= 50 and < 650.
      });

      // Execute the callback on the first minute after the initial time.
      //
      // This should be done *after* registering the periodic [Timer] so that it
      // is unaffected by how long [callback] takes to execute.
      // callback();
    });
  }

  sendUserViewToServer() async {
    try {
      //isLoading.value = true;
      final _viewsResponse = await _courseDetailsUseCase.sendUserViewToServer(
          mFile?.id.toString(), courseID);
      print("_viewsResponse");
      print(_viewsResponse.toJson());
      switch ((_viewsResponse).success) {
        case true:
          sendViewToServer = false;
          break;
        case false:
          break;
      }
    } catch (error) {
      print(error);
    }
  }

  getQuizDetails(BuildContext context, String quizID) async {
    try {
      loading();
      //isLoading.value = true;
      final _quizDetailsResponse =
          await _courseDetailsUseCase.getQuizDetails(quizID);
      print("_quizDetailsResponse");
      print(_quizDetailsResponse.toJson());
      switch ((_quizDetailsResponse).success) {
        case true:
          dismissLoading();
          var quizData = _quizDetailsResponse.data;

          QuizeBinding().dependencies();
          if (courseDetails.value?.authHasBought ?? false) {
            // if (item.locked) {
            //   Toast.makeText(
            //       context,
            //       context.getText(R.string.PleaseWatchPreviousVideos),
            //       Toast.LENGTH_SHORT
            //   ).show()
            //   return
            // }

            if (quizData?.authStatus == "not_participated") {
              Future.delayed(Duration.zero, () async {
                var returnValue = await Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) => QuizDetailsScreen(quizData!)),
                );
              });
            } else {
              Future.delayed(Duration.zero, () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) =>
                          QuizStatusScreen(quizData?.id.toString())),
                );
              });
            }
          } else {
            Future.delayed(Duration.zero, () async {
              var returnValue = await Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => QuizDetailsScreen(quizData!)),
              );
            });
          }
          break;
        case false:
          dismissLoading();
          break;
      }
    } catch (error) {
      print(error);
      getQuizDetails(context, quizID);
    }
  }

  getCourseDetails(String courseID) async {
    try {
      isLoading.value = true;
      final _courseDetailsResponse =
          await _courseDetailsUseCase.getCourseDetails(courseID);
      print("_courseDetailsResponse");
      print(_courseDetailsResponse.toJson());
      switch ((_courseDetailsResponse).success) {
        case true:
          courseDetails.value = _courseDetailsResponse.course;
          isFavourite.value = courseDetails.value?.isFavorite ?? false;

          getCourseContents(courseID);

          // update();
          break;
        case false:
          dismissLoading();
          showToast(_courseDetailsResponse.message.toString(),
              gravity: Toast.bottom, isSuccess: false);
          break;
      }
    } catch (error) {
      print(error);
      getCourseDetails(courseID);
      // showToast(error.toString(), gravity: Toast.bottom);
    }
  }

  getCourseContents(String courseID) async {
    try {
      // courseContentList.value=[];
      // isLoading.value = true;
      final _courseContentResponse =
          await _courseDetailsUseCase.getCourseContents(courseID);
      print("_courseDetailsResponse");
      print(_courseContentResponse.toJson());
      switch ((_courseContentResponse).success) {
        case true:
          courseContentList.value = _courseContentResponse.contentData as List;
          // isLoading.value = false;
          isLoading.value = false;
          break;
        case false:
          dismissLoading();
          showToast(_courseContentResponse.message.toString(),
              gravity: Toast.bottom, isSuccess: false);
          break;
      }
    } catch (error) {
      print(error);
      getCourseContents(courseID);
      //showToast(error.toString(), gravity: Toast.bottom);
    }
  }

  getChaptersQuestions(String type, String chapterId) async {
    try {
      commentsType = type;
      chapterIdForComment = chapterId;
      isLoadingComments = true;
      if (type == "files") isLoading.value = true;
      //myQuestionsList.value.clear();
      final _myCommentsResponse = await _courseDetailsUseCase.getMyComments(
          type, chapterId, currentPage, perPage);
      isLoading.value = false;
      print("_myCommentsResponse");
      print(_myCommentsResponse.toJson());
      switch ((_myCommentsResponse).success) {
        case true:
          myQuestionsList.value.clear();
          var wibenersList = _myCommentsResponse
              .myCommentData?.myComment?.webinarsComments as List;
          myQuestionsList.value.addAll(wibenersList);
          var filesComments = _myCommentsResponse
              .myCommentData?.myComment?.filesComments as List;
          myQuestionsList.value.addAll(filesComments);
          var blogsList = _myCommentsResponse
              .myCommentData?.myComment?.blogsComments as List;
          myQuestionsList.value.addAll(blogsList);
          myQuestionsList.refresh();
          currentPage = currentPage! + 1;

          if (wibenersList.isEmpty &&
              filesComments.isEmpty &&
              blogsList.isEmpty) {
            isLastPage = true;
          } else {
            isLastPage = false;
          }

          break;
        case false:
          dismissLoading();
          showToast(_myCommentsResponse.message.toString(),
              gravity: Toast.bottom, isSuccess: false);
          break;
      }
      isLoadingComments = false;
    } catch (error) {
      print(error);
      getChaptersQuestions(type, chapterId);
      //showToast(error.toString(), gravity: Toast.bottom);
    }
  }

  getCourseReviews(String courseID) async {
    try {
      myQuestionsList.value = [];
      final _courseReviewResponse =
          await _courseDetailsUseCase.getCourseReviews(courseID);
      isLoading.value = false;
      print("_myCommentsResponse");
      print(_courseReviewResponse.toJson());
      switch ((_courseReviewResponse).success) {
        case true:
          reviewsList.value = _courseReviewResponse.reviewsData as List;
          break;
        case false:
          dismissLoading();
          showToast(_courseReviewResponse.message.toString(),
              gravity: Toast.bottom, isSuccess: false);
          break;
      }
    } catch (error) {
      print(error);
      getCourseReviews(courseID);
      //showToast(error.toString(), gravity: Toast.bottom);
    }
  }

  ///
  /// 1-first step for enroll course
  ///
  ///
  ///
  checkCartData(CheckCartType checkCartType) async {
    try {
      final _chheckCartResponse =
          await _courseDetailsUseCase.checkCartData(store.user?.userGroup?.id);
      print("_checkCartResponse");
      print(_chheckCartResponse.cartdata?.toJson());
      switch ((_chheckCartResponse).success) {
        case true:
          if (_chheckCartResponse.cartdata?.cart != null) {
            switch (checkCartType) {
              case CheckCartType.check:
                deleteCart(
                    (_chheckCartResponse.cartdata?.cart?.items![0].id ?? 0)
                        .toString());
                break;
              case CheckCartType.setData:
                courseToBeEnrolled =
                    _chheckCartResponse.cartdata?.cart?.items![0].webinar;
                showEnrollBottomSheet(mContext, courseToBeEnrolled!, this);
                dismissLoading();
                //update();
                break;
            }
            // if (s == "check"){
            //   mPresenter.removeFromCart(cart.cartItems[0].id, 0)
            // }else if (s == "set"){
            //   setData(cart)
            // }
          } else {
            // val addToCart = AddToCart()
            // addToCart.webinarId = courseId
            //
            // val presenter = CommonApiPresenterImpl.getInstance()
            // presenter.addToCart(addToCart, mAddToCartCallback)
            print("hereeeeeeeee");
            addCourseToCart(courseID!);
          }

          break;
        case false:
          break;
      }
    } catch (error) {
      print(error);
      checkCartData(checkCartType);
      // showToast(error.toString(), gravity: Toast.bottom);
    }
  }

  ///
  /// 2- step for enroll course
  ///
  ///
  ///
  addCourseToCart(String courseID) async {
    try {
      final _addToCartResponse =
          await _courseDetailsUseCase.addCourseToCart(courseID);
      print("_addToCartResponse");
      print(_addToCartResponse.toJson());
      switch ((_addToCartResponse).success) {
        case true:
          checkCartData(CheckCartType.setData);
          break;
        case false:
          dismissLoading();
          showToast(_addToCartResponse.message.toString(),
              gravity: Toast.bottom, isSuccess: false);
          break;
      }
    } catch (error) {
      print(error);
      addCourseToCart(courseID);
      //showToast(error.toString(), gravity: Toast.bottom);
    }
  }

  checkoutCourse(String coupon, String discountID) async {
    try {
      final _checkoutCourseResponse =
          await _courseDetailsUseCase.checkoutCourse(coupon, discountID);
      print("_checkoutCourseResponse");
      print(_checkoutCourseResponse.toJson());
      switch ((_checkoutCourseResponse).success) {
        case true:
          print("successs course enroll");
          dismissLoading();
          getCourseDetails(courseID.toString());
          Get.back();
          dialogSuccessErrorEnrollBuilder(mContext, type: 1);
          //showToast("successs course enroll", gravity: Toast.bottom);
          //Get.back();
          break;
        case false:
          dismissLoading();
          showToast(_checkoutCourseResponse.message.toString(),
              gravity: Toast.bottom, isSuccess: false);
          break;
      }
    } catch (error) {
      print(error);
      dismissLoading();
      checkoutCourse(coupon, discountID);
      //showToast(error.toString(), gravity: Toast.bottom);
    }
  }

  addFreeCourse(String courseID) async {
    try {
      final _checkoutCourseResponse =
          await _courseDetailsUseCase.addFreeCourse(courseID);
      print("_checkoutCourseResponse");
      print(_checkoutCourseResponse.toJson());
      switch ((_checkoutCourseResponse).success) {
        case true:
          print("successs course enroll");
          dismissLoading();
          getCourseDetails(courseID.toString());
          // Get.back();
          dialogSuccessErrorEnrollBuilder(mContext, type: 1);
          //showToast("successs course enroll", gravity: Toast.bottom);
          //Get.back();
          break;
        case false:
          dismissLoading();
          showToast(_checkoutCourseResponse.message.toString(),
              gravity: Toast.bottom, isSuccess: false);
          break;
      }
    } catch (error) {
      print(error);
      dismissLoading();
      addFreeCourse(courseID);
      //showToast(error.toString(), gravity: Toast.bottom);
    }
  }

  deleteCart(String cartID) async {
    try {
      final _deleteCartResponse =
          await _courseDetailsUseCase.deleteCart(cartID);
      print("_deleteCartResponse");
      print(_deleteCartResponse.toJson());
      switch ((_deleteCartResponse).success) {
        case true:
          checkCartData(CheckCartType.check);
          break;
        case false:
          dismissLoading();
          showToast(_deleteCartResponse.message.toString(),
              gravity: Toast.bottom, isSuccess: false);
          break;
      }
    } catch (error) {
      print(error);
      //dismissLoading();
      deleteCart(cartID);
      // showToast(error.toString(), gravity: Toast.bottom);
    }
  }

  validateCourseCoupon() async {
    try {
      String coupon = couponTextController.text.toString();
      final _validateCourseResponse =
          await _courseDetailsUseCase.validateCourseCoupon(coupon);
      print("_validateCourseResponse");
      print(_validateCourseResponse.toJson());
      switch ((_validateCourseResponse).success) {
        case true:
          couponTextController.clear();
          var item = _validateCourseResponse.couponData;

          if ((item?.amounts?.total ?? 0) <= 0) {
            //   mBinding.courseDetailsPriceValueTv.text = Utils.formatPrice(requireContext(), mAmounts.total)
            checkoutCourse(coupon, (item?.discount?.id ?? 0).toString());
          } else {
            dismissLoading();
            dialogSuccessErrorEnrollBuilder(mContext);
          }
//           val item : CouponValidation = data.data!!
//           mAmounts = item.amounts
//           item.coupon.discountId = item.coupon.id
//           mCouponValidation = item
//
//           if (mAmounts.total <= 0) {
//             mBinding.courseDetailsPriceValueTv.text = Utils.formatPrice(requireContext(), mAmounts.total)
//             mPresenter.checkout(mCouponValidation?.coupon)
//           }else{
//             mBinding.progressBar.visibility = View.GONE
// //                ToastMaker.show(
// //                    requireContext(),
// //                    getString(R.string.error),
// //                    getString(R.string.coupon_not_valid),
// //                    ToastMaker.Type.ERROR
// //                )
//             dismiss()
//             val dialog = FaildCourseSupDialog()
//             // dialog.setStyle(BottomSheetDialogFragment.STYLE_NO_TITLE, R.style.AppBottomSheetDialogTheme)
//             dialog.isCancelable = false
//             dialog.setOnRetryClicked(this)
//             dialog.show(parentFragmentManager, null)
//           }
          break;
        case false:
          // showToast(_validateCourseResponse.message.toString(),
          //     gravity: Toast.bottom);
          dismissLoading();
          dialogSuccessErrorEnrollBuilder(mContext);
          break;
      }
    } catch (error) {
      print(error);
      dismissLoading();
      validateCourseCoupon();
      //showToast(error.toString(), gravity: Toast.bottom);
    }
  }

  toggleFavourits() async {
    try {
      //isLoading.value = true;
      final _favoritsResponse =
          await _courseDetailsUseCase.toggleFavourits(courseID.toString());
      print("_favoritsResponse");
      print(_favoritsResponse.toJson());
      switch ((_favoritsResponse).success) {
        case true:
          isFavourite.value = _favoritsResponse.status == "favored";
          break;
        case false:
          dismissLoading();
          showToast(_favoritsResponse.message.toString(),
              gravity: Toast.bottom, isSuccess: false);
          break;
      }
    } catch (error) {
      print(error);
      toggleFavourits();
      //showToast(error.toString(), gravity: Toast.bottom);
    }
  }

//webinar -- file
  addCourseComment(String? itemID, String? itemName, String? courseId,
      File? commentImag, String? commentSound, String? comment) async {
    try {
      //isLoading.value = true;
      loading();
      CommentRequest commentRequest = CommentRequest(
          itemId: itemID,
          itemName: itemName,
          comment: comment,
          commentImag: commentImag,
          commentSound: commentSound);
      final _addCommentResponse =
          await _courseDetailsUseCase.addCourseComment(commentRequest);
      //isLoading.value = false;
      print("_addCommentResponse");
      dismissLoading();
      print(_addCommentResponse.toJson());
      switch ((_addCommentResponse).success) {
    case true:
          // showToast(_addCommentResponse.message.toString(),
          //     gravity: Toast.bottom);
          showToast(getLocale().your_question_has_been_submitted_successfully,
              gravity: Toast.bottom);
          currentPage = 1;
          getChaptersQuestions(commentsType!, chapterIdForComment!);
          break;
        case false:
          dismissLoading();
          showToast(_addCommentResponse.message.toString(),
              gravity: Toast.bottom, isSuccess: false);
          break;
      }
    } catch (error) {
      print("addCommentError");
      print(error);
      addCourseComment(
          itemID, itemName, courseId, commentImag, commentSound, comment);
      //showToast(error.toString(), gravity: Toast.bottom);
    }
  }

  addCommentWithImageAndVoice(String? itemID, String? itemName, String? courseId,
      String? commentImag, String? commentSound, String? comment)async{
    loading();
    final _addCommentResponse2 = await repo.addCommentWithImageAndVoice(itemID,itemName,courseId,commentImag,
        commentSound,comment);
    if(_addCommentResponse2.success==true){
      dismissLoading();
      showToast(getLocale().your_question_has_been_submitted_successfully,
          gravity: Toast.bottom);
      currentPage = 1;
      getChaptersQuestions(commentsType!, chapterIdForComment!);
    }else{
      dismissLoading();
      showToast(_addCommentResponse2.message.toString(),
          gravity: Toast.bottom, isSuccess: false);
    }
    return _addCommentResponse2;
  }

  addCourseRate(RateRequest rateRequest) async {
    try {
      // isLoading.value = true;
      loading();
      final _addRateResponse =
          await _courseDetailsUseCase.addCourseRate(rateRequest);
      isLoading.value = false;
      print("_addRateResponse");

      print(_addRateResponse.toJson());
      switch ((_addRateResponse).success) {
        case true:
          dismissLoading();
          showToast(_addRateResponse.message.toString(), gravity: Toast.bottom);
          break;
        case false:
          dismissLoading();
          showToast(_addRateResponse.message.toString(),
              gravity: Toast.bottom, isSuccess: false);
          break;
      }
    } catch (error) {
      print(error);
      addCourseRate(rateRequest);
      // showToast(error.toString(), gravity: Toast.bottom);
    }
  }

  @override
  void dispose() {
    //  videoPlayerController.dispose();
    //controllerVideo.dispose();
    //courseDetailsVideoController.dispose();
    //chapterDetailsVideoController.dispose();

    print("dispose");
    super.dispose();
  }
}
