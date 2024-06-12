import 'package:get/get.dart';

import '../../../data/repositories/my_courses_repository.dart';
import '../../../domain/usecases/my_courses_use_case.dart';
import 'search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyCoursesRepositoryIml());
    Get.lazyPut(() => MyCoursesUseCase(Get.find<MyCoursesRepositoryIml>()));
    Get.put(MySearchController(Get.find()), permanent: true);
  }
}
