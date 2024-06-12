import 'package:Sabora/presentation/widgets/custom_toast/custom_toast.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/base/base_controller/BaseController.dart';
import '../../../app/config/app_colors.dart';
import '../../../app/config/app_text_styles.dart';
import '../../../data/models/home/course_details/Course.dart';
import '../../../generated/assets.dart';
import '../../controllers/course_details/course_details_binding.dart';
import '../../controllers/home/home_controller.dart';
import '../../controllers/search/search_binding.dart';
import '../../controllers/support/support_binding.dart';
import '../../widgets/course.dart';
import '../../widgets/search_input.dart';
import '../../widgets/slider.dart';
import '../course_details/course_details.dart';
import '../main/fearured_courses/featured_courses.dart';
import '../main/latests_courses/latests_courses.dart';
import '../main/notifications/notifications.dart';
import '../search/search.dart';

final List<MenuItem> options = [
  MenuItem(Icons.payment, 'Payments'),
  MenuItem(Icons.favorite, 'Discounts'),
  MenuItem(Icons.notifications, 'Notification'),
  MenuItem(Icons.format_list_bulleted, 'Orders'),
  MenuItem(Icons.help, 'Help'),
];

class HomeScreen extends GetView<HomeController> {
  late AppLocalizations _local;
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  late double _width;
  late double _height;
  List<int> top = <int>[];
  List<int> bottom = <int>[0];

  HomeScreen({super.key});

  Future<void> initDynamicLinks() async {
    final PendingDynamicLinkData? data = await dynamicLinks.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      // ignore: unawaited_futures
      print(deepLink.queryParameters);
      if (Get.context != null) {
        var courseID = deepLink.queryParameters["courseID"];
        print("courseID");
        print(courseID);
        CourseDetailsBinding().dependencies();
        Navigator.of(Get.context!).push(
          MaterialPageRoute(
              builder: (_) => CourseDetailsScreen(courseID.toString())),
        );
      }
    }
    dynamicLinks.onLink.listen((dynamicLinkData) {
      CourseDetailsBinding().dependencies();
      print(dynamicLinkData.utmParameters);
      /*// if (Get.context != null) {
      //   var courseID = dynamicLinkData.utmParameters["courseID"];
      //   Navigator.of(Get.context!).push(
      //     MaterialPageRoute(
      //         builder: (_) => CourseDetailsScreen(courseID.toString())),
      //   );
      // }*/
        if (Get.context != null) {
          var courseID = dynamicLinkData.link.queryParameters["courseID"];
          print("courseID");
          print(courseID);
          CourseDetailsBinding().dependencies();
          Navigator.of(Get.context!).push(
            MaterialPageRoute(
                builder: (_) => CourseDetailsScreen(courseID.toString())),
          );
        }
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);

    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    _local = AppLocalizations.of(context)!;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Add Your Code here.
      ToastMContext().init(context);

      controller.onInit();
      controller.getProfileData(context);

      if (BaseController.clickActionID != null) {
        /* if (BaseController.clickAction == "instructor") {
          Get.to(TeacherDetailsScreen(BaseController.clickActionID.toString()));

        }else if (BaseController.clickAction == "course") {

          Get.to(CourseDetailsScreen(BaseController.clickActionID.toString()),binding: CourseDetailsBinding());

        }else if (BaseController.clickAction == "home") {



        }else */
        if (BaseController.clickAction == "support") {
          controller.toggleDrawer();
          SupportBinding().dependencies();
          controller.selectedIndex.value = 8;
        }

        BaseController.clickActionID = null;
        BaseController.clickAction = null;
      }
      initDynamicLinks();
    });

    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.primary, // Status bar color
            toolbarHeight: 0,
            foregroundColor: AppColors.primary),
        body: SizedBox(
          height: _height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                ListTile(
                  tileColor: AppColors.primary,
                  leading: GestureDetector(
                      onTap: () => {
                            //Get.to(NoInternetScreen())
                            controller.toggleDrawer()
                          },
                      child: RotatedBox(
                        quarterTurns: controller.store.lang == "ar" ? 0 : 90,
                        child: SvgPicture.asset(Assets.imagesMenu),
                      )),
                  title:
                      // Text(
                      //   "Ali Mahmoud",
                      //   style: AppTextStyles.title
                      //       .copyWith(color: Colors.white, fontSize: 18),
                      // ),
                      Row(mainAxisSize: MainAxisSize.min, children: [
                    Obx(() => Expanded(
                          child: Text(
                            _local.welcome + " " + controller.userName.value,
                            //softWrap:true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: AppTextStyles.title
                                .copyWith(color: Colors.white, fontSize: 18),
                          ),
                        )),
                    Image.asset(Assets.imagesWave),
                  ]),
                  subtitle: Text(
                    _local.lets_start_learning,
                    style: AppTextStyles.title2.copyWith(color: Colors.white),
                  ),
                  trailing: GestureDetector(
                      onTap: () => {Get.to(NotificationsScreen())},
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                              color: Colors.white,//AppColors.primary3,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Stack(
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(
                                      top: 8, left: 5, right: 5, bottom: 2),
                                  child: SvgPicture.asset(Assets.imagesIcNoti,color: Colors.black,)),
                              Obx(() =>
                                  controller.numberOfUnreadedNotifi.value != "0"
                                      ? Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.red,
                                              shape: BoxShape.circle),
                                          child: Padding(
                                              padding: const EdgeInsets.all(4),
                                              child: Text(
                                                controller
                                                    .numberOfUnreadedNotifi
                                                    .value,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              )),
                                        )
                                      : const SizedBox(
                                          width: 0,
                                          height: 0,
                                        ))
                            ],
                          ))),
                ),
                SizedBox(
                    height: _height * 0.87,
                    child: NestedScrollView(
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxScrolled) {
                        print("innerBoxScrolled");
                        print(innerBoxScrolled);
                        return <Widget>[
                          SliverAppBar(
                            toolbarHeight: 0,
                            // shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.only(
                            //         bottomLeft: Radius.circular(20),
                            //         bottomRight: Radius.circular(20))),
                            automaticallyImplyLeading: true,
                            leading: IconButton(
                                icon: const Icon(Icons.arrow_back),
                                onPressed: () => Navigator.pop(context, false)),
                            expandedHeight: 80.0,
                            floating: false,
                            pinned: false,
                            stretch: true,
                            onStretchTrigger: () async {
                              Navigator.of(context).pop();
                            },
                            backgroundColor: AppColors.primary,
                            bottom: PreferredSize(
                                preferredSize: const Size.fromHeight(80),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: InkWell(
                                    onTap: () => {
                                      SearchBinding().dependencies(),
                                      Get.to(SearchScreen())
                                    },
                                    child: MySearchTextFieldForm(
                                      isEditable: false,
                                      assetNamePrefex: Assets.imagesSearch,
                                      hint: _local
                                          .type_what_you_want_to_search_for_here,
                                    ),
                                  ),
                                )),
                          )
                        ];
                      },
                      body: Column(children: [
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                          child: Container(
                            height: _height * 1.1,
                            margin: const EdgeInsets.only(bottom: 50),
                            child: Column(
                              children: [
                                Obx(() => MySlider(
                                    controller.advertisingBanners.value)),
                                getRowHeader(_local.latest_courses, () {
                                  Get.to(LatestsCoursesScreen());
                                }),
                                Obx(
                                  () => controller.isLoading.value
                                      ? const CircularProgressIndicator()
                                      : SizedBox(
                                          width: _width,
                                          height: _height * 0.28,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: controller
                                                .newestCourses.value.length,
                                            itemBuilder: (context, position) {
                                              var item = controller
                                                  .newestCourses
                                                  .value[position] as Course;
                                              return getCourseItem(
                                                  context, item,
                                                  callback: () => {
                                                        Get.to(
                                                            CourseDetailsScreen(
                                                                item.id
                                                                    .toString()),
                                                            binding:
                                                                CourseDetailsBinding())
                                                      });
                                            },
                                          )), /*ListView(
                                      shrinkWrap: true,
                                      // This next line does the trick.
                                      scrollDirection: Axis.horizontal,
                                      children: <Widget>[
                                        getCourseItem(context),
                                        getCourseItem(context)
                                      ]),*/
                                ),
                                getRowHeader(_local.featured_courses, () {
                                  Get.to(FeaturedCoursesScreen());
                                }),
                                Obx(
                                  () => controller.isLoading.value
                                      ? const CircularProgressIndicator()
                                      : SizedBox(
                                          width: _width,
                                          height: _height * 0.28,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: controller
                                                .featuredCourses.value.length,
                                            itemBuilder: (context, position) {
                                              var item = controller
                                                  .featuredCourses
                                                  .value[position] as Course;
                                              return getCourseItem(
                                                  context, item,
                                                  callback: () => {
                                                        Get.to(
                                                            CourseDetailsScreen(
                                                                item.id
                                                                    .toString()),
                                                            binding:
                                                                CourseDetailsBinding())
                                                      });
                                            },
                                          )) /* ListView(
                                      shrinkWrap: true,
                                      // This next line does the trick.
                                      scrollDirection: Axis.horizontal,
                                      children: <Widget>[
                                        //getCourseItem(context),
                                        //getCourseItem(context)
                                      ])*/
                                  ,
                                ),
                              ],
                            ),
                          ),
                        ))
                      ]),
                    )),
              ],
            ),
          ),
        ));
  }

  Widget getRowHeader(String title, GestureTapCallback callback) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.title.copyWith(fontSize: 18),
          ),
          TextButton(
              onPressed: callback,
              child: Text(
                _local.view_all,
                style: AppTextStyles.title2.copyWith(color: AppColors.gray2),
              ))
        ],
      ),
    );
  }
}

// class MainScreen extends GetView<HomeController> {
//   const MainScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {

//     return Container(
//       color: Colors.pink,
//       child: Center(
//         child: ElevatedButton(
//           onPressed: () => {controller.toggleDrawer()},
//           // onPressed: (controller as HomeController).toggleDrawer(),
//           child: Text("Toggle Drawer"),
//         ),
//       ),
//     );
//   }
// }

// class MyDrawerController extends GetxController {
//   final zoomDrawerController = ZoomDrawerController();
//
//   void toggleDrawer() {
//     print("Toggle drawer");
//     zoomDrawerController.toggle?.call();
//     update();
//   }
// }
class MenuItem {
  String title;
  IconData icon;

  MenuItem(this.icon, this.title);
}
