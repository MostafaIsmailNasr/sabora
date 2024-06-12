
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:helpers/helpers.dart';
import 'package:provider/provider.dart';
import 'package:video_viewer/data/repositories/video.dart';
import 'package:video_viewer/domain/bloc/controller.dart';
import 'package:video_viewer/ui/fullscreen.dart';

import '../../../../app/config/app_colors.dart';
import '../../../../app/config/app_text_styles.dart';
import '../../../../app/services/local_storage.dart';
import '../../../controllers/course_details/course_details_controller.dart';

typedef PlayPauseCallback = void Function(bool);

class MyVideoViewerController extends VideoViewerController {
  // bool _isPlayed = false;
  //

  @override
  bool get isFullScreen => _isFullScreen;

  bool
      _isFullScreen = false,_isCourseDetails=false;
  // bool get isPlayed => _isPlayed;
  @override
  bool _isGoingToOpenOrCloseFullscreen = false;
  PlayPauseCallback? _playPauseCallback;

  CourseDetailsController? _courseDetailsController;

  setCourseDetailsController(CourseDetailsController? controller,bool isCourseDetails) {
    _courseDetailsController = controller;
    _isCourseDetails=isCourseDetails;
  }

  setOnPlayPauseCallBack(PlayPauseCallback? playPauseCallback) {
    _playPauseCallback = playPauseCallback;
  }

  Future<void> _seekToBegin() async {
    if (position >= duration) await seekTo(beginRange);
  }

  @override
  Future<void> playOrPause() async {
    print("playOrPause${_playPauseCallback}");
    if (isPlaying) {
      await pause();
      if (_playPauseCallback != null) _playPauseCallback!(false);
    } else {
      await _seekToBegin();
      await play();
      if (_playPauseCallback != null) _playPauseCallback!(true);

    }
  }

  //----------//
  //FULLSCREEN//
  //----------//
  @override
  Future<void> openOrCloseFullscreen() async {


    if (!_isGoingToOpenOrCloseFullscreen) {
      _isGoingToOpenOrCloseFullscreen = true;
      if (!_isFullScreen) {
        await openFullScreen();
      } else {
        _isFullScreen=false;
        await closeFullScreen();
        SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp]);
      }
      _isGoingToOpenOrCloseFullscreen = false;
    }
    notifyListeners();

  }
  
  @override
  Future<void> closeFullScreen() async {
   // super.closeFullScreen();
    // if (_isFullScreen) {
       _isFullScreen = false;
      await Misc.setSystemOverlay(SystemOverlay.values);
      await Misc.setSystemOrientation(SystemOrientation.values);
      context?.navigator.pop();
    // }
  }

  @override
  Future<void> openFullScreen() async {
    final store = Get.find<LocalStorageService>();
    Duration? videoDuration;
    if (context != null && !_isFullScreen) {
      _isFullScreen = true;
      final VideoQuery query = VideoQuery();
      final metadata = query.videoMetadata(context!);
      final Duration transition = metadata.style.transitions;
      context?.navigator.push(PageRouteBuilder(
        opaque: false,
        fullscreenDialog: true,
        transitionDuration: transition,
        reverseTransitionDuration: transition,
        pageBuilder: (_, __, ___) => MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: query.video(context!)),
            Provider.value(value: metadata),
          ],
          child: Obx(() => Stack(
            // fit: StackFit.expand,
            children: [
            Directionality(
            textDirection: TextDirection.ltr,
            child:FullScreenPage(
                fixedLandscape: metadata.onFullscreenFixLandscape,
              )),
             /*Obx(() => */ Container(

             //  color: Colors.black,
               margin: EdgeInsetsDirectional.only(
                   start:  _courseDetailsController!.widthPos.value.toDouble(),
                   top: _courseDetailsController!.heightPos.value.toDouble()),
               child: Text(
                 (store.user?.mobile??"").toString(),
                 style: AppTextStyles.body.copyWith(color: AppColors.gray),
               ),
             )/*)*/,

           /* Obx(() => */ (_courseDetailsController?.courseDetails.value?.videoDemo !=
                null &&
                (!(_courseDetailsController?.isVideoPlayed2.value??false)))
                ?  PositionedDirectional(
              start: 40,
              top: 0,
              bottom: 0,
              child:       InkWell(
                  onTap: () => {
                    print("tappped==>0"),
                    videoDuration = Duration(),
                    videoDuration = _isCourseDetails? _courseDetailsController?.courseDetailsVideoController?.position:_courseDetailsController?.chapterDetailsVideoController?.position,
                    (_isCourseDetails?_courseDetailsController?.courseDetailsVideoController:_courseDetailsController?.chapterDetailsVideoController)
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
                      ))),):Container()/*)*/,
              /*Obx(() => */ (_courseDetailsController?.courseDetails.value?.videoDemo !=
                  null &&
                  (!(_courseDetailsController?.isVideoPlayed2.value??false)))
                  ?  PositionedDirectional(
                end: 40,
                top: 0,
                bottom: 0,
                child:        InkWell(
                onTap: () => {
                  print("tappped==>"),
                  videoDuration = Duration(),
                  videoDuration =_isCourseDetails? _courseDetailsController?.courseDetailsVideoController?.position:_courseDetailsController?.chapterDetailsVideoController?.position,
                  (_isCourseDetails?_courseDetailsController?.courseDetailsVideoController:_courseDetailsController?.chapterDetailsVideoController)
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
              ),):Container()/*)*/
          /*    Obx(() => (_courseDetailsController?.courseDetails.value?.videoDemo !=
                  null &&
                  (!(_courseDetailsController?.isVideoPlayed2.value??false)))
                  ? Container(
              //  height:MediaQuery.of(context!).size.height,
                    //  width: MediaQuery.of(context!).size.width,
                margin: EdgeInsets.only(left: 30, right: 30),
                child: Center(
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      InkWell(
                          onTap: () => {
                            print("tappped==>0"),
                            videoDuration = Duration(),
                            videoDuration = _isCourseDetails? _courseDetailsController?.courseDetailsVideoController?.position:_courseDetailsController?.chapterDetailsVideoController?.position,
                            (_isCourseDetails?_courseDetailsController?.courseDetailsVideoController:_courseDetailsController?.chapterDetailsVideoController)
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
                              ))),
                      Expanded(child: Container()),
                      InkWell(
                          onTap: () => {
                            print("tappped==>"),
                            videoDuration = Duration(),
                            videoDuration =_isCourseDetails? _courseDetailsController?.courseDetailsVideoController?.position:_courseDetailsController?.chapterDetailsVideoController?.position,
                            (_isCourseDetails?_courseDetailsController?.courseDetailsVideoController:_courseDetailsController?.chapterDetailsVideoController)
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
                    ],
                  ),
                ),
              )
                  : Container())*/
            ],
          )),
        ),
      ));
    }
  }


}
