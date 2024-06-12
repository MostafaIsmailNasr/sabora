import 'package:get/get.dart';

import '../../../data/repositories/teachers_repository.dart';
import '../../../domain/usecases/teachers_use_case.dart';
import 'teachers_controller.dart';

class TeachersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TeachersRepositoryIml());
    Get.lazyPut(() => TeachersUseCase(Get.find<TeachersRepositoryIml>()));
    Get.put(TeachersController(Get.find()), permanent: true);
  }
}
