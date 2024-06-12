import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../app/config/app_colors.dart';
import '../../../../app/config/app_text_styles.dart';
import '../../../../generated/assets.dart';
import '../../../controllers/my_courses/my_courses_controller.dart';
import '../../../widgets/custom_toast/custom_toast.dart';
import '../../../widgets/empty_widget/empty_widget.dart';
import '../../../widgets/main_toolbar/main_toolbar.dart';
import '../../../widgets/sold_course_item/sold_course_item.dart';

class MyCoursesScreen extends GetView<MyCoursesController> {
  late AppLocalizations _local;

  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    print("my courses==>");
    ToastMContext().init(context);
    _local = AppLocalizations.of(context)!;
    controller.getMyCourses();
    return DefaultTabController(
        length: 1,
        child: Scaffold(
          backgroundColor: Colors.white24,
          appBar: buildMainToolBar(controller,
            isMenu: true,
              _local.my_courses,()=>{
            controller.toggleDrawer()
          })
          ,
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10,right: 10,top: 30,bottom: 10),
                child: PreferredSize(
                    preferredSize: Size.fromHeight(130),

                    ///Note: Here I assigned 40 according to me. You can adjust this size acoording to your purpose.
                    child: Align(
                        alignment: controller.store.lang=="ar"?Alignment.centerRight:Alignment.centerLeft,
                        child: TabBar(
                            isScrollable: true,
                            unselectedLabelColor: AppColors.primary,
                            indicatorSize: TabBarIndicatorSize.label,
                            labelPadding: EdgeInsets.symmetric(horizontal: 7),
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppColors.primary),
                            tabs: [
                              Tab(
                                  child: Container(
                                width: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                        color: AppColors.primary, width: 1)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(_local.sold,style: AppTextStyles.title2.copyWith(
                                    color: Colors.white
                                  ),),
                                ),
                              ))
                            ]))),
              ),
              Expanded(
                child: TabBarView(children: [
                  Obx(() => controller.isLoading.value?Center(child: CircularProgressIndicator()):_buildTabSoldCourses(controller.myCoursesList.value,context)),
                  /*Icon(Icons.movie),
                  Icon(Icons.games),*/
                ]),
              ),
            ],
          ),
        ));
  }

  _buildTabSoldCourses(List<dynamic> coursesList,BuildContext context) {
    return coursesList.isEmpty?buildEmptyWidget(context,SvgPicture.asset(Assets.imagesNoCourse),
        _local.there_are_no_tracks,
        _local.start_learning_now_by_signing_up_for_the_tracks
    ):ListView.builder(
     // physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount:coursesList.length,
      itemBuilder: (context, position) {
        return getSoldCourseItem(_local,coursesList[position]);
      },
    );/*SingleChildScrollView(
      child: Column(
        children: [
          getSoldCourseItem(_local),
          getSoldCourseItem(_local),
          getSoldCourseItem(_local),
          getSoldCourseItem(_local),
          getSoldCourseItem(_local)
        ],
      ),
    );*/
  }
}
