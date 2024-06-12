import 'package:get/get.dart';

import '../../../data/repositories/course_details_repository.dart';
import '../../../domain/usecases/course_details_use_case.dart';
import 'favourits_controller.dart';

class FavouritsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CourseDetailsRepositoryIml());
    Get.lazyPut(() => CourseDetailsUseCase(Get.find<CourseDetailsRepositoryIml>()));
    Get.put(FavouritsController(Get.find()), permanent: true);
  }
}
