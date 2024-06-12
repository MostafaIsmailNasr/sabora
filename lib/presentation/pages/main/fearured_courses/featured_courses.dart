import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../controllers/home/home_controller.dart';
import '../../../widgets/custom_toast/custom_toast.dart';
import '../../../widgets/main_toolbar/main_toolbar.dart';
import '../../../widgets/sold_course_item/sold_course_item.dart';

class FeaturedCoursesScreen extends GetView<HomeController> {
  late AppLocalizations _local;
  late double _height;
  late double _width;

  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
// RegisterBinding().dependencies();
    _local = AppLocalizations.of(context)!;
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.height;

    Future.delayed(Duration.zero, () {
      //your code goes here
      ToastMContext().init(context);
      controller.getFeaturedCourses(controller.store.user?.userGroup?.id.toString(),
          controller.store.user?.organization?.organId.toString());
    });

    return Scaffold(
      backgroundColor: Colors.white24,
      appBar: buildMainToolBar(controller,
          _local.featured_courses,
          () => Get.back()),
      body:Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : _buildLatestsCoursesList(controller.featuredCourses.value)),
    );
  }
  _buildLatestsCoursesList(List<dynamic> courses){
    return ListView.builder(
      //  physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: courses.length,
      itemBuilder: (context, position) {
        return getSoldCourseItem(_local,courses[position],isSolid: false);
      },
    );
  }

}
