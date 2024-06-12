import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../../../app/config/app_colors.dart';
import '../../../app/config/app_text_styles.dart';
import '../../../domain/usecases/splash_use_case.dart';
import '../../../generated/assets.dart';
import '../../controllers/splash/splash_controller.dart';
import '../../widgets/custom_toast/custom_toast.dart';
import '../../widgets/jumping_dot.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}
class _SplashScreen extends State<SplashScreen>{

  late AppLocalizations _local;
  late VideoPlayerController videoPlayerController;
  // _SplashScreen({super.key});

  @override
  void initState() {
    super.initState();
    videoPlayerController =
    VideoPlayerController.asset('assets/video/Splash.mp4')..initialize().then((value) {
      setState(() {
        videoPlayerController.play();
      });
    });
  }
  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);

    ToastMContext().init(context);
    _local = AppLocalizations.of(context)!;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child:
        videoPlayerController.value.isInitialized
            ? AspectRatio(
          aspectRatio: videoPlayerController.value.aspectRatio,
          child: VideoPlayer(videoPlayerController),
        )
            : CircularProgressIndicator(),
      ),
    );
  }




}
