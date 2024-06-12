import 'package:get/get.dart';

import '../../../app/base/base_controller/BaseController.dart';
import '../../../domain/usecases/categories_use_case.dart';
import '../../widgets/custom_toast/custom_toast.dart';

class CategoriesController extends BaseController {
  CategoriesController(this._categoriesUseCase);

  final CategoriesUseCase _categoriesUseCase;

  RxList categoriesList = [].obs;

  RxBool isFollow = false.obs;

  @override
  void onInit() async {
    super.onInit();
    
  }


  getCategories() async {
    try {
      isLoading.value = true;
      final _categoriesResponse =
      await _categoriesUseCase.getCategories((user?.userGroup?.id).toString());
      print("_categoriesResponse");
      print(_categoriesResponse.toJson());
      switch ((_categoriesResponse).success) {
        case true:
          categoriesList.value = _categoriesResponse.categoriesdata?.categories as List;
          isLoading.value = false;
          break;
        case false:
          dismissLoading();
          showToast(
              _categoriesResponse.message.toString(), gravity: Toast.bottom,isSuccess: false);
          break;
      }
    } catch (error) {
      print(error);
      getCategories();
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
