import 'package:get/get.dart';

import '../../../app/base/base_controller/BaseController.dart';
import '../../../domain/usecases/my_quizes_use_case.dart';
import '../../widgets/custom_toast/custom_toast.dart';

class MyQuizesController extends BaseController {
  MyQuizesController(this._myQuizesUseCase);

  final MyQuizesUseCase _myQuizesUseCase;

  RxList myQuizesResultsList = [].obs;
  RxList myNotPQuizesList = [].obs;

  @override
  void onInit() async {
    super.onInit();
    

    //getMyQuizesResult();
    //getMyNotPQuizes();
  }

  getMyQuizesResult() async {
    try {
      isLoading.value=true;
      final _myQuizesResponse = await _myQuizesUseCase.getMyQuizesResult();
      print("_myCoursesResponse");

      isLoading.value=false;
      print(_myQuizesResponse.toJson());
      switch ((_myQuizesResponse).success) {
        case true:
          myQuizesResultsList.value = _myQuizesResponse.data?.results as List;
          myQuizesResultsList.refresh();
          update();
          break;
        case false:
          dismissLoading();
          showToast(_myQuizesResponse.message.toString(),
              gravity: Toast.bottom,isSuccess: false);
          break;
      }
    } catch (error) {
      print(error);
      getMyQuizesResult();
      //showToast(error.toString(), gravity: Toast.bottom);
    }
  }

  getMyNotPQuizes() async {
    try {
      isLoading.value=true;
      final _myQuizesResponse = await _myQuizesUseCase.getMyNotPQuizes();
      print("_myCoursesResponse");
      isLoading.value=false;
      print(_myQuizesResponse.toJson());
      switch ((_myQuizesResponse).success) {
        case true:
          myNotPQuizesList.value = _myQuizesResponse.data?.quizzes as List;
          update();
          break;
        case false:
          dismissLoading();
          showToast(_myQuizesResponse.message.toString(),
              gravity: Toast.bottom,isSuccess: false);
          break;
      }
    } catch (error) {
      print(error);
      getMyNotPQuizes();
      //showToast(error.toString(), gravity: Toast.bottom);
    }
  }




  @override
  void dispose() {
    //  videoPlayerController.dispose();
    //controllerVideo.dispose();
    print("dispose");
    super.dispose();
  }
}
