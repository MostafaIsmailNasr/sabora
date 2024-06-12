import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

import '../../../app/base/base_controller/BaseController.dart';
import '../../../app/config/app_colors.dart';
import '../../../generated/assets.dart';
import '../../controllers/home/home_controller.dart';
import '../../controllers/my_quizes/my_quizes_binding.dart';
import '../../controllers/support/support_binding.dart';
import '../../widgets/custom_toast/custom_toast.dart';
import 'drawer_menu.dart';
import 'home_page.dart';

class ParentMainScreen extends GetView<HomeController> {

  int? selectedIndex=-1;
  ParentMainScreen({this.selectedIndex});


  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);

    WidgetsBinding.instance.addPostFrameCallback((_){
    if(selectedIndex!=-1){
      if(selectedIndex==8){
        selectedIndex=-1;
        SupportBinding().dependencies();
        controller.selectedIndex.value = 8;
      }else if(selectedIndex==3){
        selectedIndex=-1;
        MyQuizesBinding().dependencies();
        controller.selectedIndex.value = 3;
      }
    }});
    return WillPopScope(
        onWillPop: () async {
          print("isDrawerOpen0");
          bool Function()? isDrawerOpen = BaseController.drawerController?.isOpen;
          print(isDrawerOpen);
          if (isDrawerOpen != null) {
            if (isDrawerOpen()) {
              BaseController.drawerController?.toggle?.call();
              return false;
            }
          }


          return true;

    },
    child:Scaffold(
        body: Stack(
          children: [
            Container(
              color: AppColors.primary,
              height: MediaQuery.of(context).size.height,
              child: Wrap(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Column(

                      children: [
                        Image.asset(Assets.imagesBgMenu)
                      ],
                    )],
                  ),
                ],
              ),
            ),
            ZoomDrawer(
              isRtl: controller.store.lang=="ar",
              controller: BaseController.drawerController,
              style: DrawerStyle.defaultStyle,
              menuScreen: MenuScreen(),
              mainScreen: HomePage(),
              borderRadius: 24.0,
              showShadow: false,
              angle: 0.0,
                menuScreenTapClose:true,
              mainScreenTapClose:true ,
              slideWidth: MediaQuery.of(context).size.width * 0.7,
              // backgroundColor: AppColors.primary,
              // slideWidth: MediaQuery.of(context).size.width *
              //     (/*ZoomDrawer.isRTL ? .45 :*/ .45),
              openCurve: Curves.fastOutSlowIn,
              closeCurve: Curves.bounceIn,
            )
          ],
        )));

  }
}
