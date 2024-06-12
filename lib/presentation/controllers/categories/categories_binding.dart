import '../../../data/repositories/categories_repository.dart';
import 'package:get/get.dart';

import '../../../domain/usecases/categories_use_case.dart';
import 'categories_controller.dart';

class CategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoriesRepositoryIml());
    Get.lazyPut(() => CategoriesUseCase(Get.find<CategoriesRepositoryIml>()));
    Get.put(CategoriesController(Get.find()), permanent: true);
  }
}
