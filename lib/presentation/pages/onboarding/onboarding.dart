import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../app/config/app_colors.dart';
import '../../../app/config/app_text_styles.dart';
import '../../../app/util/constant_utils.dart';
import '../../../generated/assets.dart';
import '../../controllers/auth/auth_binding.dart';
import '../../widgets/Onboarding/OnboardingState.dart';
import '../../widgets/custom_toast/custom_toast.dart';
import '../welcome/welcome_screen.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late Material materialButton;
  late int index;
  final onboardingPagesList = [
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.pagbackground,
          border: Border.all(
            width: 0.0,
            color: AppColors.pagbackground,
          ),
        ),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100,),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 45.0,
                  vertical: 90.0,
                ),
                child: Lottie.asset(
                  Assets.assetsOnboarding1,
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              ),
               Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Start learning now!',
                    style: AppTextStyles.title,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
               Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Interested in to learn from the best teachers around the world?',
                    style: AppTextStyles.body,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    ),
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.pagbackground,
          border: Border.all(
            width: 0.0,
            color: AppColors.pagbackground,
          ),
        ),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100,),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 45.0,
                  vertical: 90.0,
                ),
                child: Lottie.asset(
                  Assets.assetsOnboarding2,
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              ),
               Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Book a meeting…',
                    style: AppTextStyles.title,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
               Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Looking for a private teacher? Book a private meeting now!',
                    style: AppTextStyles.body,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.pagbackground,
          border: Border.all(
            width: 0.0,
            color:AppColors.pagbackground,
          ),
        ),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100,),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 45.0,
                  vertical: 90.0,
                ),
                child: Lottie.asset(
                  Assets.assetsOnboarding3,
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              ),
               Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Teach your skills!',
                    style: AppTextStyles.title,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
               Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Start teaching right now and share your valuable knowledge.',
                    style: AppTextStyles.body,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    materialButton = _skipButton();
    index = 0;
  }

  Material _skipButton({void Function(int)? setIndex}) {
    return Material(
        borderRadius: defaultSkipButtonBorderRadius,
        child:Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Material(
          borderRadius: defaultSkipButtonBorderRadius,
          //color: defaultSkipButtonColor,
          child: InkWell(
            borderRadius: defaultSkipButtonBorderRadius,
            onTap: () {
              if (setIndex != null) {
                index = 2;
                setIndex(2);
              }
            },
            child:  Padding(
              padding: defaultSkipButtonPadding,
              child: Text(
                'Skip',
                style: defaultSkipButtonTextStyle.copyWith(
                  color: defaultSkipButtonColor
                ),
              ),
            ),
          ),
        ),
        Material(
          borderRadius: defaultSkipButtonBorderRadius,
        //  color: defaultSkipButtonColor,
          child: InkWell(
            borderRadius: defaultSkipButtonBorderRadius,
            onTap: () {
              if (setIndex != null) {
                index ++;
                setIndex(index);
              }
            },
            child:  Padding(
              padding: defaultSkipButtonPadding,
              child: Text(
                'Next',
                style: defaultSkipButtonTextStyle.copyWith(
                    color: defaultSkipButtonColor
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Material get _signupButton {
    return Material(
        borderRadius: defaultProceedButtonBorderRadius,
        child:  Center(
          child: Material(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      color: AppColors.primary,
      child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          onTap: () {
            goToWelcomeScreen();
          },
          child:  Padding(
            padding: EdgeInsetsDirectional.fromSTEB(80, 10, 80, 10),
            child: Text(
              'البدء',
              style: AppTextStyles.body.copyWith(
                color: Colors.white
              ),
            ),
          ),
      ),
    ),
        ));
  }

  void goToWelcomeScreen() {
    Future.delayed(const Duration(milliseconds: 4000), () {
      Get.off(const WelcomeScreen(), binding: AuthBinding());
    });
  }


  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: Onboarding(
          pages: onboardingPagesList,
          onPageChange: (int pageIndex) {
            index = pageIndex;
          },
          startPageIndex: 0,
          footerBuilder: (context, dragDistance, pagesLength, setIndex) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.pagbackground,
                border: Border.all(
                  width: 0.0,
                  color: AppColors.pagbackground,
                ),
              ),
              child: ColoredBox(
                color: AppColors.pagbackground,
                child: Padding(
                  padding: const EdgeInsets.all(45.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // CustomIndicator(
                      //   netDragPercent: dragDistance,
                      //   pagesLength: pagesLength,
                      //   indicator: Indicator(
                      //     indicatorDesign: IndicatorDesign.line(
                      //       lineDesign: LineDesign(
                      //         lineType: DesignType.line_uniform,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      index == pagesLength - 1
                          ? Expanded(child:_signupButton)
                          :Expanded(child:  _skipButton(setIndex: setIndex))
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


