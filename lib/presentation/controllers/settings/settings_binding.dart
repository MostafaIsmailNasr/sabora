import 'package:get/get.dart';

import '../../../data/repositories/settings_repository.dart';
import '../../../domain/usecases/settings_use_case.dart';
import 'settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsRepositoryIml());
    Get.lazyPut(() => SettingsUseCase(Get.find<SettingsRepositoryIml>()));
    Get.put(SettingsController(Get.find()), permanent: true);
  }
}
