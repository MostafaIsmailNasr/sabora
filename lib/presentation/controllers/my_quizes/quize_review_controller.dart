
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/base/base_controller/BaseController.dart';
import '../../../data/models/my_quizes_results/Answers.dart';
import '../../../data/models/quiz/quiz_answer/QuizAnswer.dart';
import '../../../data/models/quiz/store_quiz_result/Result.dart';
import 'quize_controller.dart';



class QuizeReviewController extends BaseController {

  QuizResult? quizResult;

  //question answer
  var answersList = [].obs;

  TextEditingController quizAnswerTextController = TextEditingController();
  RxString quizAnswerTextAnswer = "".obs;
  late QuizAnswer quizAnswer;
  RxInt currentQuestion = 0.obs;
  RxInt selectedAnswerIndex = (-1).obs;

  // late HashMap<String?, AnswerSheet> myAnswers;


  @override
  void onInit() async {
    super.onInit();
    
  }

  initQuizAnswer() {
    clearVariables();
    currentQuestion.value = 0;
    initAnswerData();
  }

  RxList getQuestionsAnswers() {
    answersList.value =
    quizResult?.quizReview![currentQuestion.value].answers!.toList()
            as List;
    return answersList;
  }

  nextQuestion() {
    if (currentQuestion.value + 1 == quizResult?.quiz?.questions?.length) {
      print("questionEnded");
      return;
    }
     currentQuestion.value = currentQuestion.value + 1;
    clearVariables();
    //next question
    initAnswerData();

  }

  void initAnswerData() {
    getQuestionsAnswers();
    var questionNext = quizResult?.quizReview![currentQuestion.value];
    if (questionNext?.type == QuestionType.descriptive.name) {
      quizAnswerTextAnswer.value =
          questionNext?.userAnswer?.answer ?? "";

    } else {
      print(questionNext?.type);
      var answer =   questionNext?.userAnswer!.answer ?? "-1";
      selectedAnswerIndex.value =
          getSelectedAnswerIndex( questionNext!.answers!, answer);

    }
    answersList.refresh();
    this.answersList.refresh();
    update();
    print("currentQuestion");
    print(currentQuestion.value);
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
    currentQuestion.value = currentQuestion.value - 1;
    initAnswerData();
  }

  void clearVariables() {
    quizAnswerTextController.clear();
    quizAnswerTextAnswer.value = "";

    selectedAnswerIndex.value = -1;
    update();
    print(currentQuestion);
  }



}
