import 'package:Sabora/app/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/config/app_text_styles.dart';
import '../../../app/services/local_storage.dart';
import '../../../generated/assets.dart';
import '../../../main.dart';
import '../../controllers/auth/register_binding.dart';
import '../../controllers/categories/categories_binding.dart';
import '../../controllers/favourits/favourits_binding.dart';
import '../../controllers/home/home_binding.dart';
import '../../controllers/home/home_controller.dart';
import '../../controllers/my_Comments/my_comments_binding.dart';
import '../../controllers/my_courses/my_courses_binding.dart';
import '../../controllers/my_quizes/my_quizes_binding.dart';
import '../../controllers/support/support_binding.dart';
import '../../widgets/custom_toast/custom_toast.dart';
import '../main/redeem_points/RedeemPointsScreen.dart';

class MenuScreen extends GetView<HomeController> {
  late double _width;
  late double _height;
  late AppLocalizations _local;



  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    _local = AppLocalizations.of(context)!;
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    controller.getUserProfile(context);
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: _height,
        // child: Image.asset(Assets.imagesBgMenu),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: _height * 0.1,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              height: 90,
              width: 90,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40.0),
                    child:Obx(() => !controller.isLoading.value? Image.network(
                        "${controller.imageUrl.value?? ""}",
                        height: 80.0,
                        width: 80.0,
                        loadingBuilder: (context, child, loadingProgress) =>
                            (loadingProgress == null)
                                ? child
                                : const Center(child: CircularProgressIndicator()),
                        errorBuilder: (context, error, stackTrace) =>
                            Center(child:SvgPicture.asset(Assets.imagesUser,color: Colors.grey,width: 100,height: 100,))):CircularProgressIndicator()),
                  ),
                  Positioned(
                      right: 0,
                      bottom: 0,
                      child: InkWell(
                          onTap: () => {
                                controller.toggleDrawer(),
                                RegisterBinding().dependencies(),
                                controller.selectedIndex.value = 4
                              },
                          child:SvgPicture.asset(Assets.imagesDrawerSetting)))
                ],
              ),
            ),
          Obx(() =>Text(
              "${controller.userName.value ?? ""}",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
              style: AppTextStyles.drawerMenu.copyWith(fontSize: 20),
            )),
            SizedBox(
              height: _height * 0.03,
            ),
            Container(
              height: 1,
              color: Colors.white,
            ),
            SizedBox(
              height: _height * 0.02,
            ),
            getMenuItem(Assets.imagesHome, _local.homepage, () {
              controller.toggleDrawer();
              HomeBinding().dependencies();
              controller.selectedIndex.value = 2;
            }),
            getMenuItem(Assets.imagesCourses, _local.exams, () {
              controller.toggleDrawer();
              MyQuizesBinding().dependencies();
              controller.selectedIndex.value = 3;
            }),
            getMenuItem(Assets.imagesHeart, _local.favorite, () {
              controller.toggleDrawer();
              FavouritsBinding().dependencies();
              controller.selectedIndex.value = 6;
            }),
            getMenuItem(Assets.imagesSms, _local.technical_support, () {
              controller.toggleDrawer();
              SupportBinding().dependencies();
              controller.selectedIndex.value = 8;
            }),
            getMenuItem(Assets.imagesMessage, _local.comments, () {
              controller.toggleDrawer();
              MyCommentsBinding().dependencies();
              controller.selectedIndex.value = 7;
            }),
            getMenuItem(Assets.imagesVideo, _local.the_courses, () {
              controller.toggleDrawer();
              MyCoursesBinding().dependencies();
              controller.selectedIndex.value = 1;
            }),
            getMenuItem(Assets.imagesSubjects, _local.subjects, () {
              controller.toggleDrawer();
              CategoriesBinding().dependencies();
              controller.selectedIndex.value = 5;
            }),
                // getMenuItem(Assets.imagesPoints, _local.redeem_points, () {
                //   controller.toggleDrawer();
                //   // Navigator.push(
                //   //   context,
                //   //   MaterialPageRoute(builder: (context) => RedeemPointsScreen()),
                //   // );
                //   //MyCommentsBinding().dependencies();
                //   controller.selectedIndex.value = 9;
                // }),
            getMenuItem(Assets.imagesTranslate, _local.the_language, () {
              controller.toggleDrawer();
              final store = Get.find<LocalStorageService>();
              store.lang = store.lang=="ar" ?'en' : 'ar';
              var locale =
                  store.lang == "ar" ? Locale('ar', '') : Locale('en', '');

              Get.updateLocale(locale);

              /// Fill webOrigin only when your new origin is different than the app's origin
              WidgetsBinding.instance.addPostFrameCallback((_) {
                RestartWidget.restartApp(context);
              });
            }),
          ]),
        ));
  }

  Widget image(){
    return ClipRRect(
      borderRadius: BorderRadius.circular(40.0),
      child: Image.network(
          "${controller.store.user?.avatar ?? ""}",
          height: 80.0,
          width: 80.0,
          loadingBuilder: (context, child, loadingProgress) =>
          (loadingProgress == null)
              ? child
              : Center(child: CircularProgressIndicator()),
          errorBuilder: (context, error, stackTrace) =>
              Center(child: Image(image: AssetImage('assets/images/edu_gate_logo2.png'),))),
    );
  }

  Widget getMenuItem(
      String assetName, String title, GestureTapCallback onpress) {
    return InkWell(
        onTap: onpress,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Row(children: [
            SvgPicture.asset(assetName),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.drawerMenu,
              ),
            )
          ]),
        ));
  }
}
