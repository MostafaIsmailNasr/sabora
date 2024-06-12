import '../../../app/config/app_colors.dart';
import '../../../app/config/app_text_styles.dart';
import '../../../generated/assets.dart';
import '../../controllers/auth/register_binding.dart';
import '../auth/enterPhone/enter_phone_screen.dart';
import '../auth/login/login_screen.dart';
import '../auth/register/register_screen.dart';
import '../../widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../widgets/custom_toast/custom_toast.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late AppLocalizations _local;

  @override
  void didChangeDependencies() {
    _local = AppLocalizations.of(context)!;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);

    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                    height: 300,
                    child: Image(image: AssetImage('assets/images/edu_gate_logo2.png'),)
                ),
                Text(_local.welcomeInEclass,
                    style: AppTextStyles.splashTextStyle
                        .copyWith(color: Colors.black, fontSize: 24)),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    _local.startLearningWithTheFirstEducational,
                    style: AppTextStyles.title.copyWith(
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(125, 125, 125, 1)),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: myButton(() {
                        Get.to(LoginScreen(),
                            duration: const Duration(
                                seconds: 0,
                                milliseconds:
                                    300), //duration of transitions, default 1 sec
                            transition:
                                Transition.downToUp); //transition effect);
                      }, _local.login)),
                      Expanded(
                          child: myButton(() {
                        Get.to(RegisterScreen(),
                            binding: RegisterBinding(),
                            duration: const Duration(
                                seconds: 0,
                                milliseconds:
                                    300), //duration of transitions, default 1 sec
                            transition: Transition.rightToLeft);
                      }, _local.create_a_new_account, isFilled: false))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 56,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextButton(
                    onPressed: () {
                      Get.to(EnterPhoneScreen(),
                          duration: const Duration(
                              seconds: 0,
                              milliseconds:
                                  300), //duration of transitions, default 1 sec
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
