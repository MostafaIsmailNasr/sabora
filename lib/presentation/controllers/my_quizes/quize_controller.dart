import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/base/base_controller/BaseController.dart';
import '../../../data/models/my_quizes_results/Answers.dart';
import '../../../data/models/quiz/quiz_answer/AnswerSheet.dart';
import '../../../data/models/quiz/quiz_answer/QuizAnswer.dart';
import '../../../data/models/quiz/start_quiz/StartQData.dart';
import '../../../data/models/quiz/store_quiz_result/Result.dart';
import '../../../domain/usecases/my_quizes_use_case.dart';
import '../../pages/main/my_exams/quiz_questions/quiz_questions.dart';
import '../../pages/main/my_exams/quiz_review/quiz_review.dart';
import '../../pages/main/my_exams/quiz_status/quiz_status.dart';
import '../../widgets/custom_toast/custom_toast.dart';
import 'quize_binding.dart';
import 'quize_review_binding.dart';

enum QuestionType {
  multiple,
  descriptive;
}

class QuizeController extends BaseController with GetTickerProviderStateMixin{
  QuizeController(this._myQuizesUseCase);

  final MyQuizesUseCase _myQuizesUseCase;
  StartQData? quizData;

  //question answer
  var answersList = [].obs;

  TextEditingController quizAnswerTextController = TextEditingController();
  RxString quizAnswerTextAnswer = "".obs;
  late QuizAnswer quizAnswer;
  RxInt currentQuestion = 0.obs;
  RxInt selectedAnswerIndex = (-1).obs;

  Rx<QuizResult>? quizResult=QuizResult().obs;

  late HashMap<String?, AnswerSheet> myAnswers;


  @override
  void onInit() async {
    super.onInit();
    
  }

  initQuizAnswer() {
    myAnswers = HashMap();
    quizAnswer = QuizAnswer();
    quizAnswer.quizResultId = quizData?.quizResultId;
    quizAnswer.answerSheet = [];
    currentQuestion.value = 0;
    quizAnswerTextController.addListener(() {
      quizAnswerTextAnswer.value = quizAnswerTextController.text;
    });
    clearVariables();
  }

  RxList getQuestionsAnswers() {
    answersList.value =
        quizData?.quiz?.questions![currentQuestion.value].answers!.toList()
            as List;
    return answersList;
  }

  addAnswer() {
    print("current question==>${currentQuestion.value}");
    if ((currentQuestion.value + 1) > (quizData?.quiz?.questions?.length??0)) {
      print("questionEnded");
      return;
    }
    var question = quizData?.quiz?.questions![currentQuestion.value];
    AnswerSheet answerSheet = AnswerSheet();
    answerSheet.questionId = question?.id;
    if (question?.type == QuestionType.descriptive.name) {
      answerSheet.answer = quizAnswerTextController.text;
    } else {
      print(question?.type);
      if (selectedAnswerIndex.value != -1) {
        answerSheet.answer =
            question?.answers![selectedAnswerIndex.value].id.toString();
      } else {
        answerSheet.answer = null;
      }
    }

    print("question?.id.toString()");
    print(question?.id.toString());
    myAnswers[question?.id.toString()] = answerSheet;
    print("currentQuestion.value1");
    print(currentQuestion.value);
    if(( currentQuestion.value + 1)<(quizData?.quiz?.questions?.length??0)) {
      currentQuestion.value = currentQuestion.value + 1;
      print("currentQuestion.value2");
      print(currentQuestion.value);
      clearVariables();
      //next question
      var questionNext = quizData?.quiz?.questions![currentQuestion.value];
      if (questionNext?.type == QuestionType.descriptive.name) {
        if (myAnswers.containsKey(questionNext?.id.toString())) {
          // quizAnswerTextController.text =
          //     myAnswers[questionNext?.id.toString()]!.answer ?? "";
          quizAnswerTextAnswer.value =
              myAnswers[questionNext?.id.toString()]!.answer ?? "";
        }
      } else {
        print(questionNext?.type);
        if (myAnswers.containsKey(questionNext?.id.toString())) {
          var answer = myAnswers[questionNext?.id.toString()]!.answer ?? "-1";
          selectedAnswerIndex.value =
              getSelectedAnswerIndex(questionNext!.answers!, answer);
        }
      }
      getQuestionsAnswers();
      answersList.refresh();
      this.answersList.refresh();
      update();
      print("currentQuestion");
      print(currentQuestion.value);
      print(question?.type);
    }
  }

  int getSelectedAnswerIndex(List<Answers> listAnswers, String answer) {
    var selected = -1;
    for (int i = 0; i < listAnswers.length; i++) {
      if (answer == listAnswers[i].id.toString()) {
        selected = i;
        // print(selected);
        break;
      }
    }
    print("==>selected");
    print(selected);
    return selected;
  }

  void previousQuestion() {
    if(currentQuestion.value>0) {
      currentQuestion.value = currentQuestion.value - 1;
    }
    var questionNext = quizData?.quiz?.questions![currentQuestion.value];
    if (questionNext?.type == QuestionType.descriptive.name) {
      if (myAnswers.containsKey(questionNext?.id.toString())) {
        // quizAnswerTextController.text =
        //     myAnswers[questionNext?.id.toString()]!.answer ?? "";
        quizAnswerTextAnswer.value =
            myAnswers[questionNext?.id.toString()]!.answer ?? "";
      }
    } else {
      print(questionNext?.type);
      if (myAnswers.containsKey(questionNext?.id.toString())) {
        var answer = myAnswers[questionNext?.id.toString()]!.answer ?? "-1";
        selectedAnswerIndex.value =
            getSelectedAnswerIndex(questionNext!.answers!, answer);
      }
    }
  }

  void clearVariables() {
    quizAnswerTextController.clear();
    quizAnswerTextAnswer.value = "";

    selectedAnswerIndex.value = -1;
    update();
    print(currentQuestion);
  }


  startQuiz(BuildContext context, String quizID) async {
    try {
      loading();
      final _startQuizResponse = await _myQuizesUseCase.startQuiz(quizID);
      print("_startQuizResponse");
      print(_startQuizResponse.toJson());
      switch ((_startQuizResponse).success) {
        case true:
          WidgetsBinding.instance.addPostFrameCallback((_) {
            dismissLoading();
            QuizeBinding().dependencies();

            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) =>
                    QuizQuestionsScreen(_startQuizResponse.startQData)));

          });

          // Get.off(QuizQuestionsScreen(_startQuizResponse.startQData),
          //     binding: QuizeBinding());
          update();
          break;
        case false:
          dismissLoading();
          showToast(_startQuizResponse.message.toString(),
              gravity: Toast.bottom,isSuccess: false);
          break;
      }
    } catch (error) {
      print(error);
      startQuiz(context, quizID);
     // showToast(error.toString(), gravity: Toast.bottom);
    }
  }

  submitQuizResult(BuildContext context) async {
    try {
      loading();
      quizAnswer.answerSheet = [];
      print("myAnswers.values");
      print(myAnswers.values.length);
      myAnswers.values.forEach((element) {
        quizAnswer.answerSheet?.add(element);
      });
      print(quizAnswer.toJson());
      final _storeQuizResultResponse = await _myQuizesUseCase.submitQuizResult(
          quizAnswer, quizData!.quiz!.id.toString());
      print("_storeQuizResultResponse");
      print(_storeQuizResultResponse.toJson());
      switch ((_storeQuizResultResponse).success) {
        case true:
          dismissLoading();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            QuizeBinding().dependencies();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) =>
                    QuizStatusScreen(
                        _storeQuizResultResponse?.quizResultData?.result!.quiz
                            ?.id.toString())));
          });
          // Get.off(QuizStatusScreen(_storeQuizResultResponse?.quizResultData?.result!));
          break;
        case false:
          dismissLoading();
          showToast(_storeQuizResultResponse.message.toString(),
              gravity: Toast.bottom);
          break;
      }
    } catch (error) {
      print(error);
      submitQuizResult(context);
      //  showToast(error.toString(), gravity: Toast.bottom);
    }
  }

  getQuizResult(BuildContext context, String quizID, int type) async {
    try {
      if (type == 1) loading(); else isLoading.value=true;
      final _quizReviewResponse = await _myQuizesUseCase.getQuizResult(quizID);
      print("_quizReviewResponse");
      print(_quizReviewResponse.toJson());
      switch ((_quizReviewResponse).success) {
        case true:
          dismissLoading();
          quizResult?.value=(_quizReviewResponse.quizResult!);
          if(type==0){

          }else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              QuizeReviewBinding().dependencies();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      QuizReviewScreen(_quizReviewResponse.quizResult)));
            });
          }
          // Get.off(QuizReviewScreen(_quizReviewResponse.quizResult),
          //     binding: QuizeReviewBinding());

          isLoading.value=false;
          update();
          break;
        case false:
          isLoading.value=false;
          dismissLoading();
          showToast(_quizReviewResponse.message.toString(),
              gravity: Toast.bottom,isSuccess: false);
          break;
      }
    } catch (error) {
      print(error);
      getQuizResult(context, quizID,type);
      // showToast(error.toString(), gravity: Toast.bottom);
    }
  }




  @override
  void didChangeDependencies(BuildContext context) {
    super.didChangeDependencies(context);
    print("didChangeDependencies===>");
  }

  @override
  void dispose() {
    //  videoPlayerController.dispose();
    //controllerVideo.dispose();
    quizAnswerTextController.dispose();
    print("dispose");
    super.dispose();
  }
}
