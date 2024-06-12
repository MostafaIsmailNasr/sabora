import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_controller.dart';

import '../../../app/base/base_controller/BaseController.dart';
import '../../../app/util/util.dart';
import '../../../data/models/auth/LoginRequest.dart';
import '../../../data/models/auth/LoginResponse.dart';
import '../../../data/models/auth/register/RegisterStep3Request.dart';
import '../../../data/models/auth/verifyUser/VerifyUserRequest.dart';
import '../../../domain/usecases/auth_use_case.dart';
import '../../pages/auth/otp/otp_screen.dart';
import '../../pages/auth/resetPass/reset_pass_screen.dart';
import '../../pages/home/parent_main_screen.dart';
import '../../widgets/custom_toast/custom_toast.dart';
import '../home/home_binding.dart';

class VerificationController extends BaseController {
  VerificationController(this._authUseCase);

  final AuthUseCase _authUseCase;

  // Controller
  late final CountdownController controllerTimer;
  String? codePin;
  BuildContext? mContext;
  FirebaseAuth auth = FirebaseAuth.instance;
  NavigationFrom? from;
  String? userID;
  String? userPass;
  String? fullName;

  String? resetPassToken;
  String? phoneNumber;
  String? verificationIdSent;
  int? resendPhoneToken;


  RxBool isTimeEnded = false.obs;
  RxString remainingTime = "".obs;

  @override
  void onInit() async {
    super.onInit();
    controllerTimer =
    new CountdownController(autoStart: true);
  }

  void resetTime() {
    controllerTimer.start();
    isTimeEnded.value = false;
  }

  onTimeEnd() {
    print('onEnd');
    isTimeEnded.value = true;
  }

  sendCodeToPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+20${phoneNumber}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!

        // Sign the user in (or link) with the auto-generated credential
        var result = await auth.signInWithCredential(credential);
        navigateToNextScreen(mContext!);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }

        showToast(e.code);
        showToast("e.code");
        print(e.message.toString());
        // Handle other errors
      },
      codeSent: (String verificationId, int? resendToken) async {
        verificationIdSent = verificationId;
        resendPhoneToken = resendToken;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  verifyPhoneNumber(BuildContext context) async {
    // Update the UI - wait for the user to enter the SMS code
    loading();
    String? smsCode = codePin;

    if (smsCode == null) return;

    if (checkCodeIfExistsInAppConfig(smsCode)) {
      navigateToNextScreen(context);
    } else {
      if (verificationIdSent == null){
        dismissLoading();
        return;
      }
      try {
        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationIdSent!, smsCode: smsCode);

        // Sign the user in (or link) with the credential
        var user = await auth.signInWithCredential(credential);

      if(user.user!=null) {
       // var loginResult=await auth.signInWithCredential(user.credential!);
       // if(loginResult.user != null){
       //   navigateToNextScreen();
       // }else{
       //   showToast("Code invalid");
       // }
        navigateToNextScreen(context);

      }else{
        showToast("Code invalid",isSuccess: false);
      }

      }catch( e){
       // showToast(e.toString());
        print(e.toString());
        showToast("Code invalid",isSuccess: false);
        dismissLoading();
      }
    }
    dismissLoading();
  }

  bool checkCodeIfExistsInAppConfig(String code) {
    if (store.settingsConfig != null) {
      if (store.settingsConfig!.publicVerificationCode != null) {
        for (String vCode in store.settingsConfig!.publicVerificationCode!) {
          if (vCode == code) {
            return true;
          }
        }
      }
    }
    return false;
  }

  verifyUser(BuildContext context) async {
    VerifyUserRequest verifyUserRequest = VerifyUserRequest();
    verifyUserRequest.user_id = userID;
    try {
      final verifyResponse = await _authUseCase.verifyUser(verifyUserRequest);
      print("profileResponse");
      print(verifyResponse.message);
      switch (verifyResponse.success) {
        case true:
          switch (from) {
            case NavigationFrom.login:
              //Get.offAll(LoginScreen(), binding: AuthBinding());
              login(context);
              break;
            case NavigationFrom.register:
              registerStep3();
              break;
          }

          break;
        case false:
          showToast(verifyResponse.message.toString(), gravity: Toast.bottom);
          break;
      }
    } catch (error) {
      verifyUser(context);
     // showToast(error.toString(), gravity: Toast.bottom);
    }
  }

  registerStep3() async {
    RegisterStep3Request registerStep3Request = RegisterStep3Request();
    registerStep3Request.userId = userID;
    registerStep3Request.fullName = fullName;
    try {
      final registerStep3Response =
          await _authUseCase.registerStep3(registerStep3Request);
      print("registerStep3Response");
      print(registerStep3Response.message);
      switch (registerStep3Response.success) {
        case true:
          isLoggedIn.value = true;
          store.apiToken = registerStep3Response.dataStep3?.token;
          isLoggedIn.refresh();
          store.userID = registerStep3Response.dataStep3?.userId.toString();
          Get.offAll(ParentMainScreen(), binding: HomeBinding());
          break;
        case false:
          showToast(registerStep3Response.message.toString(),
              gravity: Toast.bottom);
          break;
      }
    } catch (error) {
      registerStep3();
      //showToast(error.toString(), gravity: Toast.bottom);
    }
  }


  login(BuildContext context) async {
    try {
      loading();
      String androidId=await Utils.getDeviceInfo(context);

      LoginRequest loginRequest = LoginRequest();
      loginRequest.username = phoneNumber.toString();
      loginRequest.password = userPass.toString();
      loginRequest.deviceId = androidId;
      final loginResponse = await _authUseCase.login(loginRequest);

      print("loginResponse");
      print(loginResponse.message);
      dismissLoading();
      final status = (loginResponse as LoginResponse).status!;
      switch ((loginResponse as LoginResponse).success) {
        case true:
          switch (status) {
            case /*AuthStatus.login.staus*/ "login":

              isLoggedIn.value = true;
              store.apiToken = loginResponse.loginData?.token;
              isLoggedIn.refresh();
              store.userID = loginResponse.loginData?.userId.toString();
              Get.offAll(ParentMainScreen(), binding: HomeBinding());
              break;
            case /*AuthStatus.go_step_2.staus*/ "go_step_2":
              Get.to(OtpScreen(NavigationFrom.login));
              break;
          }

          break;
        case false:
          switch (status) {
            case /*AuthStatus.go_step_2.staus*/ "go_step_2":
              Get.to(OtpScreen(NavigationFrom.login,userID: loginResponse.loginData!.userId.toString(),mobile: loginRequest.username));
              break;
            default:
              showToast(loginResponse.message.toString(),
                  gravity: Toast.bottom);
              break;
          }
          break;
      }
    } catch (error) {
      login(context);
      //showToast(error.toString(), gravity: Toast.bottom);
      dismissLoading();
    }
  }
  void navigateToNextScreen(BuildContext context) {
    switch (from) {
      case NavigationFrom.register:
      case NavigationFrom.login:
        verifyUser(context);
        break;
      case NavigationFrom.forgetPass:
        Get.off(ResetPassScreen(resetPassToken, phoneNumber));
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
