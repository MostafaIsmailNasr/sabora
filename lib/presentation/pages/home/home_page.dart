import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/config/app_colors.dart';
import '../../../app/config/app_text_styles.dart';
import '../../../generated/assets.dart';
import '../../controllers/auth/register_binding.dart';
import '../../controllers/home/home_binding.dart';
import '../../controllers/home/home_controller.dart';
import '../../controllers/my_courses/my_courses_binding.dart';
import '../../controllers/my_quizes/my_quizes_binding.dart';
import '../../controllers/support/support_binding.dart';
import '../../controllers/teachers/teachers_binding.dart';
import '../../widgets/custom_toast/custom_toast.dart';
import '../../widgets/my_curved_bottom_navigation.dart';
import '../favourits/favourits_screen.dart';
import '../main/categories/categories_screen.dart';
import '../main/my_comments/my_comments.dart';
import '../main/my_courses/my_courses.dart';
import '../main/my_exams/my_exams.dart';
import '../main/redeem_points/RedeemPointsScreen.dart';
import '../main/settings/settings.dart';
import '../main/support/support.dart';
import '../main/teachers/teachers.dart';
import 'home_screen.dart';

var pages = [
  TeachersScreen(),
  MyCoursesScreen(),
  HomeScreen(),
  MyExamsScreen(),
  SettingsScreen(),
  CategoriesScreen(),
  FavouritsScreen(),
  MyCommentsScreen(),
  SupportScreen(),
  RedeemPointsScreen()
];

class HomePage extends GetView<HomeController> {
  int? selectedIndex=-1;
  HomePage({this.selectedIndex});

  late AppLocalizations _local;

  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    _local = AppLocalizations.of(context)!;
    WidgetsBinding.instance.addPostFrameCallback((_){
    if(selectedIndex!=-1){
      if(selectedIndex==8){
        SupportBinding().dependencies();
        controller.selectedIndex.value = 8;
        selectedIndex=-1;
      }
    }});
    return  WillPopScope(
      onWillPop: () async {
        if (controller.selectedIndex != 2) {
          controller.selectedIndex.value = 2;
          return false;
        } else {
          return true;
        }
      },
      child:Obx(() =>
      Scaffold(
      body: Obx(() => pages[controller.selectedIndex.value]),
      extendBody: true,
      bottomNavigationBar:(controller.selectedIndex.value==0||controller.selectedIndex.value==1
          ||controller.selectedIndex.value==2||controller.selectedIndex.value==3
          ||controller.selectedIndex.value==4)? CurvedNavigationBar(
        //  backgroundColor: Colors.transparent,
        buttonBackgroundColor: AppColors.primary,
        index: 2,
        items: <Widget>[
          Obx(() => Column(mainAxisSize: MainAxisSize.min, children: [
                SvgPicture.asset(
                  Assets.imagesTeachersBar,
                  color: controller.selectedIndex.value == 0
                      ? AppColors.primary
                      : Colors.black,
                ),
                Expanded(
                  child: Text(
                    _local.teachers,
                    style: AppTextStyles.title2.copyWith(
                        color: controller.selectedIndex.value == 0
                            ? AppColors.primary
                            : Colors.black),
                  ),
                )
              ])),
          Obx(() => Column(mainAxisSize: MainAxisSize.min, children: [
                SvgPicture.asset(
                  Assets.imagesCoursesBar,
                  color: controller.selectedIndex.value == 1
                      ? AppColors.primary
                      : Colors.black,
                ),
                Expanded(
                  child: Text(
                    _local.my_courses,
                    style: AppTextStyles.title2.copyWith(
                        color: controller.selectedIndex.value == 1
                            ? AppColors.primary
                            : Colors.black),
                  ),
                )
              ])),
          Container(
              margin: EdgeInsets.all(10),
              child: SvgPicture.asset(
                Assets.imagesHome,
                color: Colors.white,
              )),
          Obx(() => Column(mainAxisSize: MainAxisSize.min, children: [
            controller.selectedIndex.value == 3?SvgPicture.asset(Assets.imagesExamsBarSelected,color: AppColors.primary):
              SvgPicture.asset(Assets.imagesExamsBar),
                Expanded(
                  child: Text(
                    _local.my_exams,
                    style: AppTextStyles.title2.copyWith(
                        color: controller.selectedIndex.value == 3
                            ? AppColors.primary
                            : Colors.black),
                  ),
                )
              ])),
          Obx(() => Column(mainAxisSize: MainAxisSize.min, children: [
                SvgPicture.asset(
                  Assets.imagesSettingBar,
                  color: controller.selectedIndex.value == 4
                      ? AppColors.primary
                      : Colors.black,
                ),
                Expanded(
                  child: Text(
                    _local.settings,
                    style: AppTextStyles.title2.copyWith(
                        color: controller.selectedIndex.value == 4
                            ? AppColors.primary
                            : Colors.black),
                  ),
                )
              ])),
        ],
        onTap: (index) {
          controller.selectedIndex.value = index;
          print(index);
          switch(index){
            case 0:
              TeachersBinding().dependencies();
              break;
            case 1:
              MyCoursesBinding().dependencies();
              break;
            case 2:
              HomeBinding().dependencies();
              break;
            case 3:
              MyQuizesBinding().dependencies();
              break;
            case 4:
              RegisterBinding().dependencies();
              //SettingsBinding().dependencies();
              break;
          }
          //Handle button tap
        },
      ):null,
       ),
    ));
  }
}

// class HomePage2 extends GetView<LoginController> {
//   @override
//   Widget build(BuildContext context) {

//     return CupertinoTabScaffold(
//       tabBar: CupertinoTabBar(
//         items: TabType.values
//             .map((e) => BottomNavigationBarItem(icon: e.icon, label: e.title))
//             .toList(),
//         inactiveColor: AppColors.lightGray,
//         activeColor: AppColors.primary,
//       ),
//       tabBuilder: (context, index) {
//         final type = TabType.values[index];
//         switch (type) {
//           case TabType.headline:
//             HeadlineBinding().dependencies();
//             return HeadlinePage();
//           case TabType.news:
//             NewsBinding().dependencies();
//             return NewsPage();
//           case TabType.profile:
//             return ProfilePage();
//         }
//       },
//     );
//   }
// }
