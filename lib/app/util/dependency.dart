import 'package:get/get.dart';

import '../../data/repositories/article_repository.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/home_repository.dart';
import '../../data/repositories/splash_repository.dart';

class DependencyCreator {
  static init() {
    //BaseController
    Get.lazyPut(() => SplashRepositoryIml());
    Get.lazyPut(() => AuthenticationRepositoryIml());
    Get.lazyPut(() => HomeRepositoryIml());
    Get.lazyPut(() => ArticleRepositoryIml());

  }
}
