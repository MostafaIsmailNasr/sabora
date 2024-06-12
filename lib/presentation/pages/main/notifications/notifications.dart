import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../app/config/app_colors.dart';
import '../../../../app/config/app_text_styles.dart';
import '../../../../app/util/util.dart';
import '../../../../data/models/notifications/Notifications.dart';
import '../../../../generated/assets.dart';
import '../../../controllers/home/home_controller.dart';
import '../../../widgets/custom_toast/custom_toast.dart';
import '../../../widgets/empty_widget/empty_widget.dart';
import '../../../widgets/main_toolbar/main_toolbar.dart';
import '../../../widgets/notification_seen/notifiction_details.dart';

class NotificationsScreen extends GetView<HomeController> {
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

    Future.delayed(Duration.zero, () {
      //your code goes here
      ToastMContext().init(context);
      controller.getNotificationsList();
    });

    return Scaffold(
      backgroundColor: Colors.white24,
      appBar: buildMainToolBar(controller,
          _local.notifications,
          () =>
              {
                Get.back()
              })
      ,
      body:Obx(() => controller.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : controller.notificationsList.value.isEmpty?buildEmptyWidget(context,SvgPicture.asset(Assets.imagesNoNotification),
          _local.there_are_no_notifications,
          _local.you_dont_have_any_notifications_yet
      ):_buildNotificationsList(controller.notificationsList.value)),
    );
  }
  _buildNotificationsList(List<dynamic> notifications){
    return ListView.builder(
      //  physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: notifications.length,
      itemBuilder: (context, position) {
        return _buildNotificationITem(context,notifications[position]);
      },
    );
  }

  _buildNotificationITem(BuildContext context,Notifications notification){
    return GestureDetector(
      onTap: ()=>{
        if(notification.status=="unread"){
          controller.markNotificationAsReaded(notification.id.toString())
        },
        showNotificationDetailsBottomSheet(context,notification)
      },
        // Container(
        //     padding: EdgeInsets.all(10),
        //     decoration: BoxDecoration(
        //         color: AppColors.primary2,
        //         borderRadius: BorderRadius.all(Radius.circular(10))
        //     ),
        //     child: SvgPicture.asset(Assets.imagesIcNoti))
      child: Card(
        color: notification.status=="unread"?AppColors.gray3:Colors.white,
        margin: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 5),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              margin: EdgeInsets.all( 10),
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10)
              ),
              child:

              Stack(children: [
                Container(
                    margin: EdgeInsets.only(top: 8,left: 5,right: 5,bottom: 2),
                    child:Center(child: SvgPicture.asset(Assets.imagesIcNoti)),),
                notification.status=="unread"?Container(
                  margin: EdgeInsets.all(10),
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                      color: AppColors.red
                      ,shape: BoxShape.circle),
                ):Container()
              ],),

            ),
            Expanded(
              child: Row(children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.title??"", style: AppTextStyles.titleToolbar.copyWith(
                          fontSize: 14
                      ),),
                      Text(Utils.getFormatedDate(notification.createdAt??0), style: AppTextStyles.body,)
                    ],
                  ),
                )

              ],),
            )
          ],
        ),
      ),
    );
  }
}
