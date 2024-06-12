
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
import '../../../widgets/textInput.dart';

class ResetPassScreen extends GetView<ForgetPassController> {
  late AppLocalizations _local;
  late double _height;
  late double _width;
  final _formKey = GlobalKey<FormState>();
  String? resetPassToken;
  String? phone;

  ResetPassScreen(this.resetPassToken, this.phone) {
    controller.resetPassToken = resetPassToken;
    controller.mobile = phone;
  }

  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    ToastMContext().init(context);
    _local = AppLocalizations.of(context)!;
    controller.local = _local;
    controller.context = context;

    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: buildMainToolBar(controller,
          "",
              () =>
          Get.back()
          ),
      body: Material(
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
                      _local.password_recovery,
                      style: AppTextStyles.authTitleStyle),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                      height: 159,
                      child: SvgPicture.asset(Assets.imagesImageCreateNewPass)),
                  SizedBox(
                    height: _height * 0.04,
                  ),
                  Text(
                      textAlign: TextAlign.start,
                      _local.please_enter_the_new_password,
                      style: AppTextStyles.title2),
                  const SizedBox(
                    height: 24,
                  ),
                  getRowInput(_local.enter_the_password, Assets.assetsImagesPass,
                      controller.passController, (dynamic value) {
                    if (value == null) {
                      return _local.enter_the_password;
                    }
                    return (!value!.isNotEmpty)
                        ? _local.enter_the_password
                        : null;
                  }, isPass: true),
                  SizedBox(height: 25),
                  getRowInput(
                      _local.re_enter_the_password,
                      Assets.assetsImagesPass,
                      controller.confirmPassController, (dynamic value) {
                    if (value == null) {
                      return _local.enter_the_password;
                    }
                    return (!value!.isNotEmpty)
                        ? _local.enter_the_password
                        : null;
                  }, isPass: true),
                  SizedBox(
                    height: _height * 0.03,
                  ),
                  myButton(() {
                    if (_formKey.currentState!.validate()) {
                      controller.resetPass();
                    }
                    // showDialog<void>(context: context, builder: (context) =>(SimpleDialogItem(text: "ddd",color: AppColors.primary,icon: IconData(1),onPressed: ()=>{})));
                  }, _local.password_confirmation),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getRowInput(String hint, String assetPrefex,
      TextEditingController controller, FormFieldValidator? validator,
      {TextInputType textInput = TextInputType.text,
      bool isPass = false,
      bool isEditable = true}) {
    return MyTextFieldForm(
        textEditingController: controller,
        assetNamePrefex: assetPrefex,
        hint: hint,
        textInput: textInput,
        isPass: isPass,
        maxLines: 1,
        isEditable: isEditable,
        validator: validator
        //  )
        //   ],
        );
  }
}
