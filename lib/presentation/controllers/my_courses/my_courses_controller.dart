import 'package:get/get.dart';

import '../../../app/base/base_controller/BaseController.dart';
import '../../../domain/usecases/my_courses_use_case.dart';
import '../../widgets/custom_toast/custom_toast.dart';

class MyCoursesController extends BaseController
    {
      MyCoursesController(this._myCoursesUseCase);

  final MyCoursesUseCase _myCoursesUseCase;

  RxList myCoursesList=[].obs;

  @override
  void onInit() async {
    super.onInit();
    

    getMyCourses();
  }


  getMyCourses() async {
    try {
      isLoading.value=true;
      final _myCoursesResponse =
          await _myCoursesUseCase.getMyCourses();
      isLoading.value=false;
      print("_myCoursesResponse");
      print(_myCoursesResponse.toJson());
      switch ((_myCoursesResponse).success) {
        case true:
          myCoursesList.value=_myCoursesResponse.data?.webinars as List;
          break;
        case false:
          dismissLoading();
          showToast(_myCoursesResponse.message.toString(), gravity: Toast.bottom);
          break;
      }
    } catch (error) {
      print(error);
      getMyCourses();
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
