import 'package:get/get.dart';

import '../../../data/repositories/course_details_repository.dart';
import '../../../domain/usecases/course_details_use_case.dart';
import 'course_details_controller.dart';

class CourseDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CourseDetailsRepositoryIml());
    Get.lazyPut(() => CourseDetailsUseCase(Get.find<CourseDetailsRepositoryIml>()));
    Get.put(CourseDetailsController(Get.find()));
  }
}
