import 'forget_pass_controller.dart';
import 'otp_controller.dart';
import 'package:get/get.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../domain/usecases/auth_use_case.dart';
import 'auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthenticationRepositoryIml());
    Get.lazyPut(() => AuthUseCase(Get.find<AuthenticationRepositoryIml>()));
    Get.put(LoginController(Get.find()), permanent: true);
    Get.put(ForgetPassController(Get.find()), permanent: true);
    Get.put(VerificationController(Get.find()), permanent: true);

  }
}
