import 'package:get/get.dart';

import '../../../data/repositories/auth_repository.dart';
import '../../../domain/usecases/auth_use_case.dart';
import 'register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthenticationRepositoryIml());
    Get.lazyPut(() => AuthUseCase(AuthenticationRepositoryIml()));
    Get.put(RegisterController(Get.find()));
  }
}
