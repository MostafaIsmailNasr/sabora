import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../../app/config/app_colors.dart';
import '../../../../app/config/app_text_styles.dart';
import '../../../../generated/assets.dart';
import '../../../controllers/auth/otp_controller.dart';
import '../../../widgets/button.dart';
import '../../../widgets/custom_toast/custom_toast.dart';
import '../../../widgets/main_toolbar/main_toolbar.dart';

enum NavigationFrom { login, register, forgetPass }

class OtpScreen extends GetView<VerificationController> {
  late AppLocalizations _local;

  late double _height;
  late double _width;

  String? userID;
  String? fullName;
  String? mobile;
  String? userPass;
  String? resetPassToken;

  OtpScreen(NavigationFrom? from,
      {this.userID, this.mobile, this.fullName, this.resetPassToken,this.userPass}) {
    controller.from = from;
    controller.userPass = userPass;
    controller.userID = userID;
    controller.phoneNumber = mobile;
    controller.fullName = fullName;
    controller.resetPassToken = resetPassToken;
    controller.sendCodeToPhoneNumber();
  }

  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    ToastMContext().init(context);
    controller.mContext=context;
    _local = AppLocalizations.of(context)!;
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.height;
    return
      Scaffold(
          appBar: buildMainToolBar(controller,
              "",
                  () =>
              Get.back()
              ),body:Material(
      child: Container(
        height: _height,
        width: _width,
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: _height * 0.04,
              ),
              Text(
                  textAlign: TextAlign.start,
                  _local.verify_the_mobile_number,
                  style: AppTextStyles.authTitleStyle),
              SizedBox(
                height: 24,
              ),
              Container(
                  height: 159, child: SvgPicture.asset(Assets.imagesOtpImg)),
              SizedBox(
                height: _height * 0.04,
              ),
              Text(
                  textAlign: TextAlign.start,
                  _local.please_enter_the_code,
                  style: AppTextStyles.title2),
              Text(
                  textAlign: TextAlign.center,
                  "${mobile}",
                  style: AppTextStyles.title2
                      .copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(
                height: 24,
              ),
              Center(
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: OTPTextField(
                      length: 6,
                      width: MediaQuery.of(context).size.width,
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldWidth: 45,
                      fieldStyle: FieldStyle.box,
                      outlineBorderRadius: 10,
                      style: TextStyle(fontSize: 17),
                      onChanged: (pin) {
                        controller.codePin = pin;
                        print("Changed: " + pin);
                      },
                      onCompleted: (pin) {
                        controller.codePin = pin;
                        controller.verifyPhoneNumber(context);

                        print("Completed: " + pin);
                      }),
                ),
              ),
              SizedBox(
                height: _height * 0.03,
              ),
              myButton(() {
                if (controller.codePin == null) {
                  controller.showToast(_local.code_invalide,isSuccess: false);
                  return;
                }
                if (controller.codePin!.isEmpty) {
                  controller.showToast(_local.code_invalide,isSuccess: false);
                  return;
                }
                controller.verifyPhoneNumber(context);
              }, _local.account_confirmation),
              const SizedBox(
                height: 15,
              ),
              Container(
                child: Text(
                  _local.please_wait,
                  style: AppTextStyles.title2.copyWith(color: AppColors.gray2),
                  textAlign: TextAlign.center,
                ),
              ),
              Obx(() => Container(
                    child: Text(
                      controller.isTimeEnded.value?
                      _local.didnt_you_receive_the_code:_local.you_will_receive_the_code_within,
                      style:
                          AppTextStyles.title2.copyWith(color: AppColors.gray2),
                      textAlign: TextAlign.center,
                    ),
                  )),
          Obx(() =>Container(
                margin: EdgeInsets.symmetric(horizontal: 2),
                child:
              controller.isTimeEnded.value?TextButton(
                  onPressed: () {
                    if(controller.isTimeEnded.value){
                      controller.resetTime();
                      controller.sendCodeToPhoneNumber();
                    }
                  },
                  child:Text(
                    _local.resend_the_code,
                    style: AppTextStyles.title.copyWith(
                        fontWeight: FontWeight.w700, color: AppColors.primary),
                    textAlign: TextAlign.center,
                  )):  Countdown(
                  controller: controller.controllerTimer,
                  seconds: 60,
                  build: (_, double time) => Text(
                    time.toString(),
                    style: AppTextStyles.title.copyWith(
                        fontWeight: FontWeight.w700, color: AppColors.primary),
                    textAlign: TextAlign.center,
                  ) ,
                  interval: Duration(milliseconds: 100),
                  onFinished: () {
                    controller.isTimeEnded.value=true;
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //     content: Text('Timer is done!'),
                    //   ),
                    // );
                  },
                )

                )),

            ],
          ),
        ),
      ),
    ));
  }
}
