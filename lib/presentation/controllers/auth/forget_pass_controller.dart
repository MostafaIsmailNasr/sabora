import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../app/base/base_controller/BaseController.dart';
import '../../../data/models/auth/forgetPass/ForgetPassRequest.dart';
import '../../../data/models/auth/resetPass/ResetPassRequest.dart';
import '../../../domain/usecases/auth_use_case.dart';
import '../../pages/auth/otp/otp_screen.dart';
import '../../widgets/custom_toast/custom_toast.dart';
import '../../widgets/success_reset_pass_dialog.dart';

class ForgetPassController extends BaseController {
  ForgetPassController(this._authUseCase);

  final AuthUseCase _authUseCase;
  BuildContext? context;
  AppLocalizations? local;
  ForgetPassRequest forgetPassRequest = ForgetPassRequest();
  ResetPassRequest resetPassRequest = ResetPassRequest();
  late TextEditingController phoneController;
  late TextEditingController passController;
  late TextEditingController confirmPassController;

  String? mobile;
  String? resetPassToken;

  @override
  void onInit() async {
    super.onInit();
    phoneController = TextEditingController();
    passController = TextEditingController();
    confirmPassController = TextEditingController();
    
  }

  forgetPass() async {
    loading();
    forgetPassRequest.mobile = phoneController.text;

    try {
      final forgetPassResponse =
          await _authUseCase.forgetPass(forgetPassRequest);
      dismissLoading();
      print("forgetPassResponse");
      print(forgetPassResponse.message);
      switch (forgetPassResponse.success) {
        case true:
          clearInputs();
          Get.off(OtpScreen(
            NavigationFrom.forgetPass,
            mobile: forgetPassRequest.mobile,
            resetPassToken: forgetPassResponse.tokenData!.token,
          ));
          break;
        case false:
          showToast(forgetPassResponse.message.toString(),
              gravity: Toast.bottom);
          break;
      }
    } catch (error) {
      forgetPass();
      //showToast(error.toString(), gravity: Toast.bottom);
    }
  }

  resetPass() async {
    loading();
    resetPassRequest.mobile = mobile;
    resetPassRequest.password = passController.text;
    resetPassRequest.passwordConfirmation = confirmPassController.text;
    try {
      final resetPassResponse =
          await _authUseCase.resetPass(resetPassRequest, resetPassToken!);
      print("resetPassResponse");
      dismissLoading();
      print(resetPassResponse.message);
      switch (resetPassResponse.success) {
        case true:
          dialogSuccessPassResetBuilder(context!, local!);
          clearInputs();
          break;
        case false:
          showToast(resetPassResponse.message.toString(),
              gravity: Toast.bottom);
          break;
      }
    } catch (error) {
      resetPass();
      //showToast(error.toString(), gravity: Toast.bottom);
    }
  }

  void clearInputs() {
    phoneController.clear();
    passController.clear();
    confirmPassController.clear();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }


}
