import 'package:get/get.dart';

import '../../../app/base/base_controller/BaseController.dart';
import '../../../domain/usecases/course_details_use_case.dart';
import '../../widgets/custom_toast/custom_toast.dart';

class FavouritsController extends BaseController {
  FavouritsController(this._courseDetailsUseCase);

  final CourseDetailsUseCase _courseDetailsUseCase;


  RxList favouritsList = [].obs;

  RxBool isFollow = false.obs;

  @override
  void onInit() async {
    super.onInit();
    

  }


  getFavourits() async {
    try {
      isLoading.value = true;
      final _favoritsResponse =
      await _courseDetailsUseCase.getFavourits((user?.organization?.organId).toString());
      print("_categoriesResponse");
      print(_favoritsResponse.toJson());
      switch ((_favoritsResponse).success) {
        case true:
          favouritsList.value = _favoritsResponse.favoritesdata?.favorites as List;
          isLoading.value = false;
          break;
        case false:
          dismissLoading();
          showToast(
              _favoritsResponse.message.toString(), gravity: Toast.bottom,isSuccess: false);
          break;
      }
    } catch (error) {
      print(error);
      getFavourits();
      //showToast(error.toString(), gravity: Toast.bottom);
    }
  }



  // @override
  // toggleDrawer() {
  //   print("Toggle drawer");
  //   BaseController.drawerController.toggle?.call();
  //   update();
  // }
}
