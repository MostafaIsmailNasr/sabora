import 'package:get/get.dart';

import '../../../data/repositories/home_repository.dart';
import '../../../data/repositories/splash_repository.dart';
import '../../../domain/usecases/home_use_case.dart';
import '../../../domain/usecases/splash_use_case.dart';
import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeRepositoryIml());
    Get.lazyPut(() => SplashRepositoryIml());
    Get.lazyPut(() => HomeUseCase(Get.find<HomeRepositoryIml>()));
    Get.lazyPut(() => SplashUseCase(Get.find<SplashRepositoryIml>()));
    Get.put(HomeController(Get.find()));
  }
}
