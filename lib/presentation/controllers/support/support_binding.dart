import 'package:get/get.dart';

import '../../../data/repositories/support_repository.dart';
import '../../../domain/usecases/support_use_case.dart';
import 'support_controller.dart';

class SupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SupportRepositoryIml());
    Get.lazyPut(() => SupportUseCase(Get.find<SupportRepositoryIml>()));
    Get.put(SupportController(Get.find()), permanent: true);
  }
}
