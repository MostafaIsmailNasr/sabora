import 'package:get/get.dart';

import '../../../data/repositories/my_quizes_repository.dart';
import '../../../domain/usecases/my_quizes_use_case.dart';
import 'quize_controller.dart';

class QuizeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyQuizesRepositoryIml());
    Get.lazyPut(() => MyQuizesUseCase(Get.find<MyQuizesRepositoryIml>()));
    Get.put(QuizeController(Get.find()), permanent: true);
  }
}
