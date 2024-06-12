import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../../app/config/app_colors.dart';
import '../../../../app/config/app_text_styles.dart';
import '../../../controllers/my_quizes/my_quizes_controller.dart';
import '../../../widgets/custom_toast/custom_toast.dart';
import '../../../widgets/main_toolbar/main_toolbar.dart';
import 'my_results/my_result.dart';
import 'not_subscriped/not_subscriped.dart';

class MyExamsScreen extends GetView<MyQuizesController> {
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
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white24,
          appBar: buildMainToolBar(controller,
              _local.the_exams,
              () =>
                  controller.toggleDrawer(),isMenu: true)
          ,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTabBar(),
              const SizedBox(height: 12,),
              Expanded(
                child: TabBarView(children: [
// _buildTabSoldCourses(),
                  MyResultsScreen(),
                  NotSubscripedQuizesScreen(),
                ]),
              ),
            ],
          ),
        ));
  }

  _buildTabBar() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 10),
      child: PreferredSize(
          preferredSize: Size.fromHeight(130),

          ///Note: Here I assigned 40 according to me. You can adjust this size acoording to your purpose.
          child: Container(
//    color: Colors.white,
            child: Align(
                alignment: controller.store.lang=="ar"?Alignment.centerRight:Alignment.centerLeft,
                child: Stack(
                  children: [
                    TabBar(
                        isScrollable: true,
                        indicatorColor: Colors.black,
                        unselectedLabelColor: AppColors.gray,
                        labelStyle: AppTextStyles.title2,
                        indicatorSize: TabBarIndicatorSize.label,
                        labelPadding: EdgeInsets.symmetric(horizontal: 7),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.primary,
                        ),
                        tabs: [
                          Tab(
                              child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.white, width: 1)),
                          )),
                          Tab(
                              child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.white, width: 1)),
                          )),
                        ]),
                    TabBar(
                        isScrollable: true,
                        indicatorColor: Colors.white,
                        unselectedLabelColor: AppColors.gray,
                        labelStyle: AppTextStyles.title2,
                        indicatorSize: TabBarIndicatorSize.label,
                        labelPadding: EdgeInsets.symmetric(horizontal: 7),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.primary,
                        ),
                        tabs: [
                          Tab(
                              child: Container(
                            width: 120,
/* decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16),
                                          */ /*border: Border.all(
                                              color: Colors.white, width: 1)*/ /*),*/

                            child: Align(
                              alignment: Alignment.center,
                              child: Text(_local.my_results),
                            ),
                          )),
                          Tab(
                              child: Container(
                            width: 120,
/* decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(16),
                                              border: Border.all(
                                                  color: AppColors.primary, width: 1)),*/
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(_local.not_subscribed),
                            ),
                          )),
                        ])
                  ],
                )),
          )),
    );
  }
}
