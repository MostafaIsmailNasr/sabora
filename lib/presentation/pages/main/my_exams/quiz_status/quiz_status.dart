import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../app/config/app_colors.dart';
import '../../../../../app/config/app_text_styles.dart';
import '../../../../../data/models/quiz/store_quiz_result/Result.dart';
import '../../../../../generated/assets.dart';
import '../../../../controllers/home/home_binding.dart';
import '../../../../controllers/my_quizes/quize_controller.dart';
import '../../../../widgets/button.dart';
import '../../../../widgets/custom_toast/custom_toast.dart';
import '../../../../widgets/main_toolbar/main_toolbar.dart';
import '../../../home/parent_main_screen.dart';

class QuizStatusScreen extends GetView<QuizeController> {
  late AppLocalizations _local;
  late double _height;
  late double _width;
  String? quizID;
  QuizStatusScreen(this.quizID/*this.quizResult??*/);

  String getquizResultTitle(QuizResult? quizResult ) {
    if (quizResult?.status == ResultStatus.passed.name) {
      return _local.you_passed_the_quiz;
    } else if (quizResult?.status == ResultStatus.failed.name) {
      return _local.you_failed_the_quiz;
    } else if (quizResult?.status == ResultStatus.waiting.name) {
      return _local.wait_for_final_result;
    }
    return "";
  }

  Color getquizResultStatusColor(QuizResult? quizResult) {
    if (quizResult?.status == ResultStatus.passed.name) {
      return AppColors.green;
    } else if (quizResult?.status == ResultStatus.failed.name) {
      return AppColors.red;
    } else if (quizResult?.status == ResultStatus.waiting.name) {
      return AppColors.yello;
    }
    return AppColors.green;
  }

  String getquizResultDescription(QuizResult? quizResult) {
    if (quizResult?.status == ResultStatus.passed.name) {
      return _local.congratulations_you_passes;
    } else if (quizResult?.status == ResultStatus.failed.name) {
      return _local.sorry_you_failed_the_quiz;
    } else if (quizResult?.status == ResultStatus.waiting.name) {
      return _local.your_quiz_includes_descriptive;
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    ToastMContext().init(context);
    _local = AppLocalizations.of(context)!;
    _height = MediaQuery
        .of(context)
        .size
        .height;
    _width = MediaQuery
        .of(context)
        .size
        .height;
    Future.delayed(Duration.zero,(){
      //your code goes here
      controller.getQuizResult(context, quizID!,0);
    });

    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context,true);
          return true;
    },
    child:Obx(() =>  Scaffold(
      backgroundColor: Colors.white24,
      appBar: buildMainToolBar(controller,_local.result, () => { Navigator.pop(context,true)}),
      body: Container(
        height: _height,
        child:controller.isLoading.value?Center(
          child: CircularProgressIndicator(),
        ) :Column(
          children: [
            SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Center(
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            alignment: Alignment.center,
                            height: 140,
                            width: 140,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(_height)),
                                border: Border.all(
                                    width: 17,
                                    color: getquizResultStatusColor(controller.quizResult?.value))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Center(
                                    child: Text(
                                      (controller.quizResult?.value?.status ==
                                          ResultStatus.waiting.name)
                                          ? _local.waiting
                                          : (controller.quizResult?.value?.userGrade).toString(),
                                      style: AppTextStyles.titleToolbar.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.graydark),
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: 20, right: 20),
                                    child: Center(
                                      child: Text(
                                        _local.your_grade,
                                        style: AppTextStyles.title2
                                            .copyWith(color: AppColors.gray2),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(_height)),
                                    color: getquizResultStatusColor(controller.quizResult?.value)),
                                child: (controller.quizResult?.value?.status ==
                                    ResultStatus.passed.name) ? SvgPicture.asset(
                                    Assets.imagesChecked) : SvgPicture.asset(
                                    Assets.imagesCross),
                              ),
                            ),
                          )
                          //SvgPicture.asset(Assets.imagesQuizDetailsImg),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Center(
                      child: Text(
                        getquizResultTitle(controller.quizResult?.value),
                        style: AppTextStyles.titleToolbar.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.graydark),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Center(
                        child: Text(
                          getquizResultDescription(controller.quizResult?.value),
                          style: AppTextStyles.title2
                              .copyWith(color: AppColors.gray2),
                        ),
                      )),
                  SizedBox(
                    height: 25,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                              width: _width * 0.2,
                              child: Row(
                                children: [
                                  SvgPicture.asset(Assets.imagesFinalgrade),
                                  const SizedBox(
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
                                          (controller.quizResult?.value?.quiz?.totalMark)
                                              .toString(),
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
                                const SizedBox(
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
                                        (controller.quizResult?.value?.quiz?.passMark).toString(),
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
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: _width * 0.2,
                            child: Row(
                              children: [
                                SvgPicture.asset(Assets.imagesUser2),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _local.your_grade,
                                        style: AppTextStyles.title2
                                            .copyWith(color: AppColors.gray),
                                      ),
                                      Text(
                                        (controller.quizResult?.value?.status ==
                                            ResultStatus.waiting.name)
                                            ? "-"
                                            : (controller.quizResult?.value?.userGrade).toString(),
                                        style: AppTextStyles.title.copyWith(
                                            fontSize: 14,
                                            color: getquizResultStatusColor(controller.quizResult?.value)),
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
                                SvgPicture.asset(Assets.imagesResult),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _local.result,
                                        style: AppTextStyles.title2
                                            .copyWith(color: AppColors.gray),
                                      ),
                                      Text(
                                        (controller.quizResult?.value?.status).toString(),
                                        style: AppTextStyles.title.copyWith(
                                            fontSize: 14,
                                            color: getquizResultStatusColor(controller.quizResult?.value)),
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
            Expanded(
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
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: myButton(() {
                                  //Navigator.pop(context,true);
                                  Get.offAll(ParentMainScreen(selectedIndex:3), binding: HomeBinding());
                                },
                                    _local.back_to_the_exams),
                              ),
                            ),
                            (controller.quizResult?.value?.status ==
                                ResultStatus.waiting.name)
                                ? Container()
                                : Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: myButton(() {
                                  if (((controller.quizResult?.value?.status ==
                                      ResultStatus.failed.name) &&
                                      (controller.quizResult?.value?.authCanTryAgain ?? false))) {
                                    controller.startQuiz(context,
                                        (controller.quizResult?.value?.quiz!.id).toString());
                                  } else {
                                    controller.getQuizResult(context,
                                        (controller.quizResult?.value?.quiz!.id).toString(),1);
                                }
                                },
                                    ((controller.quizResult?.value?.status ==
                                        ResultStatus.failed.name) &&
                                        (controller.quizResult?.value?.authCanTryAgain ?? false))
                                        ? _local.retry
                                        : _local.review_answers,
                                    isFilled: false),
                              ),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    )));
  }
}
