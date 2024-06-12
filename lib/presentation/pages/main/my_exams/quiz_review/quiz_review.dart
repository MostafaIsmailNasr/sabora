import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../../../../app/config/app_colors.dart';
import '../../../../../app/config/app_text_styles.dart';
import '../../../../../data/models/quiz/store_quiz_result/Result.dart';
import '../../../../../generated/assets.dart';
import '../../../../controllers/my_quizes/quize_controller.dart';
import '../../../../controllers/my_quizes/quize_review_controller.dart';
import '../../../../widgets/button.dart';
import '../../../../widgets/custom_toast/custom_toast.dart';
import '../../../../widgets/exit_dialog/exit_dialog.dart';
import '../../../../widgets/textInput.dart';
import '../quiz_questions/quiz_questions.dart';

class QuizReviewScreen extends GetView<QuizeReviewController> {
  late AppLocalizations _local;
  late double _height;
  late double _width;
  QuizResult? quizData;
  late final StreamDuration streamDuration;
  BuildContext? mContext;

  QuizReviewScreen(this.quizData) {
    controller.quizResult = quizData;
    controller.initQuizAnswer();
  }



  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    mContext = context;
    ToastMContext().init(context);
    // controller.startTimer();

    print("QuizQuestionsScreen ==> build");
    _local = AppLocalizations.of(context)!;
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white24,
      appBar: AppBar(
          elevation: 0,
          leadingWidth: 80,
          backgroundColor: AppColors.primary,
          //  centerTitle: false,
          title: Text(
            quizData?.quiz?.title ?? "",
            style: AppTextStyles.titleToolbar.copyWith(color: Colors.white),
          ),
          leading: GestureDetector(
              onTap: () => {
                Get.back()
              },
              child: Card(
                elevation: 0.2,
                color: Color(0x26FFFFFF),
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child:  Container(
    child: RotatedBox(
    quarterTurns: controller.store.lang == "en" ? 0 : 90,
    child: Icon(
    Icons.arrow_back_ios_new_rounded,
    color: Colors.white,
    ),
    ))
              ))),
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  //height: MediaQuery.of(context).size.height * 0.75,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 30, top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Text(
                                    _local.comment_on_the_exam,
                                    style: AppTextStyles.title
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 20, right: 20, top: 20),
                                    child: Text(
                                      _local.compare_your_answer_with_the_correct_answer,
                                      style: AppTextStyles.title2
                                          .copyWith(color: Color(0xffE7E7E7)),
                                    )),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 15, right: 15, bottom: 10),
                                      child: Text(
                                        _local.question,
                                        style: AppTextStyles.title2
                                            .copyWith(color: Color(0xffE7E7E7)),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15, bottom: 10),
                                        child: Obx(() => Text(
                                              "${controller.currentQuestion.value + 1}/${quizData?.quizReview?.length}",
                                              style: AppTextStyles.title2
                                                  .copyWith(
                                                      color: Color(0xffE7E7E7)),
                                            ))),
                                  ],
                                ),
                                Container(
                                    child: Obx(() => LinearPercentIndicator(
                                          //width: 100.0,
                                          barRadius: Radius.circular(20),
                                          lineHeight: 8.0,
                                          percent: (((controller.currentQuestion
                                                              .value+1) /
                                                      ((quizData?.quizReview
                                                              ?.length ??
                                                          0))) )
                                              .toDouble(),
                                          progressColor: AppColors.yello,
                                          //fillColor: Color(0xff004CBA),
                                          backgroundColor: Color(0xff004CBA),
                                        )))
                              ],
                            ),
                          ),
                        ),

                        Obx(() => Padding(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 15),
                          child: Text(
                            quizData?.quizReview![controller.currentQuestion.value].title ?? "",
                            style: AppTextStyles.title.copyWith(fontSize: 18),
                          ),
                        )),
                        Obx(() => (quizData
                            ?.quizReview![
                        controller.currentQuestion.value]
                            .image??"").toString().isNotEmpty
                            ? Container(
                                height: 116,
                                margin: EdgeInsets.all(10),
                                child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    child: Image.network(
                                      height: 116,
                                      quizData
                                              ?.quizReview![controller
                                                  .currentQuestion.value]
                                              .image
                                              .toString() ??
                                          "",
                                      fit: BoxFit.fill,
                                      loadingBuilder: (context, child,
                                              loadingProgress) =>
                                          (loadingProgress == null)
                                              ? child
                                              : const Padding(
                                                  padding: EdgeInsets.all(15),
                                                  child:
                                                      CircularProgressIndicator()),
                                      errorBuilder: (context, error,
                                              stackTrace) =>
                                          Center(
                                              child: SvgPicture.asset(
                                                  Assets.assetsImagesEClassesLogoMain)),
                                    )),
                              )
                            : Container()),
                        //user grade
                        Obx(() => Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Text(
                                "${quizData?.quizReview![controller.currentQuestion.value].grade} ${_local.grade}",
                                style:
                                    AppTextStyles.title.copyWith(fontSize: 18),
                              ),
                            )),
                        Stack(
                          children: [
                            Obx(() => quizData
                                        ?.quizReview![
                                            controller.currentQuestion.value]
                                        .type ==
                                    QuestionType.multiple.name
                                ? getAnswersList()
                                : Container()),
                            Obx(() => quizData
                                        ?.quizReview![
                                            controller.currentQuestion.value]
                                        .type ==
                                    QuestionType.descriptive.name
                                ? Obx(() {
                                    controller.quizAnswerTextController.text =
                                        controller.quizAnswerTextAnswer.value;

                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 25),
                                      child: MyTextFieldForm(
                                          isEditable: false,
                                          fillColor: AppColors.gray4,
                                          minLines: 2,
                                          maxLines: 5,
                                          hint: _local.your_answer,
                                          textEditingController: controller
                                              .quizAnswerTextController),
                                    );
                                  })
                                : Container()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),


              ),
              Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ]),
                child: Row(children: [
                  Obx(() => controller.currentQuestion.value > 0
                      ? Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: myButton(() {
                              controller.previousQuestion();
                            }, _local.previous, isFilled: false),
                          ),
                        )
                      : Container()),
                  Obx(() => /* quizData?.quiz?.questionCount ==
                  controller.currentQuestion.value + 1
              ? */
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: myButton(() {
                            if (quizData?.quizReview?.length ==
                                controller.currentQuestion.value + 1) {
                              // controller.submitQuizResult();
                              dialogExitBuilder(context, _local,
                                  _local.do_you_want_to_finish_the_test, () {
                                Get.back();
                                Get.back();
                              });
                            } else {
                              controller.nextQuestion();
                            }
                          },
                              quizData?.quizReview?.length ==
                                      controller.currentQuestion.value + 1
                                  ? _local.exit
                                  : _local.next,
                              fillColor: AppColors.red,
                              isFilled: quizData?.quizReview?.length ==
                                      controller.currentQuestion.value + 1
                                  ? true
                                  : false),
                        ),
                      ) /*: Container()*/)
                ]),
              )
            ],
          )),
    );
  }

  getAnswersList() {
    controller.getQuestionsAnswers();
    return ListView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount:
      controller.answersList.value.length,
      itemBuilder: (context, position) {
        return buildQuestionAnswer(
            controller
                .answersList.value[position],
                () => {},
            controller.selectedAnswerIndex
                .value ==
                position,
            quizReview: quizData?.quizReview![
            controller
                .currentQuestion.value]);
      },
    );
  }

}
