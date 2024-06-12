import 'package:get/get.dart';

import '../../../data/repositories/splash_repository.dart';
import '../../../domain/usecases/splash_use_case.dart';
import '../network/NetworkBinding.dart';
import 'splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    NetworkBinding().dependencies();
    Get.lazyPut(() => SplashRepositoryIml());
    Get.lazyPut(() => SplashUseCase(Get.find<SplashRepositoryIml>()));
    Get.put(SplashController(Get.find()), permanent: true);
  }
}
