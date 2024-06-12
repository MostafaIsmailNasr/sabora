import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../app/config/app_colors.dart';
import '../../../app/config/app_text_styles.dart';
import '../../../app/util/util.dart';
import '../../../data/models/notifications/Notifications.dart';
import '../button.dart';




showNotificationDetailsBottomSheet(BuildContext context,Notifications notification
   ) {

  var _local = AppLocalizations.of(context)!;
  showModalBottomSheet<void>(
      isScrollControlled: true,
      // context and builder are
      // required properties in this widget
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      builder: (BuildContext context) =>
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery
                    .of(context)
                    .viewInsets
                    .bottom),
            child: SingleChildScrollView(
              child: Form(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
               Text(notification.title??"",style: AppTextStyles.title,),
               Text(Utils.getFormatedDate((notification.createdAt??0)),style: AppTextStyles.body.copyWith(fontSize: 18),),

Container(height: 1,width: MediaQuery.of(context).size.width,color: AppColors.gray4,),

                      Text(notification.message??"",style: AppTextStyles.body.copyWith(fontSize: 18),),
                      Container(
                        margin: EdgeInsets.only(
                             bottom: 20, top: 20),
                        child: Row(children: [
                          Expanded(
                            child: myButton(() {

                                Get.back();
                            }, _local.close),
                          ),

                        ]),
                      ),
                      //  SizedBox(height: 40,)
                    ],
                  ),
                ),
              ),
            ),
          ));


}




