import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:video_viewer/video_viewer.dart';

import '../../../app/config/app_colors.dart';
import '../../../app/config/app_text_styles.dart';
import '../../../app/services/local_storage.dart';
import '../../../app/util/util.dart';
import '../../../data/models/rate/RateRequest.dart';
import '../../../generated/assets.dart';
import '../../controllers/course_details/course_details_controller.dart';
import '../../widgets/add_comment/add_comment.dart';
import '../../widgets/button.dart';
import '../../widgets/custom_toast/custom_toast.dart';
import '../../widgets/main_toolbar/main_toolbar.dart';
import '../../widgets/rate_bar/rate_bar.dart';
import 'course_comments.dart';
import 'course_content.dart';
import 'course_description.dart';
import 'course_rate.dart';
import 'custom_video_player.dart';
import 'rate_course/rate_course.dart';
import 'video_controller/video_controller.dart';

class CourseDetailsScreen extends GetView<CourseDetailsController> {
  late AppLocalizations _local;
  late double _height;
  late double _width;
  String _courseID;
  var child;
  var isFirstTime = true;
  final MyVideoViewerController videoController = MyVideoViewerController();

  CourseDetailsScreen(this._courseID, {super.key}) {
    //controller.courseID = courseID;
  }

  String getButtonTitle(int index) {
    switch (index) {
      case 0:
        return _local.to_subscribe_click_here;
      case 1:
        return _local.to_subscribe_click_here;
      case 2:
        return _local.write_your_review;
      case 3:
        return _local.leave_a_comment;
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);

    controller.courseID = _courseID;
    controller.mContext = context;
    ToastMContext().init(context);
    print("---->");
    // RegisterBinding().dependencies();
    _local = AppLocalizations.of(context)!;
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    if (isFirstTime) {
      controller.courseDetailsVideoController = videoController;
      controller.courseDetailsVideoController!
          .setCourseDetailsController(controller,true);
      controller.setOnPlayPauseCallBack();
      controller.getCourseDetails(_courseID);
      Future.delayed(Duration(seconds: 1)).then((_) {
        controller.getCourseContents(_courseID);
        controller.randomPositionForNumber();
        controller.isVideoPlayed2.value = true;
      });
      isFirstTime = false;
    }

    return Obx(() => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white24,
        appBar: buildMainToolBar(
            controller, _local.course_details, () => {Get.back()}),
        body: controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverToBoxAdapter(
                    child: _buildCourseHeader(context),
                  ),
                  SliverPersistentHeader(
                    delegate: _SliverAppBarDelegate(
                      _buildTabBar(),
                    ),
                    pinned: true,
                  ),
                ],
                body: Container(
                  height: _height,
                  child: Column(
                    children: [
                      Expanded(
                        child: TabBarView(
                            //physics: ScrollPhysics(),
                            controller: controller.tabController,
                            children: [
                              CourseContent(controller.courseContentList.value,
                                  controller.courseDetails.value, controller),
                              CourseDescription(controller.courseDetails.value),
                              CourseRate(controller.reviewsList.value,
                                  controller.courseDetails.value),
                              CourseComments(
                                  controller.myQuestionsList.value, controller),
                            ]),
                      ),
                      Container(
                          width: _width,
                          height: (((controller.courseDetails.value?.authHasBought ?? false) &&
                                      getAllPercentages(controller.courseContentList.value) >=
                                          100.0 &&
                                      (controller.selectedTabIndex.value == 0 ||
                                          controller.selectedTabIndex.value ==
                                              1)) ||
                                  (!(controller.courseDetails.value?.authHasBought ?? false) &&
                                      (controller.selectedTabIndex.value == 0 ||
                                          controller.selectedTabIndex.value ==
                                              1)) ||
                                  ((controller.courseDetails.value?.authHasBought ?? false) &&
                                      (controller.selectedTabIndex.value == 2 ||
                                          controller.selectedTabIndex.value ==
                                              3)))
                              ? 100
                              : 0,
                          child: (((controller.courseDetails.value?.authHasBought ??
                                          false) &&
                                      getAllPercentages(controller.courseContentList.value) >= 100.0 &&
                                      (controller.selectedTabIndex.value == 0 || controller.selectedTabIndex.value == 1)) ||
                                  (!(controller.courseDetails.value?.authHasBought ?? false) && (controller.selectedTabIndex.value == 0 || controller.selectedTabIndex.value == 1)) ||
                                  ((controller.courseDetails.value?.authHasBought ?? false) && (controller.selectedTabIndex.value == 2 || controller.selectedTabIndex.value == 3)))
                              ? Card(
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 10,
                                          bottom: 15),
                                      child: myButton(() {
                                        switch (
                                            controller.selectedTabIndex.value) {
                                          case 0:
                                            controller.loading();
                                            if (controller.courseDetails.value
                                                    ?.price ==
                                                0.0) {
                                              controller.addFreeCourse(
                                                  (controller.courseDetails
                                                          .value?.id)
                                                      .toString());
                                            } else {
                                              controller.checkCartData(
                                                  CheckCartType.check);
                                            }
                                            break;
                                          case 1:
                                            controller.loading();
                                            if (controller.courseDetails.value
                                                    ?.price ==
                                                0.0) {
                                              controller.addFreeCourse(
                                                  (controller.courseDetails
                                                          .value?.id)
                                                      .toString());
                                            } else {
                                              controller.checkCartData(
                                                  CheckCartType.check);
                                            }
                                            break;
                                          case 2:
                                            showRateBottomSheet(context,
                                                (rateComment,
                                                    contentQuality,
                                                    instructorSkills,
                                                    purchaseWorth,
                                                    supportQuality) {
                                              RateRequest rateRequest =
                                                  RateRequest(
                                                      webinarId: _courseID,
                                                      description: rateComment,
                                                      contentQuality:
                                                          contentQuality
                                                              .toString(),
                                                      instructorSkills:
                                                          instructorSkills
                                                              .toString(),
                                                      purchaseWorth:
                                                          purchaseWorth
                                                              .toString(),
                                                      supportQuality:
                                                          supportQuality
                                                              .toString());
                                              controller
                                                  .addCourseRate(rateRequest);
                                            });
                                            break;
                                          case 3:
                                            showAddCommentBottomSheet(context,
                                                (imagePth, soundPath,
                                                    mComment) {
                                              controller.addCourseComment(
                                                  _courseID.toString(),
                                                  "webinar",
                                                  _courseID.toString(),
                                                  imagePth,
                                                  soundPath,
                                                  mComment);
                                            }, isCourseDetails: true);
                                            break;
                                        }

                                        //
                                      },
                                          getButtonTitle(controller
                                              .selectedTabIndex.value))),
                                )
                              : Container())
                    ],
                  ),
                ),
              )));
  }

  _buildCourseHeader(final BuildContext context) {
    print("---->2");
    final store = Get.find<LocalStorageService>();
    Duration? videoDuration;
    // final MyVideoViewerController courseDetailsVideoController =
    //     MyVideoViewerController();
    return Obx(() => Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.courseDetails.value?.title ?? "",
                style: AppTextStyles.titleToolbar.copyWith(fontSize: 16),
              ),
              StarRating(
                rating:
                    double.parse(controller.courseDetails.value?.rate ?? "0"),
                onRatingChanged: (rating) =>
                    {} /* setState(() => this.rating = rating)*/,
                color: AppColors.yello,
              ),
              Directionality(
                  textDirection: TextDirection.ltr,
                  child: Stack(
                    children: [
                      controller.courseDetails.value?.videoDemo == null
                          ? Container(
                              margin: EdgeInsets.only(top: 20),
                              height: _height * 0.28,
                              width: _width,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    height: _height * 0.28,
                                    width: _width,
                                    (controller.courseDetails.value?.image ??
                                            "")
                                        .toString(),
                                    // "course?.image ??"
                                    // "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
                                    fit: BoxFit.fill,
                                    loadingBuilder: (context, child,
                                            loadingProgress) =>
                                        (loadingProgress == null)
                                            ? child
                                            : Center(
                                                child:
                                                    CircularProgressIndicator()),
                                    errorBuilder:
                                        (context, error, stackTrace) => Center(
                                            child: Image(image: AssetImage('assets/images/edu_gate_logo2.png'),)),
                                  )),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  color: AppColors.gray,
                                  borderRadius: BorderRadius.circular(16)),
                              margin: EdgeInsets.only(top: 20),
                              height: _height * 0.28,
                              width: _width,
                              child: /* VideoViewerOrientation(
                    controller: controller.courseDetailsVideoController,
                    child:*/
                                  Directionality(
                                textDirection: TextDirection.ltr,
                                child: VideoViewer(
                                  key: controller.stickyKey,
                                  language: VideoViewerLanguage.en,
                                  enableVerticalSwapingGesture: false,
                                  enableHorizontalSwapingGesture: false,
                                  enableShowReplayIconAtVideoEnd: true,
                                  controller:
                                      controller.courseDetailsVideoController,
                                  onFullscreenFixLandscape: true,
                                  enableFullscreenScale: true,
                                  source: {
                                    "": VideoSource(
                                      video: VideoPlayerController.network(
                                          controller
                                              .courseDetails.value!.videoDemo.toString().replaceAll(" ","%20")
                                          // "https://upload.elsaiad.net/3/2.mp4" /* "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"*/,
                                          ),
                                      /*ads: [
                        */ /* VideoViewerAd(
                                fractionToStart: 0,
                                child: Container(
                                  color: Colors.black,
                                  child: Center(child: Text("AD ZERO")),
                                ),
                                durationToSkip: Duration.zero,
                              ),
                              VideoViewerAd(
                                fractionToStart: 0.5,
                                child: Container(
                                  color: Colors.black,
                                  child: Center(child: Text("AD HALF")),
                                ),
                                durationToSkip: Duration(seconds: 4),
                              ),*/ /*
                      ],*/
                                      // range: Tween<Duration>(
                                      //   begin: const Duration(seconds: 5),
                                      //   end: const Duration(seconds: 25),
                                      // ),
                                    ),
                                  },
                                  style: CustomVideoViewerStyle(
                                      movie: Movie(
                                          title: "",
                                          category: "",
                                          thumbnail: controller.courseDetails
                                                  .value?.imageCover ??
                                              "" /*"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6w8rSenm_-vq5lSBjr0iDJ8r5N8cDL0U6wPLGS0AG&s"*/),
                                      context: context),
                                ),
                              ) /*Center(
                    child: FutureBuilder<bool>(
                        future: controller.started(),
                        builder:
                            (BuildContext context, AsyncSnapshot<bool> snapshot) {
                          if (snapshot.data ?? false) {
                            return AspectRatio(
                              aspectRatio: controller
                                  .videoPlayerController.value.aspectRatio,
                              child:
                              VideoPlayer(controller.videoPlayerController),
                            );
                          } else {
                            // If the VideoPlayerController is still initializing, show a
                            // loading spinner.
                            return const Center(
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                        }))*/
                              ,
                            ) /*)*/,
                      Obx(() => Container(
                            margin: EdgeInsetsDirectional.only(
                                start: controller.widthPos.value.toDouble(),
                                top: controller.heightPos.value.toDouble()),
                            child: Text(
                              (store.user?.mobile ?? "").toString(),
                              style: AppTextStyles.body
                                  .copyWith(color: AppColors.gray),
                            ),
                          )),
                      Obx(() => (controller.courseDetails.value?.videoDemo !=
                                  null &&
                              (!controller.isVideoPlayed2.value))
                          ? Container(
                              height: _height * 0.28,
                              width: _width,
                              margin: EdgeInsets.only(left: 30, right: 30),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () => {
                                        videoDuration = Duration(),
                                        videoDuration = controller
                                            .courseDetailsVideoController
                                            ?.position,
                                        controller.courseDetailsVideoController
                                            ?.seekTo(Duration(
                                                seconds:
                                                    videoDuration!.inSeconds -
                                                        10))
                                      },
                                      child: Container(
                                          margin: EdgeInsets.only(top: 50),
                                          child: Transform(
                                              alignment: Alignment.center,
                                              transform: Matrix4.identity()
                                                ..scale(-1.0, 1.0, 1.0),
                                              child: Icon(
                                                Icons.forward_10_rounded,
                                                color: Color(0xffffffff),
                                              ))),
                                    ),
                                    InkWell(
                                        onTap: () => {
                                              videoDuration = Duration(),
                                              videoDuration = controller
                                                  .courseDetailsVideoController
                                                  ?.position,
                                              controller
                                                  .courseDetailsVideoController
                                                  ?.seekTo(Duration(
                                                      seconds: videoDuration!
                                                              .inSeconds +
                                                          10))
                                            },
                                        child: Container(
                                            margin: EdgeInsets.only(top: 50),
                                            child: Icon(
                                              Icons.forward_10_rounded,
                                              color: Color(0xffffffff),
                                            )))
                                  ],
                                ),
                              ),
                            )
                          : Container())
                    ],
                  )),
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 48,
                          width: 33,
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(200),
                                child: Image.network(
                                  height: 40,
                                  width: 40,
                                  controller.courseDetails.value?.teacher
                                          ?.avatar ??
                                      "" /*"https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"*/,
                                  fit: BoxFit.fill,
                                  loadingBuilder: (context, child,
                                          loadingProgress) =>
                                      (loadingProgress == null)
                                          ? child
                                          : Center(
                                              child:
                                                  CircularProgressIndicator()),
                                  errorBuilder: (context, error, stackTrace) =>
                                      Center(
                                          child: Image(image: AssetImage('assets/images/edu_gate_logo2.png'),)),
                                )),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              controller
                                      .courseDetails.value?.teacher?.fullName ??
                                  "" /*"the king"*/,
                              maxLines: 1,
                              style: AppTextStyles.title
                                  .copyWith(color: AppColors.gray),
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  StarRating(
                                    rating: double.parse(controller
                                            .courseDetails
                                            .value
                                            ?.teacher
                                            ?.rate ??
                                        "0"),
                                    onRatingChanged: (rating) =>
                                        {} /* setState(() => this.rating = rating)*/,
                                    color: AppColors.yello,
                                  ),
                                  InkWell(
                                    onTap: () => {
                                      controller.isFavourite.value =
                                          !controller.isFavourite.value,
                                      controller.toggleFavourits()
                                    },
                                    child: controller.isFavourite.value
                                        ? SvgPicture.asset(
                                            Assets.imagesHeartFav,
                                          )
                                        : Icon(Icons.favorite_border_rounded),
                                  ),
                                  // controller.courseDetails.value?.shareLink ??
                                  //         false ?
                                  InkWell(
                                          onTap: () => {
                                            Utils.createDynamicLink(
                                                true, _courseID.toString())
                                          },
                                          child: Icon(Icons.share),
                                        )
                                      // : Container()
                                ]),
                          ],
                        )
                      ],
                    ),
                    Container(
                      width: 115,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          (!(controller.courseDetails.value?.authHasBought ??
                                      false) ||
                                  (((controller.courseDetails.value
                                              ?.authHasBought ??
                                          false) &&
                                      getAllPercentages(controller
                                              .courseContentList.value) >=
                                          100.0 &&
                                      (controller.courseDetails.value
                                              ?.authHasBought ??
                                          false))))
                              ? Text(
                                  controller.courseDetails.value?.price == 0
                                      ? _local.free
                                      : "${controller.courseDetails.value?.price} ${_local.egp}",
                                  style: AppTextStyles.titleToolbar
                                      .copyWith(color: AppColors.red),
                                )
                              : Container(),
                          SizedBox(
                            width: 10,
                          ),
                          ((getAllPercentages(
                                          controller.courseContentList.value) <
                                      100.0 &&
                                  (controller
                                          .courseDetails.value?.authHasBought ??
                                      false)))
                              ? ((controller.courseDetails.value
                                              ?.codeUsableTime ??
                                          0) !=
                                      0
                                  ? Expanded(
                                      child: CircularPercentIndicator(
                                        radius: 25.0,
                                        lineWidth: 4.0,
                                        percent: (getAllPercentages(controller
                                                .courseContentList.value) /
                                            100.0),
                                        center: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: 30,
                                              child: Text(
                                                "${getAllPercentages(controller.courseContentList.value).toString()}%",
                                                maxLines: 1,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Text(
                                              "%",
                                              maxLines: 1,
                                            ),
                                          ],
                                        ),
                                        progressColor: Colors.red,
                                      ),
                                    )
                                  : Container())
                              : Container()
                        ],
                      ),
                    )
                  ],
                ),
              )
              /* ListTile(
            minLeadingWidth: 33,
            minVerticalPadding: 10,
            contentPadding: EdgeInsets.all(2),
            leading: SizedBox(
              height: 48,
              width: 33,
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: Image.network(
                      height: 38,
                      width: 38,
                      controller.courseDetails.value?.teacher?.avatar ??
                          "" */ /*"https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"*/ /*,
                      fit: BoxFit.fill,
                      loadingBuilder: (context, child, loadingProgress) =>
                          (loadingProgress == null)
                              ? child
                              : Center(child: CircularProgressIndicator()),
                      errorBuilder: (context, error, stackTrace) =>
                          Center(child: SvgPicture.asset(Assets.assetsImagesEClassesLogoMain)),
                    )),
              ),
            ),
            title: Text(
              controller.courseDetails.value?.teacher?.fullName ??
                  "" */ /*"the king"*/ /*,
              maxLines: 1,
              style: AppTextStyles.title.copyWith(color: AppColors.gray),
            ),
            subtitle: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: StarRating(
                      rating: double.parse(
                          controller.courseDetails.value?.teacher?.rate ?? "0"),
                      onRatingChanged: (rating) =>
                          {} */ /* setState(() => this.rating = rating)*/ /*,
                      color: AppColors.yello,
                    ),
                  ),

                  InkWell(
                    onTap: () => {
                      controller.isFavourite.value =
                          !controller.isFavourite.value,
                      controller.toggleFavourits()
                    },
                    child: controller.isFavourite.value
                        ? SvgPicture.asset(
                            Assets.imagesHeartFav,
                          )
                        : Icon(Icons.favorite_border_rounded),
                  ),
                  controller.courseDetails.value?.shareLink ?? false
                      ? InkWell(
                          onTap: () => {
                            Utils.createDynamicLink(true, _courseID.toString())
                          },
                          child: Icon(Icons.share),
                        )
                      : Container()
                ]),
            trailing: Container(
              width: 115,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                 ( !(controller.courseDetails.value?.authHasBought ?? false)||(
                     ((controller.courseDetails.value
                         ?.authHasBought ??
                         false) &&getAllPercentages(controller.courseContentList.value)>=100.0&&
                         (controller.courseDetails.value?.authHasBought ?? false))
                 ))
                      ? Text(
                   controller.courseDetails.value?.price == 0
                       ? _local.free
                       : "${controller.courseDetails.value?.price} ${_local.egp}",
                          style: AppTextStyles.titleToolbar
                              .copyWith(color: AppColors.red),
                        )
                      : Container(),
                  SizedBox(
                    width: 10,
                  ),
                 ((getAllPercentages(controller.courseContentList.value)<100.0&&
                     (controller.courseDetails.value?.authHasBought ?? false))&&( controller.courseDetails.value?.authHasBought ?? false))
                      ? Expanded(
                          child: CircularPercentIndicator(
                            radius: 25.0,
                            lineWidth: 4.0,
                            percent: ((controller.courseDetails.value
                                            ?.progressPercent ??
                                        0)
                                    .toDouble() /
                                100.0),
                            center: new Text(
                                "${controller.courseDetails.value?.progressPercent.toString()}%"),
                            progressColor: Colors.red,
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          )*/
            ],
          ),
        ));
  }

  _buildTabBar() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: PreferredSize(
          preferredSize: Size.fromHeight(130),

          ///Note: Here I assigned 40 according to me. You can adjust this size acoording to your purpose.
          child: Container(
            //    color: Colors.white,
            child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  controller: controller.tabController,
                  //isScrollable: true,
                  indicatorColor: Colors.white,
                  unselectedLabelColor: AppColors.gray,
                  labelStyle: AppTextStyles.title2,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelPadding: EdgeInsets.symmetric(horizontal: 7),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.primary,
                  ),
                  tabs: [
                    Tab(
                        child: Container(
                      width: 120,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(_local.content),
                      ),
                    )),
                    Tab(
                        child: Container(
                      width: 120,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(_local.description),
                      ),
                    )),
                    Tab(
                        child: Container(
                      width: 120,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          _local.rating,
                        ),
                      ),
                    )),
                    Tab(
                        child: Container(
                      width: 120,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          _local.comments,
                        ),
                      ),
                    ))
                  ],
                  onTap: (index) => {
                    print("===>"),
                    controller.selectedTabIndex.value = index,
                    getData(),
                    print(index)
                  },
                )),
          )),
    );
  }

  getData() {
    switch (controller.selectedTabIndex.value) {
      case 0:
        controller.getCourseContents(_courseID);
        break;
      case 1:
        break;
      case 2:
        controller.getCourseReviews(_courseID);
        break;
      case 3:
        controller.myQuestionsList.value = [];
        controller.isLastPage = false;
        controller.currentPage = 1;
        controller.getChaptersQuestions("webinars", _courseID);
        break;
    }
  }

  getAllPercentages(List<dynamic> contents) {
    double percentage = 0.0;
    int length = 0;
    contents.forEach((element) {
      if (element.type != "quiz") {
        if ((element?.codeUsableTime ?? 0) == 0) {
          percentage = 0.0;
        } else {
          var percentageFile = double.parse(
              (((double.parse((element.viewCount ?? 0).toString())) /
                      (double.parse(
                          (controller.courseDetails.value?.codeUsableTime ?? 1)
                              .toString()))))
                  .toString());
          percentageFile = percentageFile.isNaN ? 0 : (percentageFile * 100.0);
          element
              .setPercentage(percentageFile > 100.0 ? 100.0 : percentageFile);

          percentage += double.parse((percentageFile).toString());
        }
        length++;
      }
    });
    print("getAllPercentages${percentage}");
    percentage = percentage / length;
    return percentage;
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Container _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => 60;

  @override
  double get maxExtent => 80;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
