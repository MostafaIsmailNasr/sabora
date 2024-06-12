import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../app/base/base_controller/BaseController.dart';
import '../../../data/models/auth/ProfileResponse.dart';
import '../../../domain/usecases/splash_use_case.dart';
import '../../pages/home/parent_main_screen.dart';
import '../../pages/onboarding/onboarding.dart';
import '../../pages/welcome/welcome_screen.dart';
import '../../widgets/custom_toast/custom_toast.dart';
import '../auth/auth_binding.dart';
import '../home/home_binding.dart';
import '../network/GetXNetworkManager.dart';

class SplashController extends BaseController {
  SplashController(this.splashUseCase);

  final SplashUseCase splashUseCase;


  late VideoPlayerController videoPlayerController;
  bool startedPlaying = false;

  @override
  void onInit() async {
    super.onInit();
    final GetXNetworkManager _networkManager = Get.find<GetXNetworkManager>();

    getSettings();
    if (isLoggedIn.value) {
      getUserProfile();
    } else {
      if(_networkManager.connectionType==0) {
        if (store.isFirsLaunch ?? true) {
          goToOnboardingScreen();
        } else {
          goToWelcomeScreen();
        }
      }
    }

    videoPlayerController =
        VideoPlayerController.asset('assets/video/Splash.mp4')..initialize().then((value) {
          videoPlayerController.play();
          update();
        });
    // videoPlayerController.addListener(() {
    //   if (startedPlaying && !videoPlayerController.value.isPlaying) {
    //     // Navigator.pop(context);
    //   }
    // });
  }

  getUserProfile() async {
    try {
      final profileResponse =
          await splashUseCase.execute(store.userID.toString());
      print("profileResponse");
      print(profileResponse.userData?.user?.toJson());
      switch ((profileResponse).success) {
        case true:
          goToMainScreen(profileResponse);
          break;
        case false:
          if(store.isFirsLaunch??true){
            goToOnboardingScreen();
          }else {
            goToWelcomeScreen();
          }
          break;
      }
    } catch (error) {
      print(error);
      getUserProfile();
     // showToast(error.toString(), gravity: Toast.bottom);
    }
  }

  getSettings() async {
    //try {
      var settingsResponse = await splashUseCase.getSettings();
      store.settingsConfig=settingsResponse;
      return settingsResponse;
      // print("settingsResponse");
      // print(settingsResponse.toJson());
      //  store.settingsConfig=settingsResponse;

    // } catch (error) {
    //   //getSettings();
    //   showToast(error.toString(), gravity: Toast.bottom);
    // }
  }


  void goToMainScreen(ProfileResponse profileResponse) {
    store.user = profileResponse.userData?.user;
    Future.delayed(const Duration(milliseconds: 5000), () {
      Get.offAll(ParentMainScreen(), binding: HomeBinding());
    });
  }

  Future<bool> started() async {
    await videoPlayerController.initialize();
    await videoPlayerController.play();
    startedPlaying = true;
    return true;
  }

  // signUpWith(String username) async {
  //   try {
  //     final user = await _splashUseCase.execute(username);
  //     store.user = user;
  //     isLoggedIn.value = true;
  //     isLoggedIn.refresh();
  //   } catch (error) {}
  // }
  //
  // logout() {
  //   store.user = null;
  //   isLoggedIn.value = false;
  // }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }


  void goToWelcomeScreen() {
    Future.delayed(const Duration(milliseconds: 5000), () {
      Get.off(const WelcomeScreen(), binding: AuthBinding());
    });
  }

  void goToOnboardingScreen() {
    store.isFirsLaunch=(false);
    Future.delayed(const Duration(milliseconds: 5000), () {
      Get.off(const OnboardingScreen());
    });
  }

}
