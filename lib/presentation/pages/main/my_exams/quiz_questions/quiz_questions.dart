import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../../../../app/config/app_colors.dart';
import '../../../../../app/config/app_text_styles.dart';
import '../../../../../data/models/my_quizes_results/Answers.dart';
import '../../../../../data/models/quiz/start_quiz/StartQData.dart';
import '../../../../../data/models/quiz/store_quiz_result/QuizReview.dart';
import '../../../../../generated/assets.dart';
import '../../../../controllers/my_quizes/quize_controller.dart';
import '../../../../widgets/button.dart';
import '../../../../widgets/custom_toast/custom_toast.dart';
import '../../../../widgets/exit_dialog/exit_dialog.dart';
import '../../../../widgets/textInput.dart';

class QuizQuestionsScreen extends GetView<QuizeController> {
  late AppLocalizations _local;
  late double _height;
  late double _width;
  StartQData? quizData;
  late final StreamDuration streamDuration;
  BuildContext? mContext;

  QuizQuestionsScreen(this.quizData) {
    controller.quizData = quizData;
    controller.initQuizAnswer();
    streamDuration = StreamDuration(
        Duration(seconds: (quizData?.quiz?.time ?? 0) * 60),
        onDone: () =>
            {controller.submitQuizResult(mContext!), print("done===>")});
  }

  // final streamDuration = StreamDuration( Duration(seconds: (quizData?.quiz?.time??0)*60),
  //     onDone: () => {print("done===>")});


  Future<bool> _willPopCallback() async {
    // await showDialog or Show add banners or whatever
    // then
    if (controller.currentQuestion.value > 0) {
      controller.previousQuestion();
      return false;
    } else {
      dialogExitBuilder(
          mContext!, _local, _local.do_you_want_to_finish_the_test, () {
        Get.back();
        controller.submitQuizResult(mContext!);
      });
      return false;
    }
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




    return WillPopScope(
        onWillPop: _willPopCallback,
        child: Scaffold(
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
                  onTap: () => {_willPopCallback()},
                  child: Card(
                    elevation: 0.2,
                    color: Color(0x26FFFFFF),
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Container(
                      child: RotatedBox(
                        quarterTurns: controller.store.lang == "en" ? 0 : 90,
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
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
                                    (quizData?.quiz?.time ?? 0) > 0
                                        ? Center(
                                            child: Directionality(
                                              textDirection: TextDirection.ltr,
                                              child:SlideCountdown(
                                                durationTitle: controller.store.lang=="ar"?DurationTitle.ar():null,
                                                separatorType: SeparatorType.title,
                                                // This duration no effect if you customize stream duration
                                                duration: Duration(
                                                    seconds:
                                                        (quizData?.quiz?.time ??
                                                                0) *
                                                            60),
                                                streamDuration: streamDuration,
                                                countUp: true,
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    /*  Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Text(
                                    "التعليق علي الاختبار",
                                    style: AppTextStyles.title
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 20, right: 20, top: 20),
                                    child: Text(
                                      "قارن اجابتك بالاجابه الصحيحه",
                                      style: AppTextStyles.title2
                                          .copyWith(color: Color(0xffE7E7E7)),
                                    )),*/
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
                                                .copyWith(
                                                    color: Color(0xffE7E7E7)),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 15,
                                                right: 15,
                                                bottom: 10),
                                            child: Obx(() => Text(
                                                  "${controller.currentQuestion.value + 1}/${quizData?.quiz?.questionCount}",
                                                  style: AppTextStyles.title2
                                                      .copyWith(
                                                          color: Color(
                                                              0xffE7E7E7)),
                                                ))),
                                      ],
                                    ),
                                    Container(
                                        child: Obx(() => LinearPercentIndicator(
                                              //width: 100.0,
                                              barRadius: Radius.circular(20),
                                              lineHeight: 8.0,
                                              percent: (((controller
                                                                  .currentQuestion
                                                                  .value +
                                                              1) /
                                                          (quizData?.quiz
                                                                  ?.questionCount ??
                                                              0)))
                                                  .toDouble(),
                                              progressColor: AppColors.yello,
                                              //fillColor: Color(0xff004CBA),
                                              backgroundColor:
                                                  Color(0xff004CBA),
                                            )))
                                  ],
                                ),
                              ),
                            ),

          Obx(() => Padding(
                              padding:
                                  EdgeInsets.only(left: 20, right: 20, top: 15),
                              child: Text(
                                quizData?.quiz?.questions![controller.currentQuestion.value].title ?? "",
                                style:
                                    AppTextStyles.title.copyWith(fontSize: 18),
                              ),
                            )),
                            Obx(() => (quizData
                                        ?.quiz
                                        ?.questions![
                                            controller.currentQuestion.value]
                                        .image??"").toString().isNotEmpty

                                ? Container(
                                    height: 116,
                                    margin: EdgeInsets.all(10),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        child: Image.network(
                                          height: 116,
                                          quizData
                                                  ?.quiz
                                                  ?.questions![controller
                                                      .currentQuestion.value]
                                                  .image
                                                  .toString() ??
                                              "",
                                          fit: BoxFit.fill,
                                          loadingBuilder: (context, child,
                                                  loadingProgress) =>
                                              (loadingProgress == null)
                                                  ? child
                                                  : Padding(
                                                      padding:
                                                          EdgeInsets.all(15),
                                                      child:
                                                          CircularProgressIndicator()),
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Center(
                                                      child: Image(image: AssetImage('assets/images/edu_gate_logo2.png'),)),
                                        )),
                                  )
                                : Container()),
                            //user grade
                            Obx(() => Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Text(
                                    "${quizData?.quiz?.questions![controller.currentQuestion.value].grade} ${_local.grade}",
                                    style: AppTextStyles.title
                                        .copyWith(fontSize: 18),
                                  ),
                                )),
                            Stack(
                              children: [
                                Obx(() => quizData
                                            ?.quiz
                                            ?.questions![controller
                                                .currentQuestion.value]
                                            .type ==
                                        QuestionType.multiple.name
                                    ? buildAnswersList()

                                    : Container()),
                                Obx(() => quizData
                                            ?.quiz
                                            ?.questions![controller
                                                .currentQuestion.value]
                                            .type ==
                                        QuestionType.descriptive.name
                                    ? Obx(() {
                                        controller
                                                .quizAnswerTextController.text =
                                            controller
                                                .quizAnswerTextAnswer.value;

                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 25),
                                          child: MyTextFieldForm(
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
                                if (quizData?.quiz?.questionCount ==
                                    controller.currentQuestion.value + 1) {

                                  // controller.submitQuizResult();
                                  dialogExitBuilder(context, _local,
                                      _local.do_you_want_to_finish_the_test,
                                      () {
                                        controller.addAnswer();
                                    Get.back();
                                    controller.submitQuizResult(mContext!);
                                  });
                                } else {
                                  controller.addAnswer();
                                }
                              },
                                  quizData?.quiz?.questionCount ==
                                          controller.currentQuestion.value + 1
                                      ? _local.exit
                                      : _local.next,
                                  fillColor: AppColors.red,
                                  isFilled: quizData?.quiz?.questionCount ==
                                          controller.currentQuestion.value + 1
                                      ? true
                                      : false),
                            ),
                          ) /*: Container()*/)
                    ]),
                  )
                ],
              )),
        ));
  }

  buildAnswersList() {
    Future.delayed(Duration.zero, () {
      //your code goes here
      controller.getQuestionsAnswers();
    });


    return  ListView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: controller
          .answersList.value.length,
      itemBuilder: (context, position) {
        return buildQuestionAnswer(
            controller.answersList
                .value[position],
                () => {
              controller
                  .selectedAnswerIndex
                  .value = position,
              controller.answersList
                  .refresh()
            },
            controller.selectedAnswerIndex
                .value ==
                position);
      },
    );
  }
}

buildQuestionAnswer(
    Answers? answer, GestureTapCallback callback, bool isSelected,
    {QuizReview? quizReview, String? correctAnswer}) {
  // print("(answer?.id)");
  // print((answer?.id));
  // print("quizReview?.userAnswer?.answer");
  // print(quizReview?.userAnswer?.answer);
  return InkWell(
    onTap: callback,
    child: Card(
      color: isSelected ? AppColors.primary : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      child:

      Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  isSelected
                      ? Icon(
                    Icons.radio_button_on_rounded,
                    color: isSelected ? Colors.white : Colors.black,
                  )
                      : Icon(
                    Icons.radio_button_off_rounded,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
SizedBox(width: 15,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text(
                        answer?.title ?? "",
                        style: AppTextStyles.title
                            .copyWith(color: isSelected ? Colors.white : Colors.black),
                      ),
                      answer?.image!=null?Container(
                        height: 116,
                        margin: EdgeInsets.all(10),
                        child: ClipRRect(
                            borderRadius: BorderRadius.all(
                                Radius.circular(8)),
                            child: Image.network(
                              height: 116,
                              (answer?.image ??
                                  "").toString(),
                              fit: BoxFit.fill,
                              loadingBuilder: (context, child,
                                  loadingProgress) =>
                              (loadingProgress == null)
                                  ? child
                                  : Padding(
                                  padding:
                                  EdgeInsets.all(15),
                                  child:
                                  CircularProgressIndicator()),
                              errorBuilder:
                                  (context, error, stackTrace) =>
                                  Center(
                                      child: Image(image: AssetImage('assets/images/edu_gate_logo2.png')),
                            )),
                      ))
                          : Container()

                    ],),
                  ),
                ],
              ),
            ),
            quizReview != null
                ? SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  quizReview?.userAnswer?.answer == (answer?.id).toString()
                      ? Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text("إجابتك")),
                  )
                      : Container(
                    width: 0,
                    height: 0,
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      (quizReview?.multipleCorrectAnswer?.id ==
                          quizReview?.userAnswer?.answer
                          ? Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.green),
                          child: SvgPicture.asset(Assets.imagesChecked))
                          : ((quizReview?.userAnswer?.answer ==
                          (answer?.id).toString() &&
                          quizReview?.userAnswer?.answer !=
                              quizReview?.multipleCorrectAnswer?.id
                                  .toString())
                          ? Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.red),
                          child: Container(
                              margin: EdgeInsets.all(2),
                              child: SvgPicture.asset(
                                  Assets.imagesCross)))
                          : Container(
                        height: 0,
                        width: 0,
                      ))),
                      quizReview?.multipleCorrectAnswer?.id.toString() ==
                          (answer?.id).toString()
                          ? Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.green),
                          child: Container(
                              margin: EdgeInsets.all(3),
                              child:
                              SvgPicture.asset(Assets.imagesChecked)))
                          : Container(
                        height: 0,
                        width: 0,
                      ),
                    ],
                  ),

                  // SizedBox(height: 5,),
                ],
              ),
            )
                : Container(),
          ],
        ),
      )


    /*  ListTile(
        leading: isSelected
            ? Icon(
                Icons.radio_button_on_rounded,
                color: isSelected ? Colors.white : Colors.black,
              )
            : Icon(
                Icons.radio_button_off_rounded,
                color: isSelected ? Colors.white : Colors.black,
              ),
        title: Column(children: [
          Text(
            answer?.title ?? "",
            style: AppTextStyles.title
                .copyWith(color: isSelected ? Colors.white : Colors.black),
          ),
          answer?.image!=null?Container(
            height: 116,
            margin: EdgeInsets.all(10),
            child: ClipRRect(
                borderRadius: BorderRadius.all(
                    Radius.circular(8)),
                child: Image.network(
                  height: 116,
                  (answer?.image ??
                      "").toString(),
                  fit: BoxFit.fill,
                  loadingBuilder: (context, child,
                      loadingProgress) =>
                  (loadingProgress == null)
                      ? child
                      : Padding(
                      padding:
                      EdgeInsets.all(15),
                      child:
                      CircularProgressIndicator()),
                  errorBuilder:
                      (context, error, stackTrace) =>
                      Center(
                          child: SvgPicture.asset(Assets
                              .assetsImagesEClassesLogoMain)),
                )),
          )
              : Container()

        ],),
        trailing: quizReview != null
            ? SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    quizReview?.userAnswer?.answer == (answer?.id).toString()
                        ? Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Text("إجابتك")),
                          )
                        : Container(
                            width: 0,
                            height: 0,
                          ),
                    SizedBox(
                      height: 1,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        (quizReview?.multipleCorrectAnswer?.id ==
                                quizReview?.userAnswer?.answer
                            ? Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.green),
                                child: SvgPicture.asset(Assets.imagesChecked))
                            : ((quizReview?.userAnswer?.answer ==
                                        (answer?.id).toString() &&
                                    quizReview?.userAnswer?.answer !=
                                        quizReview?.multipleCorrectAnswer?.id
                                            .toString())
                                ? Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.red),
                                    child: Container(
                                        margin: EdgeInsets.all(2),
                                        child: SvgPicture.asset(
                                            Assets.imagesCross)))
                                : Container(
                                    height: 0,
                                    width: 0,
                                  ))),
                        quizReview?.multipleCorrectAnswer?.id.toString() ==
                                (answer?.id).toString()
                            ? Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.green),
                                child: Container(
                                    margin: EdgeInsets.all(3),
                                    child:
                                        SvgPicture.asset(Assets.imagesChecked)))
                            : Container(
                                height: 0,
                                width: 0,
                              ),
                      ],
                    ),

                    // SizedBox(height: 5,),
                  ],
                ),
              )
            : null,
      ),*/
    ),
  );
}
