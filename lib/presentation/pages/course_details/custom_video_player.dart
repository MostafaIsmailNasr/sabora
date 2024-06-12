import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helpers/helpers.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:video_viewer/domain/bloc/controller.dart';
import 'package:video_viewer/domain/entities/styles/video_viewer.dart';

import '../../../generated/assets.dart';


/// SUMMARY
/// 1. Models
/// 2. Constants
/// 3. Main Aplications
/// 4. Pages
/// 5. Video Viewer Widgets
/// 6. Movie Card Widgets
/// 7. Misc Widgets

//------//
//MODELS//
//------//
enum MovieStyle { card, page }

class Movie {
  const Movie({
    required this.thumbnail,
    required this.title,
    required this.category,
    this.isFavorite = false,
  });

  final String thumbnail, title, category;
  final bool isFavorite;
}

class Serie extends Movie {
  const Serie({
    required this.source,
    required String thumbnail,
    required String title,
    required String category,
    bool isFavorite = false,
  }) : super(
    thumbnail: thumbnail,
    title: title,
    category: category,
    isFavorite: isFavorite,
  );

  final Map<String, SerieSource> source;
}

class SerieSource {
  const SerieSource({
    required this.thumbnail,
    required this.source,
  });

  final Map<String, String> source;
  final String thumbnail;
}

class CustomVideoViewerStyle extends VideoViewerStyle {
  CustomVideoViewerStyle({required Movie movie, required BuildContext context})
      : super(
    textStyle: context.textTheme.subtitle1,
      forwardAndRewindStyle:ForwardAndRewindStyle(),
    playAndPauseStyle:
    PlayAndPauseWidgetStyle(background: context.color.primary),
    progressBarStyle: ProgressBarStyle(
      bar: BarStyle.progress(color: context.color.primary),
    ),

    header: Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Headline6(
        movie.title,
        style: TextStyle(color: context.textTheme.headline4?.color),
      ),
    ),
    thumbnail: Container(
      decoration: BoxDecoration(
         // color: AppColors.gray,
          borderRadius: BorderRadius.circular(16)
      ),
      child: Stack(children: [
        Positioned.fill(child: MovieImage(movie)),
        // Positioned.fill(
        //   child: Image.network(movie.thumbnail, fit: BoxFit.cover),
        // ),
      ]),
    ),
  );
}

class MovieImage extends StatelessWidget {
  const MovieImage(this.movie, {Key? key}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {

    return Hero(
      tag: movie.title + "Thumbnail",
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        child: Image.network(movie.thumbnail, fit: BoxFit.cover,loadingBuilder: (context, child, loadingProgress) =>
    (loadingProgress == null)
    ? child
        : Center(child: CircularProgressIndicator()),
    errorBuilder: (context, error, stackTrace) =>
    Center(child: Image(image: AssetImage('assets/images/edu_gate_logo2.png'),)),
      ))
    );
  }
}


class VideoViewerOrientation extends StatefulWidget {
  const VideoViewerOrientation({
    Key? key,
    required this.child,
    required this.controller,
  }) : super(key: key);

  final Widget child;
  final VideoViewerController controller;

  @override
  _VideoViewerOrientationState createState() => _VideoViewerOrientationState();
}

class _VideoViewerOrientationState extends State<VideoViewerOrientation> {
  late StreamSubscription<NativeDeviceOrientation> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _subscription = NativeDeviceOrientationCommunicator()
        .onOrientationChanged()
        .listen(_onOrientationChanged);
    super.initState();
  }

  void _onOrientationChanged(NativeDeviceOrientation orientation) {
    final bool isFullScreen = widget.controller.isFullScreen;
    final bool isLandscape =
        orientation == NativeDeviceOrientation.landscapeLeft ||
            orientation == NativeDeviceOrientation.landscapeRight;
    if (!isFullScreen && isLandscape) {
      printGreen("OPEN FULLSCREEN");
      widget.controller.openFullScreen();
    } else if (isFullScreen && !isLandscape) {
      printRed("CLOSING FULLSCREEN");
      widget.controller.closeFullScreen();
      Misc.delayed(300, () {
        Misc.setSystemOverlay(SystemOverlay.values);
        Misc.setSystemOrientation(SystemOrientation.values);
      });
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}