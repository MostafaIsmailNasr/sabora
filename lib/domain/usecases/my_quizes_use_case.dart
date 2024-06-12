import '../../data/models/my_quizes_results/MyNotPQuizResponse.dart';
import '../../data/models/my_quizes_results/MyQuizesResultsResponse.dart';
import '../../data/models/quiz/quiz_answer/QuizAnswer.dart';
import '../../data/models/quiz/quiz_review/QuizReviewResponse.dart';
import '../../data/models/quiz/start_quiz/StartQuizResponse.dart';
import '../../data/models/quiz/store_quiz_result/StoreQuizResultResponse.dart';
import '../repositories/my_quizes_repository.dart';

class MyQuizesUseCase  {
  final MyQuizesRepository _repo;
  MyQuizesUseCase(this._repo);

  Future<MyQuizesResultsResponse> getMyQuizesResult() {
    return _repo.getMyQuizesResult();
  }

  Future<MyNotPQuizResponse> getMyNotPQuizes() {
    return _repo.getMyNotPQuizes();
  }


  Future<StartQuizResponse> startQuiz(String quizID) {
    return _repo.startQuiz(quizID);
  }

  Future<StoreQuizResultResponse>  submitQuizResult(QuizAnswer quizAnswer,String quizID) {
    return _repo.submitQuizResult(quizAnswer,quizID);
  }

  Future<QuizReviewResponse>  getQuizResult(String quizID){
    return _repo.getQuizResult(quizID);
  }


}
