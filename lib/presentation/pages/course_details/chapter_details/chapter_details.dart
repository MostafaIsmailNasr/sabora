
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:video_viewer/video_viewer.dart';

import '../../../../app/config/app_colors.dart';
import '../../../../app/config/app_text_styles.dart';
import '../../../../app/services/local_storage.dart';
import '../../../../data/models/course_details/ContentData.dart';
import '../../../../data/models/home/course_details/Course.dart';
import '../../../../generated/assets.dart';
import '../../../controllers/course_details/course_details_binding.dart';
import '../../../controllers/course_details/course_details_controller.dart';
import '../../../widgets/add_comment/add_comment.dart';
import '../../../widgets/button.dart';
import '../../../widgets/custom_toast/custom_toast.dart';
import '../../../widgets/item_user_rate/user_rate_item.dart';
import '../../../widgets/main_toolbar/main_toolbar.dart';
import '../course_details.dart';
import '../video_controller/video_controller.dart';
import 'pdf_view.dart';

class ChapterDetailsScreen extends GetView<CourseDetailsController> {
  late AppLocalizations _local;
  late double _height;
  late double _width;
  final store = Get.find<LocalStorageService>();
  Duration? videoDuration;
  final MyVideoViewerController videoController = MyVideoViewerController();
  BuildContext? mContext;
  ContentData contentList;
  Course? mCourse;
  ChapterDetailsScreen(this.contentList,this.mCourse );
  var isFirstTime = true;
  Future<bool> _willPopCallback() async {
    // await showDialog or Show add banners or whatever
    // then
    controller.i = 0;
    controller.isVideoPlayed = false;
    controller.sendViewToServer = true;
    controller.timer!.cancel();
    CourseDetailsBinding().dependencies();
    Navigator.of(mContext!).pushReplacement(MaterialPageRoute(builder: (context) =>CourseDetailsScreen(mCourse!.id.toString())));
    return Future.value(true);
  }


  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    mContext=context;
    ToastMContext().init(context);
    _local = AppLocalizations.of(context)!;
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.height;
    controller.contentid=contentList.id.toString();
    if(isFirstTime) {
      controller.chapterDetailsVideoController = videoController;
      controller.chapterDetailsVideoController!.setCourseDetailsController(controller,false);
      controller.setOnPlayPauseCallBack();
      controller.getChaptersQuestions("files",controller.contentid);
      isFirstTime=false;
    }
    controller.i = 1;
    controller.isVideoPlayed = false;

    controller.sendViewToServer = true;
    controller.mFile=contentList;
    controller.randomPositionForNumber();



    return WillPopScope(
        onWillPop: _willPopCallback,
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white24,
            appBar: buildMainToolBar(
                controller, contentList.title ?? "", () => {_willPopCallback()}),
            body: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              contentList.title ?? "",
                              style: AppTextStyles.titleToolbar
                                  .copyWith(fontSize: 16),
                            ),
                            Text(
                              "",
                              style: AppTextStyles.title2,
                            ),
                            /* StarRating(
                rating: 4.2,
                onRatingChanged: (rating) =>
                {} */ /* setState(() => this.rating = rating)*/ /*,
                color: AppColors.yello,
              ),*/
                            contentList.fileType == "mp4"
                                ?        Directionality(
                                textDirection: TextDirection.ltr,
                                child:  Stack(
                              children: [
                                /* Container(
                                        margin: EdgeInsets.only(top: 20),
                                        height: _width * 0.24,
                                        width: _width,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              height: _width * 0.24,
                                              width: _width,
                                              "course?.image ??"
                                              "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
                                              fit: BoxFit.fill,
                                              loadingBuilder: (context, child,
                                                      loadingProgress) =>
                                                  (loadingProgress == null)
                                                      ? child
                                                      : Center(
                                                          child:
                                                              CircularProgressIndicator()),
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Center(
                                                      child: Image.asset(Assets
                                                          .imagesMainLogoBlue)),
                                            )),
                                      )*/
                                     Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.gray,
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        margin: EdgeInsets.only(top: 10),
                                        height: _width * 0.24,
                                        width: _width,
                                        child: /*VideoViewerOrientation(
                           //   controller: VideoViewerController(),
                              child: */
                                        Directionality(
                                          textDirection: TextDirection.ltr,
                                          child:  VideoViewer(
                                            language: VideoViewerLanguage.en,
                                            key: controller.stickyKeyChapter,
                                          controller: controller
                                                .chapterDetailsVideoController,
                                                enableVerticalSwapingGesture : false,
                                                enableHorizontalSwapingGesture : false,
                                                enableShowReplayIconAtVideoEnd : true,
                                          //controller: VideoViewerController(),
                                          onFullscreenFixLandscape: true,
                                            enableFullscreenScale:true,
                                          source: {
                                              "": VideoSource(
                                                video: VideoPlayerController.network(
                                                   /* APIEndpoint.baseURL +*/
                                                        (contentList.file ?? "").toString().replaceAll(" ","%20")
                                                    //"https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
                                                    ),
                                                ads: [
                                                  /* VideoViewerAd(
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
                                      ),*/
                                                ],
                                              /*  range: Tween<Duration>(
                                                  begin:
                                                      const Duration(seconds: 5),
                                                  end:
                                                      const Duration(seconds: 25),
                                                ),*/
                                              ),
                                          },

                                        /*  style: CustomVideoViewerStyle(
                                                movie: const Movie(
                                                    title: "",
                                                    category: "",
                                                    thumbnail:
                                                     ""  *//* "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6w8rSenm_-vq5lSBjr0iDJ8r5N8cDL0U6wPLGS0AG&s"*//*),
                                                context: context),*/
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
                                      ) /*)*/
                                ,
                        Obx(() =>  Container(
                                  margin: EdgeInsetsDirectional.only(
                                      start:  controller.widthPos.value.toDouble(),
                                      top: controller.heightPos.value.toDouble()),
                                  child: Text(
                                    (store.user?.mobile??"").toString(),
                                    style: AppTextStyles.body.copyWith(color: AppColors.gray),
                                  ),
                                )),
                                Obx(() => (contentList.fileType == "mp4" &&
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
                                                .chapterDetailsVideoController
                                                ?.position,
                                            controller.chapterDetailsVideoController
                                                ?.seekTo(Duration(
                                                seconds:
                                                videoDuration!.inSeconds -
                                                    10))
                                          },
                                          child: Container(
                                           //   margin: EdgeInsets.only(top: 50),
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
                                                  .chapterDetailsVideoController
                                                  ?.position,
                                              controller
                                                  .chapterDetailsVideoController
                                                  ?.seekTo(Duration(
                                                  seconds: videoDuration!
                                                      .inSeconds +
                                                      10))
                                            },
                                            child: Container(
                                              //  margin: EdgeInsets.only(top: 50),
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
                            )):Container(),
                            contentList.fileType == "video"
                                ?        Directionality(
                                textDirection: TextDirection.ltr,
                                child:  Stack(
                                  children: [
                                    /* Container(
                                        margin: EdgeInsets.only(top: 20),
                                        height: _width * 0.24,
                                        width: _width,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              height: _width * 0.24,
                                              width: _width,
                                              "course?.image ??"
                                              "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
                                              fit: BoxFit.fill,
                                              loadingBuilder: (context, child,
                                                      loadingProgress) =>
                                                  (loadingProgress == null)
                                                      ? child
                                                      : Center(
                                                          child:
                                                              CircularProgressIndicator()),
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Center(
                                                      child: Image.asset(Assets
                                                          .imagesMainLogoBlue)),
                                            )),
                                      )*/
                                    Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.gray,
                                          borderRadius:
                                          BorderRadius.circular(16)),
                                      margin: EdgeInsets.only(top: 10),
                                      height: _width * 0.24,
                                      width: _width,
                                      child: /*VideoViewerOrientation(
                           //   controller: VideoViewerController(),
                              child: */
                                      Directionality(
                                        textDirection: TextDirection.ltr,
                                        child:  VideoViewer(
                                          language: VideoViewerLanguage.en,
                                          key: controller.stickyKeyChapter,
                                          controller: controller
                                              .chapterDetailsVideoController,
                                          enableVerticalSwapingGesture : false,
                                          enableHorizontalSwapingGesture : false,
                                          enableShowReplayIconAtVideoEnd : true,
                                          //controller: VideoViewerController(),
                                          onFullscreenFixLandscape: true,
                                          enableFullscreenScale:true,
                                          source: {
                                            "": VideoSource(
                                              video: VideoPlayerController.network(
                                                /* APIEndpoint.baseURL +*/
                                                  (contentList.file ?? "").toString().replaceAll(" ","%20")
                                                //"https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
                                              ),
                                              ads: [
                                                /* VideoViewerAd(
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
                                      ),*/
                                              ],
                                              /*  range: Tween<Duration>(
                                                  begin:
                                                      const Duration(seconds: 5),
                                                  end:
                                                      const Duration(seconds: 25),
                                                ),*/
                                            ),
                                          },

                                          /*  style: CustomVideoViewerStyle(
                                                movie: const Movie(
                                                    title: "",
                                                    category: "",
                                                    thumbnail:
                                                     ""  *//* "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6w8rSenm_-vq5lSBjr0iDJ8r5N8cDL0U6wPLGS0AG&s"*//*),
                                                context: context),*/
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
                                    ) /*)*/
                                    ,
                                    Obx(() =>  Container(
                                      margin: EdgeInsetsDirectional.only(
                                          start:  controller.widthPos.value.toDouble(),
                                          top: controller.heightPos.value.toDouble()),
                                      child: Text(
                                        (store.user?.mobile??"").toString(),
                                        style: AppTextStyles.body.copyWith(color: AppColors.gray),
                                      ),
                                    )),
                                    Obx(() => (contentList.fileType == "video" &&
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
                                                    .chapterDetailsVideoController
                                                    ?.position,
                                                controller.chapterDetailsVideoController
                                                    ?.seekTo(Duration(
                                                    seconds:
                                                    videoDuration!.inSeconds -
                                                        10))
                                              },
                                              child: Container(
                                                //   margin: EdgeInsets.only(top: 50),
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
                                                      .chapterDetailsVideoController
                                                      ?.position,
                                                  controller
                                                      .chapterDetailsVideoController
                                                      ?.seekTo(Duration(
                                                      seconds: videoDuration!
                                                          .inSeconds +
                                                          10))
                                                },
                                                child: Container(
                                                  //  margin: EdgeInsets.only(top: 50),
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
                                )):Container(),
                            SizedBox(
                              height: 10,
                            ),
                            contentList.accessibility == "paid"? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      child: Card(
                                        elevation: 0,
                                        child: Stack(
                                          children: [
                                            Center(
                                                child: SvgPicture.asset(
                                              Assets.imagesEya,
                                              width: 35,
                                              height: 35,
                                            )),
                                            Center(
                                              child: Text(contentList.viewCount.toString()),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Text(
                                      _local.views,
                                      style: AppTextStyles.title2,
                                    )
                                  ],
                                ),
                                (contentList.accessibility == "paid"&&  (contentList?.codeUsableTime??0)!=0)?
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      child: Card(
                                        elevation: 0,
                                        child: CircularPercentIndicator(
                                          radius: 25.0,
                                          lineWidth: 4.0,
                                          percent:double.parse((contentList.percentage??"0").toString())/100,
                                          center:
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: 30,
                                                child: Text(
                                                  (contentList.percentage ?? "0").toString(),
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
                                      ),
                                    ),
                                    Text(
                                      _local.view_percentage,
                                      style: AppTextStyles.title2,
                                    ),
                                  ],
                                ):Container(),
                              ],
                            ):Container(),
                            Obx(() =>controller.isLoading.value?
                            Center(
                              child: CircularProgressIndicator(),
                            ): _buildChapterQuestions(controller.myQuestionsList.value))
                          ]),
                    ),
                  ),
                ),
                Row(
                  children: [
                    contentList.fileType == "pdf"?
                    Expanded(
                      child:Container(
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: myButton(() async{

                            if ((contentList.file??"").isNotEmpty) {
                              print("contentList.file");
                              print(contentList.file);
                            var path=await  createFileOfPdfUrl(contentList.file!!);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PDFScreen(path:path.path),
                                ),
                              );
                            }
                          }, _local.view)),
                    ):Container(),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: myButton(() {
                          showAddCommentBottomSheet(
                              context, (imagePth,
                              soundPath, mComment) {
                                print("nuuuo");
                            controller.addCommentWithImageAndVoice(contentList.id.toString(),"file",
                                contentList.id.toString(),
                                imagePth,
                                soundPath,
                                mComment);
                          });
                        }, _local.ask),
                      ),
                    ),
                  ],
                )
              ],
            )));
  }

  _buildChapterQuestions(List<dynamic> questions) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          _local.lesson_questions,
          style: AppTextStyles.titleToolbar,
        ),
    ListView.builder(
          controller: controller.scrollController,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: questions.length,
          itemBuilder: (context, position) {
            print("rrt");
            return buildUserCommentItem(questions[position]);
          },
        ),
      ],
    );
  }
}
