import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/base/base_controller/BaseController.dart';
import '../../../app/config/app_text_styles.dart';
import '../../../generated/assets.dart';

PreferredSizeWidget buildMainToolBar(
    BaseController controller, String title, GestureTapCallback callback,
    {bool isMenu = false}) {
  return AppBar(
      elevation: 0,
      leadingWidth: 80,
      backgroundColor: Colors.white24,
      centerTitle: true,
      title: Text(
        title,
        style: AppTextStyles.titleToolbar,
      ),
      leading: isMenu
          ? Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
              child: GestureDetector(
                  onTap: callback,
                  child: RotatedBox(
                    quarterTurns: controller.store.lang == "ar" ? 0 : 90,
                    child: SvgPicture.asset(
                      Assets.imagesMenu,
                      width: 25,
                      height: 25,
                      color: Colors.black,
                    ),
                  )))
          : GestureDetector(
              onTap: callback,
              child: Card(
                elevation: 0.2,
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Container(
                  child: controller.store.lang == "ar"
                      ? const RotatedBox(
                          quarterTurns: 90,
                          child: Icon(
                            /*controller.store.lang=="en"?*/ Icons
                                .arrow_forward_ios_rounded,
                            grade: 20 /*:Icons.arrow_back_ios_new_rounded*/,
                            color: Colors.black,
                          ))
                      : const RotatedBox(
                          quarterTurns: 90,
                          child: Icon(
                            /*controller.store.lang=="en"?*/ Icons
                                .arrow_forward_ios_rounded,
                            grade: 20 /*:Icons.arrow_back_ios_new_rounded*/,
                            color: Colors.black,
                          )),
                ),
              )));
}
