import '../../data/models/my_quizes_results/MyNotPQuizResponse.dart';
import '../../data/models/my_quizes_results/MyQuizesResultsResponse.dart';
import '../../data/models/quiz/quiz_answer/QuizAnswer.dart';
import '../../data/models/quiz/quiz_review/QuizReviewResponse.dart';
import '../../data/models/quiz/start_quiz/StartQuizResponse.dart';
import '../../data/models/quiz/store_quiz_result/StoreQuizResultResponse.dart';

abstract class MyQuizesRepository {
  Future<MyQuizesResultsResponse> getMyQuizesResult();
  Future<MyNotPQuizResponse> getMyNotPQuizes();

  Future<StartQuizResponse> startQuiz(String quizID);

  Future<StoreQuizResultResponse> submitQuizResult(QuizAnswer quizAnswer,String quizID);

  Future<QuizReviewResponse> getQuizResult(String quizID);


}
