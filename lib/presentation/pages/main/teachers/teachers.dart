import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../app/config/app_colors.dart';
import '../../../../app/config/app_text_styles.dart';
import '../../../../generated/assets.dart';
import '../../../controllers/teachers/teachers_controller.dart';
import '../../../widgets/custom_toast/custom_toast.dart';
import '../../../widgets/empty_widget/empty_widget.dart';
import '../../../widgets/main_toolbar/main_toolbar.dart';
import '../../../widgets/teacher_item/teacher_item.dart';

class TeachersScreen extends GetView<TeachersController> {
  late AppLocalizations _local;

  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    print("my courses==>");
    ToastMContext().init(context);
    _local = AppLocalizations.of(context)!;
    Future.delayed(Duration.zero,(){
      //your code goes here
      controller.getTeachers();
    });
    return DefaultTabController(
        length: 1,
        child: Scaffold(
          backgroundColor: Colors.white24,
          appBar: buildMainToolBar(controller,
            isMenu: true,
              _local.teachers,()=>{
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
                                /*color: AppColors.primary*/),
                            tabs: [
                              Tab(
                                  child: Container(
                                    width: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                       /* border: Border.all(
                                          *//*  color: AppColors.primary, *//*width: 1)*/),
                                    child: Row(
                                      children: [
                                        Text(_local.teachers,style: AppTextStyles.titleToolbar.copyWith(
                                            color: Colors.black,
                                          fontSize: 16
                                        ),),
                                        SizedBox(width: 10,),
                                    Obx(() =>Text((controller.teachersList.length??"0").toString(),style: AppTextStyles.titleToolbar.copyWith(
                                            color: AppColors.primary,
                                            fontSize: 16
                                        ),))
                                      ],
                                    ),
                                  ))
                            ]))),
              ),
              Expanded(
                child: TabBarView(children: [
                  Obx(() => controller.isLoading.value?Center(child: CircularProgressIndicator()):_buildTabTeachers(controller.teachersList.value,context)),
                  /*Icon(Icons.movie),
                  Icon(Icons.games),*/
                ]),
              ),
            ],
          ),
        ));
  }

  _buildTabTeachers(List<dynamic> teachersList,BuildContext context) {
    return

      teachersList.isEmpty?   buildEmptyWidget(context,SvgPicture.asset(Assets.imagesNoInstructor),
          _local.there_is_no_teacher,
          _local.there_are_no_teachers_yet
      ):  GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 5.0,
        childAspectRatio: 0.9,
        shrinkWrap: true,
        children: List.generate(teachersList.length, (index) {
          return buildTeacherItem(teachersList[index]);
        }
        ));
  }
}

