import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/base/base_controller/BaseController.dart';
import '../../../app/util/util.dart';
import '../../../data/models/auth/LoginRequest.dart';
import '../../../data/models/auth/LoginResponse.dart';
import '../../../domain/usecases/auth_use_case.dart';
import '../../pages/auth/otp/otp_screen.dart';
import '../../pages/home/parent_main_screen.dart';
import '../../widgets/custom_toast/custom_toast.dart';
import '../home/home_binding.dart';

class LoginController extends BaseController {
  LoginController(this._loginUseCase);

  final AuthUseCase _loginUseCase;

  LoginRequest loginRequest = LoginRequest();

  late TextEditingController phoneController;

  late TextEditingController passController;






  @override
  void onInit() async {
    super.onInit();
    
    phoneController = TextEditingController();
    passController = TextEditingController();
  }

  login(BuildContext context) async {
    try {
      loading();
      String androidId=await Utils.getDeviceInfo(context);
      loginRequest.username = phoneController.text.toString();
      loginRequest.password = passController.text.toString();
      loginRequest.deviceId = androidId;
      final loginResponse = await _loginUseCase.login(loginRequest);

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
              Get.to(OtpScreen(NavigationFrom.login,userPass:passController.text.toString() ,),);
              break;
          }
          clearInputs();
          break;
        case false:
          switch (status) {
            case /*AuthStatus.go_step_2.staus*/ "go_step_2":
              Get.to(OtpScreen(NavigationFrom.login,userID: loginResponse.loginData!.userId.toString(),mobile: loginRequest.username,userPass:passController.text.toString() ));
              clearInputs();
              break;
            default:
              showToast(loginResponse.message.toString(),
                  gravity: Toast.bottom,isSuccess: false);
              break;
          }
          break;
      }
    } catch (error) {
      login(context);
      showToast(error.toString(), gravity: Toast.bottom);
      dismissLoading();
    }
  }

  void clearInputs() {
    phoneController.clear();
    passController.clear();
  }
  @override
  void dispose() {
    phoneController.dispose();
    passController.dispose();
    super.dispose();
  }


}
