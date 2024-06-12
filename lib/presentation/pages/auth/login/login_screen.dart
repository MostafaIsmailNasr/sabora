import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../../app/config/app_colors.dart';
import '../../../../app/config/app_text_styles.dart';
import '../../../../app/services/local_storage.dart';
import '../../../../generated/assets.dart';
import '../../../controllers/auth/auth_controller.dart';
import '../../../controllers/auth/register_binding.dart';
import '../../../widgets/button.dart';
import '../../../widgets/custom_toast/custom_toast.dart';
import '../../../widgets/textInput.dart';
import '../enterPhone/enter_phone_screen.dart';
import '../register/register_screen.dart';

class LoginScreen extends GetView<LoginController> {
  late AppLocalizations _local;

  final _formKey = GlobalKey<FormState>();
  late double _height;
  late double _width;
  FocusNode _focusNode = FocusNode();
  FocusNode _focusNodePass = FocusNode();

  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    ToastMContext().init(context);
    final store = Get.find<LocalStorageService>();
    _local = AppLocalizations.of(context)!;
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.height;
    return GestureDetector(
        onTap: () {
      // Call the unfocus method to remove the focus from any text field
      _focusNode.unfocus();
      _focusNodePass.unfocus();
    },
    child:Material(
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
                  height: _height * 0.1,
                ),
                Text(
                    textAlign: TextAlign.start,
                    _local.log_in_to_your_account,
                    style: AppTextStyles.authTitleStyle),
                SizedBox(
                  height: _height * 0.05,
                ),
                getRowInput(
                    focusNode:_focusNode,
                    _local.enter_the_mobile_number,
                    "01xxxxxxxxx",
                    assetPrefex: Assets.assetsImagesPhone,
                    controller.phoneController, (dynamic value) {
                  if (value == null) {
                    return _local.phone_is_required;
                  }
                  return (!value!.isNotEmpty) ? _local.phone_is_required : null;
                }, textInputType: TextInputType.phone),
                getRowInput(
                    focusNode:_focusNodePass,
                    _local.enter_the_password,
                    "************",
                    assetPrefex: Assets.assetsImagesPass,
                    isPass: true,
                    controller.passController, (dynamic value) {
                  if (value == null) {
                    return _local.password_is_required;
                  }
                  return (!value!.isNotEmpty)
                      ? _local.password_is_required
                      : null;
                }),
                SizedBox(
                  height: _height * 0.04,
                ),
                myButton(() {
                  // Get.to(ParentMainScreen(),binding: HomeBinding());
                  if (_formKey.currentState!.validate()) {
                    controller.hideKeyboard(context);
                    controller.login(context);
                  }
                }, _local.login),
                SizedBox(
                  height: _height * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          _local.dont_have_an_account,
                          style: AppTextStyles.title.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.gray),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        child: TextButton(
                          onPressed: () {
                            Get.to(RegisterScreen(),
                                binding: RegisterBinding(),
                                duration: Duration(seconds: 0,milliseconds:300), //duration of transitions, default 1 sec
                                transition: Transition.rightToLeft);
                          },
                          child: Text(
                            _local.create_a_new_account,
                            style: AppTextStyles.title.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextButton(
                    onPressed: () {
                      Get.to(EnterPhoneScreen(),
                          duration: Duration(seconds: 0,milliseconds:300), //duration of transitions, default 1 sec
                          transition: Transition.rightToLeft);
                    },
                    child: Text(
                      _local.forgot_your_password,
                      style: AppTextStyles.title.copyWith(
                          fontWeight: FontWeight.w600, color: AppColors.gray),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
                ,
                SizedBox(height: 15,),
                (store.settingsConfig?.showSkip??false)?Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextButton(
                    onPressed: () {
                      controller. phoneController.text = "01010000000";
                      controller.passController.text = "123123";
                      controller.hideKeyboard(context);
                      controller.login(context);
                    },
                    child: Text(
                      _local.skipe,
                      style: AppTextStyles.title.copyWith(
                          fontWeight: FontWeight.w600, color: AppColors.gray),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ):Container()
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

Widget getRowInput(String title, String hint, TextEditingController controller,
    FormFieldValidator? validator,
    {bool isPass = false,
      bool isEditable=true,
      FocusNode? focusNode,
    String assetPrefex = "",

    TextInputType textInputType = TextInputType.text}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
          textAlign: TextAlign.start,
          title,
          style: AppTextStyles.title
              .copyWith(fontWeight: FontWeight.w400, color: AppColors.gray)),
      SizedBox(
        height: 5,
      ),
      MyTextFieldForm(
          focusNode: focusNode,
          assetNamePrefex: assetPrefex,
          hint: hint,
          isEditable: isEditable,
          textInput: textInputType,
          maxLines: 1,
          isPass: isPass,
          textEditingController: controller,
          validator: validator)
    ],
  );
}
Widget getRowInput2(String title, String hint, TextEditingController controller,
    FormFieldValidator? validator,
    {bool isPass = false,
      bool isEditable=true,
      FocusNode? focusNode,
      String assetPrefex = "",

      TextInputType textInputType = TextInputType.number}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
          textAlign: TextAlign.start,
          title,
          style: AppTextStyles.title
              .copyWith(fontWeight: FontWeight.w400, color: AppColors.gray)),
      SizedBox(
        height: 5,
      ),
      MyTextFieldForm(
          focusNode: focusNode,
          assetNamePrefex: assetPrefex,
          hint: hint,
          isEditable: isEditable,
          textInput: textInputType,
          maxLines: 1,
          isPass: isPass,
          textEditingController: controller,
          validator: validator)

    ],
  );
}
