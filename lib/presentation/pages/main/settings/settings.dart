import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../app/config/app_colors.dart';
import '../../../../app/config/app_text_styles.dart';
import '../../../../generated/assets.dart';
import '../../../controllers/auth/register_controller.dart';
import '../../../widgets/button.dart';
import '../../../widgets/custom_toast/custom_toast.dart';
import '../../../widgets/exit_dialog/exit_dialog.dart';
import '../../../widgets/main_toolbar/main_toolbar.dart';
import 'public_tab.dart';
import 'security_tab.dart';

class SettingsScreen extends GetView<RegisterController> {
  late AppLocalizations _local;
  late double _height;
  late double _width;

  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    ToastMContext().init(context);

    // RegisterBinding().dependencies();
    _local = AppLocalizations.of(context)!;
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white24,
      appBar: buildMainToolBar(controller,isMenu: true, _local.settings, () => {
        controller.toggleDrawer()
      }),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        Container(
          child: Expanded(
            flex: 1,
              child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverOverlapAbsorber(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                          sliver: SliverAppBar(
                              titleSpacing: 0,
                              backgroundColor: AppColors.pagbackground,
                              automaticallyImplyLeading: true,
                              //   expandedHeight: 10.0,
                              toolbarHeight: 0,
                              expandedHeight: 0.0,
                              floating: false,
                              pinned: false,
                              stretch: false,
                              bottom: PreferredSize(
                                  preferredSize:
                                      Size.fromHeight(_height * 0.38),
                                  child: Container(
                                    child: _buildHeader(context),
                                  )))),
                    ];
                  },
                  body: Column(
                    children: [
                      _buildTabBar(),
                  Container(
                    child: Expanded(
                      flex: 2,
                        child: TabBarView(
                            controller: controller.tabController,
                            children: [
                              // _buildTabSoldCourses(),
                              PublicTab(),
                              SecurityTab(),
                            //  SubscriptionTab(),
                            ]),
                      ),
                  )
                    ],
                  )
                  // _buildHeader(),
                  ),
            ),
        ),
     Obx(()=>(!controller.isKeyboardVisible.value)?     Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
            child: myButton(() {
              if (controller.selectedTabIndex.value == 0) {
                controller.updateProfile(context);
              }else  if (controller.selectedTabIndex.value == 1) {
                controller.updateProfilePass(context);
              }
            }, _local.save),
          ):Container()),
    Obx(()=> (!controller.isKeyboardVisible.value)? Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
           Container(
               margin: EdgeInsets.only(left: 30, right: 30, bottom: 100),
               child: InkWell(
                 onTap: () => {
                   dialogExitBuilder(
                       context, _local, _local.are_you_sure_you_want_to_log_out, () {
                     Get.back();
                     controller.logoutRequest();
                     controller.logout(context);
                   })
                 },
                 child: Text(
                   _local.logout,
                   style: AppTextStyles.title3
                       .copyWith(color: AppColors.red, fontSize: 14),
                 ),
               )),
       Platform.isIOS?    Container(
               margin: EdgeInsets.only(left: 30, right: 30, bottom: 100),
               child: InkWell(
                 onTap: () => {
                   dialogExitBuilder(
                       context, _local, _local.are_you_sure_you_want_to_delete_account, () {
                     Get.back();
                     controller.deleteAccount(context);

                   })
                 },
                 child: Text(
                   _local.delete_account,
                   style: AppTextStyles.title3
                       .copyWith(color: AppColors.red, fontSize: 14),
                 ),
               )):Container()
         ],):Container())
        ],
      ),
    );
  }

  _buildTabBar() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 10),
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
                        controller: controller.tabController,
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
                    /*      Tab(
                              child: Container(
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.white, width: 1)),
                          ))*/
                        ]),
                    TabBar(
                        controller: controller.tabController,
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
                              child: Text(_local.public),
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
                              child: Text(_local.security),
                            ),
                          )),
                         /* Tab(
                              child: Container(
                            width: 120,
                            *//*decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(16),
                                              border: Border.all(
                                                  color: AppColors.primary, width: 1)),*//*
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                _local.subscription,
                              ),
                            ),
                          ))*/
                        ])
                  ],
                )),
          )),
    );
  }

  _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: ()=>{
            controller.pickImage(context)
          },
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Container(
                  padding: EdgeInsets.all(5),
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                      border: Border.all(color: AppColors.primary, width: 4)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40.0),
                    child: Image.network(
                       // "https://lledogrupo.com/wp-content/uploads/2018/04/user-img-1.png",
                         "${controller.store.user?.avatar ?? ""}",
                        height: 80.0,
                        width: 80.0,
                        loadingBuilder: (context, child, loadingProgress) =>
                            (loadingProgress == null)
                                ? child
                                : Center(child: CircularProgressIndicator()),
                        errorBuilder: (context, error, stackTrace) =>
                            Center(child: Image(image: AssetImage('assets/images/edu_gate_logo2.png')))),
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SvgPicture.asset(Assets.imagesEditPic))
            ],
          ),
        ),
        Text(
          controller.store.user?.fullName??"",
          style: AppTextStyles.authTitleStyle.copyWith(fontSize: 20),
        ),
        Text(
          controller.store.user?.email??"",
          style: AppTextStyles.body.copyWith(fontSize: 13),
        )
      ],
    );
  }

}
