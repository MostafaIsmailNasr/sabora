
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../app/config/app_colors.dart';
import '../../../../app/config/app_text_styles.dart';
import '../../../../app/util/util.dart';
import '../../../../data/models/support/Conversations.dart';
import '../../../../data/models/support/Ticketsdata.dart';
import '../../../../generated/assets.dart';
import '../../../controllers/support/support_controller.dart';
import '../../../widgets/add_ticket_reply/add_ticket_reply.dart';
import '../../../widgets/button.dart';
import '../../../widgets/custom_toast/custom_toast.dart';
import '../../../widgets/main_toolbar/main_toolbar.dart';

class SupportTicketDetailsScreen extends GetView<SupportController> {
  late AppLocalizations _local;
  late double _height;
  late double _width;


  SupportTicketDetailsScreen(Ticketsdata ticket){
    controller.ticket.value=ticket;
  }


  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    _local = AppLocalizations.of(context)!;
    _height = MediaQuery
        .of(context)
        .size
        .height;
    _width = MediaQuery
        .of(context)
        .size
        .height;
    ToastMContext().init(context);

    return Scaffold(
      backgroundColor: Colors.white24,
      appBar: buildMainToolBar(controller,controller.ticket.value.title??"", () =>
      {
        Get.back()
      }),
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
               Obx(() =>  Expanded(
            child: ListView.builder(
              controller: controller.scrollController,
              // physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: controller.ticket.value.conversations?.length,
              itemBuilder: (context, position) {
                return _buildSupportConversationItem(
                    controller.ticket.value.conversations![position]);
              },
            ),
          ) )
          ,
          Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ]),
            child: Row(children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: myButton(() {
                    showAddTicketReplyBottomSheet(
                        context, (dynamic message, dynamic attachedFile) {
                      controller.addTicketReply(controller.ticket.value.id.toString(),message,attachedFile);
                    });
                  }, _local.reply),
                ),
              )
              ,

            Obx(() => controller.ticket.value.status!="close"?  InkWell(
                onTap: () =>
                {
                  controller.closeTicket(controller.ticket.value.id.toString())
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: AppColors.red),
                      borderRadius: BorderRadius.all(Radius.circular(16))
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.close_rounded),
                  ),
                ),
              ):Container()),
              SizedBox(width: 20,) /*: Container()*/
            ]),
          )
        ],
      ),
    );
  }

  _buildSupportConversationItem(Conversations conversations) {
    if (conversations.supporter != null) {
      return Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 48,
                  width: 48,
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: Image.network(
                          height: 48,
                          width: 48,
                          conversations.supporter != null
                              ? conversations.supporter?.avatar ?? ""
                              : "",
                          fit: BoxFit.fill,
                          loadingBuilder: (context, child, loadingProgress) =>
                          (loadingProgress == null)
                              ? child
                              : Center(child: CircularProgressIndicator()),
                          errorBuilder: (context, error, stackTrace) =>
                              Center(
                                  child: SvgPicture.asset(
                                      Assets.assetsImagesEClassesLogoMain)),
                        )),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                  ),
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 5),
                      child: Text(
                        conversations.message ?? "",
                        style: AppTextStyles.body.copyWith(color: Colors.white),
                      )),
                )
              ],
            ),
            Text(
              Utils.getFormatedDate(conversations.createdAt ?? 0),
              style: AppTextStyles.body,
            ),
            conversations.attach != null
                ? Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border.all(color: AppColors.gray5,
                      width: 1)),
              child: InkWell(
                onTap: () => {

                    Utils.openUrl(Uri.parse(conversations.attach))

                },
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.attach_file_rounded),
                          Text("file"),

                        ])),
              ),
            )
                : Container()
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.graydark,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                  ),
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 5),
                      child: Text(
                        conversations.message ?? "",
                        style: AppTextStyles.body.copyWith(color: Colors.white),
                      )),
                )
              ],
            ),
            Text(
              Utils.getFormatedDate(conversations.createdAt ?? 0),
              style: AppTextStyles.body,
            ),
            conversations.attach != null
                ? Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  border: Border.all(color: AppColors.gray5,
                      width: 1)),
              child: InkWell(
                onTap: () => {

                Utils.openUrl(Uri.parse(conversations.attach))
              },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.attach_file_rounded),
                        Text("file"),

                      ]),
                ),
              ),
            )
                : Container()
          ],
        ),
      );
    }
  }


// @override
// void dispose() {
//   IsolateNameServer.removePortNameMapping('downloader_send_port');
//   super.dispose();
// }


// static downlaodCallBack(
//     String id,
//     DownloadTaskStatus status,
//     int progress,
//     ){
//   //if (taskId != null) FlutterDownloader.open(taskId: taskId);
//   print("progress==>>${progress}");
// }

}


