import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/base/base_controller/BaseController.dart';
import '../../../domain/usecases/my_courses_use_case.dart';
import '../../widgets/custom_toast/custom_toast.dart';

class MySearchController extends BaseController {
  MySearchController(this._myCoursesUseCase);

  final MyCoursesUseCase _myCoursesUseCase;

  late TextEditingController searcTextController;

  RxList mySuggestedCoursesList = [].obs;

  RxList searchCoursesList = [].obs;

  RxList searchTeachersList = [].obs;

  RxBool isFirstShow = true.obs;
  @override
  void onInit() async {
    super.onInit();
    isFirstShow.value = true;
    mySuggestedCoursesList.value = [];
    searchCoursesList.value = [];
    searchTeachersList.value = [];
    searcTextController = TextEditingController();
    searcTextController.addListener(() {});
    
    getSuggestedCourses();
  }

  getSuggestedCourses() async {
    searcTextController.clear();
    try {
      RxStatus.loading();
      isLoading.value = true;
      final _suggestedCoursesResponse =
          await _myCoursesUseCase.getSuggestedCourses(
              (user?.organization?.organId).toString(),
              (user?.userGroup?.id).toString());
      isLoading.value = false;
      print("_suggestedCoursesResponse");
      print(_suggestedCoursesResponse.toJson());
      switch ((_suggestedCoursesResponse).success) {
        case true:
          mySuggestedCoursesList.value = _suggestedCoursesResponse.data as List;
          break;
        case false:
          dismissLoading();
          showToast(_suggestedCoursesResponse.message.toString(),
              gravity: Toast.bottom);
          break;
      }
    } catch (error) {
      print(error);
      getSuggestedCourses();
      // showToast(error.toString(), gravity: Toast.bottom);
    }
  }

  search() async {
    try {
      isFirstShow.value = false;
      isLoading.value = true;
      final _searchResponse = await _myCoursesUseCase.search(
          searcTextController.text, (user?.organization?.organId).toString(),(user?.userGroup?.id).toString());
      isLoading.value = false;
      print("_searchResponse");
      print(_searchResponse.toJson());
      switch ((_searchResponse).success) {
        case true:
          searchCoursesList.value =
              _searchResponse.searchdata?.webinars?.webinars as List;
          searchTeachersList.value =
              _searchResponse.searchdata?.teachers?.teachers as List;
          break;
        case false:
          dismissLoading();
          showToast(_searchResponse.message.toString(), gravity: Toast.bottom);
          break;
      }
    } catch (error) {
      print(error);
      search();
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
