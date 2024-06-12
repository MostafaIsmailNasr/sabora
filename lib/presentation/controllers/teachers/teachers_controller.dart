import 'package:get/get.dart';

import '../../../app/base/base_controller/BaseController.dart';
import '../../../data/models/teachers/Teachers.dart';
import '../../../domain/usecases/teachers_use_case.dart';
import '../../widgets/custom_toast/custom_toast.dart';

class TeachersController extends BaseController
    {
      TeachersController(this._teachersUseCase);

  final TeachersUseCase _teachersUseCase;

  RxList teachersList=[].obs;
  Rx<Teachers?> teachers=Teachers().obs;

  RxBool isFollow=false.obs;
  @override
  void onInit() async {
    super.onInit();
    
    getTeachers();
  }


  getTeachers() async {
    try {
      isLoading.value=true;
      final _teachersResponse =
          await _teachersUseCase.getTeachers((user?.userGroup?.id).toString());
      print("_teachersResponse");
      print(_teachersResponse.toJson());
      switch ((_teachersResponse).success) {
        case true:
          teachersList.value=_teachersResponse.teachersdata?.teachers as List;
          isLoading.value=false;
          break;
        case false:
          dismissLoading();
          showToast(_teachersResponse.message.toString(), gravity: Toast.bottom);
          break;
      }
    } catch (error) {
      print(error);
      getTeachers();
      // showToast(error.toString(), gravity: Toast.bottom);
    }
  }

      getTeacherDetails(String teacherID) async {
        try {
          isLoading.value=true;
          final _teachersDetailsResponse =
          await _teachersUseCase.getTeacherDetails(teacherID,(user?.userGroup?.id).toString(),user?.organization?.organId.toString());
          print("_teachersDetailsResponse");
          print(_teachersDetailsResponse.toJson());
          switch ((_teachersDetailsResponse).success) {
            case true:
              teachers.value=_teachersDetailsResponse.teacherDetailsdata?.teachers;

              isFollow.value=teachers?.value?.authUserIsFollower??false;
              update();
              isLoading.value=false;
              break;
            case false:
              dismissLoading();
              showToast(_teachersDetailsResponse.message.toString(), gravity: Toast.bottom);
              break;
          }
        } catch (error) {
          print(error);
          getTeacherDetails(teacherID);
          //showToast(error.toString(), gravity: Toast.bottom);
        }
      }

      followTeacher(String teacherID, bool status) async {
        try {
          final _followResponse =
          await _teachersUseCase.followTeacher(teacherID,status?1:0);
          print("_followResponse");
          print(_followResponse.toJson());
          switch ((_followResponse).success) {
            case true:

              update();
              break;
            case false:
              isFollow.value=!isFollow.value;
              showToast(_followResponse.message.toString(), gravity: Toast.bottom);
              break;
          }
        } catch (error) {
          print(error);
          followTeacher(teacherID, status);
          //showToast(error.toString(), gravity: Toast.bottom);
        }
      }



}
