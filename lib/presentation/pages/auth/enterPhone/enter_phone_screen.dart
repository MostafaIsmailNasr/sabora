
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../app/config/app_text_styles.dart';
import '../../../../generated/assets.dart';
import '../../../controllers/auth/forget_pass_controller.dart';
import '../../../widgets/button.dart';
import '../../../widgets/custom_toast/custom_toast.dart';
import '../../../widgets/main_toolbar/main_toolbar.dart';
import '../login/login_screen.dart';

class EnterPhoneScreen extends GetView<ForgetPassController> {
  late AppLocalizations _local;
  final _formKey = GlobalKey<FormState>();
  late double _height;
  late double _width;

  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    ToastMContext().init(context);
    _local = AppLocalizations.of(context)!;
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.height;
    return   Scaffold(
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
          child: Form(
            key: _formKey,
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
                    _local.forgot_your_password,
                    style: AppTextStyles.authTitleStyle),
                SizedBox(
                  height: 24,
                ),
                Container(
                    height: 159,
                    child: SvgPicture.asset(Assets.imagesImageForgetPass)),
                SizedBox(
                  height: _height * 0.04,
                ),
                getRowInput2(
                    _local.enter_the_mobile_number,
                    "01xxxxxxxxx",
                    assetPrefex: Assets.assetsImagesPhone,
                    controller.phoneController, (dynamic value) {
                  if (value == null) {
                    return _local.phone_is_required;
                  }
                  return (!value!.isNotEmpty) ? _local.phone_is_required : null;
                }, textInputType: TextInputType.phone),
                SizedBox(
                  height: _height * 0.03,
                ),
                myButton(() {
                  if (_formKey.currentState!.validate()) {
                    controller.forgetPass();
                  }
                }, _local.verification),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
