import 'package:get/get.dart';

import '../../../data/repositories/my_courses_repository.dart';
import '../../../domain/usecases/my_courses_use_case.dart';
import 'my_courses_controller.dart';

class MyCoursesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyCoursesRepositoryIml());
    Get.lazyPut(() => MyCoursesUseCase(Get.find<MyCoursesRepositoryIml>()));
    Get.put(MyCoursesController(Get.find()), permanent: true);
  }
}
