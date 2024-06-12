import '../../domain/repositories/my_quizes_repository.dart';
import '../models/my_quizes_results/MyNotPQuizResponse.dart';
import '../models/my_quizes_results/MyQuizesResultsResponse.dart';
import '../models/quiz/quiz_answer/QuizAnswer.dart';
import '../models/quiz/quiz_review/QuizReviewResponse.dart';
import '../models/quiz/start_quiz/StartQuizResponse.dart';
import '../models/quiz/store_quiz_result/StoreQuizResultResponse.dart';
import '../providers/network/apis/course_api.dart';

class MyQuizesRepositoryIml extends MyQuizesRepository {

  @override
  Future<MyQuizesResultsResponse> getMyQuizesResult() async {
    var response = await CourseAPI.getMyQuizesResult().request();
    print(response);
    return MyQuizesResultsResponse.fromJson(response);
  }

  @override
  Future<MyNotPQuizResponse> getMyNotPQuizes() async{
    var response = await CourseAPI.getMyNotPQuizes().request();
    print(response);
    return MyNotPQuizResponse.fromJson(response);
  }

  @override
  Future<StartQuizResponse> startQuiz(String quizID) async{
    var response = await CourseAPI.startQuiz(quizID).request();
    print(response);
    return StartQuizResponse.fromJson(response);
  }

  @override
  Future<StoreQuizResultResponse> submitQuizResult(QuizAnswer quizAnswer,String quizID)async {
    var response = await CourseAPI.submitQuizResult(quizAnswer,quizID).request();
    print(response);
    return StoreQuizResultResponse.fromJson(response);
  }

  @override
  Future<QuizReviewResponse> getQuizResult(String quizID)async {
    var response = await CourseAPI.getQuizResult(quizID).request();
    print(response);
    return QuizReviewResponse.fromJson(response);
  }

}
