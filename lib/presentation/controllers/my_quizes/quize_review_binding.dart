import 'package:get/get.dart';

import 'quize_review_controller.dart';

class QuizeReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>QuizeReviewController());
  }
}
