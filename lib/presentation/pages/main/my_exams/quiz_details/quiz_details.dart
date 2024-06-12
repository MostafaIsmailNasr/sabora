import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../../../../app/config/app_colors.dart';
import '../../../../../app/config/app_text_styles.dart';
import '../../../../../data/models/my_quizes_results/Quiz.dart';
import '../../../../../generated/assets.dart';
import '../../../../controllers/my_quizes/quize_controller.dart';
import '../../../../widgets/button.dart';
import '../../../../widgets/custom_toast/custom_toast.dart';
import '../../../../widgets/main_toolbar/main_toolbar.dart';

class QuizDetailsScreen extends GetView<QuizeController> {
  late AppLocalizations _local;
  late double _height;
  late double _width;
  Quiz quiz;
  final streamDuration = StreamDuration(const Duration(seconds: 60),onDone: ()=>{

    print("done===>")
  });
  QuizDetailsScreen(this.quiz);

  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    ToastMContext().init(context);
    _local = AppLocalizations.of(context)!;
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.height;
    return  WillPopScope(
        onWillPop: () async {
      Navigator.pop(context,true);
      return true;
    },
    child:Scaffold(
      backgroundColor: Colors.white24,
      appBar: buildMainToolBar(controller,_local.exam_details, () => { Navigator.pop(context,true)}),
      body: Column(
        children: [
          Expanded(
            flex: 85,
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      quiz.title ?? "",
                      style: AppTextStyles.titleToolbar.copyWith(fontSize: 16),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        quiz.webinar?.title ?? "",
                        style: AppTextStyles.title2,
                      )), /*Stack(
                    children: [
                      Container(
                        child:      SlideCountdown(
                          // This duration no effect if you customize stream duration
                          duration: const Duration(seconds: 60),
                          streamDuration: streamDuration,
                          countUp: true,
                        ),
                      ),
                    ],
                  ),*/
                  // Lottie.asset(
                  //   Assets.assetsSuccess,
                  //   width: 170,
                  //   height: 170,
                  //   // fit: BoxFit.fill,
                  // ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: SvgPicture.asset(Assets.imagesQuizDetailsImg),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                              width: _width * 0.2,
                              child: Row(
                                children: [
                                  SvgPicture.asset(Assets.imagesFinalgrade),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _local.the_final_grade,
                                          style: AppTextStyles.title2
                                              .copyWith(color: AppColors.gray),
                                        ),
                                        Text(
                                          quiz.totalMark.toString() ?? "",
                                          style: AppTextStyles.title.copyWith(
                                              fontSize: 14,
                                              color: AppColors.graydark),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                          SizedBox(
                            width: _width * 0.2,
                            child: Row(
                              children: [
                                SvgPicture.asset(Assets.imagesPassmark),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _local.the_degree_of_success,
                                        style: AppTextStyles.title2
                                            .copyWith(color: AppColors.gray),
                                      ),
                                      Text(
                                        quiz.passMark.toString() ?? "",
                                        style: AppTextStyles.title.copyWith(
                                            fontSize: 14,
                                            color: AppColors.graydark),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: _width * 0.2,
                            child: Row(
                              children: [
                                SvgPicture.asset(Assets.imagesAttempts),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _local.attempts,
                                        style: AppTextStyles.title2
                                            .copyWith(color: AppColors.gray),
                                      ),
                                      Text(
                                        (quiz.attempt??"1").toString() ?? "",
                                        style: AppTextStyles.title.copyWith(
                                            fontSize: 14,
                                            color: AppColors.graydark),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: _width * 0.2,
                            child: Row(
                              children: [
                                SvgPicture.asset(Assets.imagesQtime),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _local.time,
                                        style: AppTextStyles.title2
                                            .copyWith(color: AppColors.gray),
                                      ),
                                      Text(
                                        quiz.time.toString() ?? "",
                                        style: AppTextStyles.title.copyWith(
                                            fontSize: 14,
                                            color: AppColors.graydark),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 15,
            child: Stack(
              children: [
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ]),
                      child: (quiz?.authCanStart??false)?Padding(
                        padding: EdgeInsets.all(10),
                        child: myButton(() {
                          controller.startQuiz(context,quiz.id.toString());

                        }, _local.start_the_exam),
                      ):Container(),
                    ))
              ],
            ),
          )
        ],
      ),
    ));
  }
}
