import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../app/config/app_colors.dart';
import '../../../../app/config/app_text_styles.dart';
import '../../../../app/util/util.dart';
import '../../../../generated/assets.dart';
import '../../../controllers/support/support_controller.dart';
import '../../../widgets/add_ticket_reply/add_new_ticket.dart';
import '../../../widgets/custom_toast/custom_toast.dart';
import '../../../widgets/empty_widget/empty_widget.dart';
import '../../../widgets/main_toolbar/main_toolbar.dart';
import 'support_ticket_details.dart';

class SupportScreen extends GetView<SupportController> {
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
    ToastMContext().init(context);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white24,
          appBar: buildMainToolBar(controller,_local.technical_support, () => controller.toggleDrawer(),
              isMenu: true),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Center(child: SvgPicture.asset(Assets.imagesIcSupport)),
              ),
              _buildTabBar(),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                child: TabBarView(children: [
                  _buildTechnicalSupport(context),
                  _buildMessageSupport(context)
                ]),
              ),
            ],
          ),
        ));
  }

  _buildTechnicalSupport(BuildContext context) {
    controller.getSupportContacts();
    return Obx(() => controller.supportList.value.isEmpty? buildEmptyWidget(context,SvgPicture.asset(Assets.imagesNoTickets),
        _local.there_are_no_tickets,
        _local.need_help_create_a_support_request_again
    ):ListView.builder(
          // physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: controller.supportList.value.length,
          itemBuilder: (context, position) {
            return _buildSupportItem(
                0, controller.supportList.value[position], context);
          },
        ));
  }

  _buildMessageSupport(BuildContext context) {
    controller.getSupportTickets();
    controller.getDepartments();

    return Obx(() => Stack(
          children: [
            controller.supportTicketsList.value.isEmpty? buildEmptyWidget(context,SvgPicture.asset(Assets.imagesNoTickets),
                _local.there_are_no_tickets,
                _local.need_help_create_a_support_request_again
            ): ListView.builder(
              // physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: controller.supportTicketsList.value.length,
              itemBuilder: (context, position) {
                return _buildSupportItem(
                    1, controller.supportTicketsList.value[position], context);
              },
            ),
            PositionedDirectional(
              bottom: 0,
              end:0,
              child: InkWell(
                onTap: ()=>{
                  showAddNewTicketBottomSheet(context,controller.departmentsList.value, (ticketTitle, ticketMessage,departmentID, attachedFile) {

                    controller.addNewTicket(departmentID,ticketTitle, ticketMessage, attachedFile);
                  })
                },
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 100),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Center(
                        child: Container(
                          color: Colors.white,
                          width: 40,
                          height: 40,
                        ),
                      ),
                      SvgPicture.asset(
                        Assets.imagesIcAddTicket,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  //type 0-->technical support  1-->message support
  _buildSupportItem(int type, dynamic ticket, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: ListTile(
        onTap: () => {
          if (type == 0)
            {
              if (ticket.type == "both")
                {_openSelectWhatsOrPhoneDialog(context, ticket.number)}
              else if (ticket.type == "phone")
                {_initiateCall(ticket.number)}
              else
                {Utils.openUrl(Uri.parse("https://wa.me/" + ticket.number))}
            }
          else
            {Get.to(SupportTicketDetailsScreen(ticket))}
        },
        contentPadding: const EdgeInsets.all(0),
        leading: Container(
            margin: const EdgeInsets.all(3), child: _getLeadingIcon(type, ticket)),
        title: Text(
          ticket.title ?? "",
          style: AppTextStyles.title2.copyWith(fontSize: 16),
        ),
        subtitle: type == 1
            ? Text(
                Utils.getFormatedDate(ticket.createdAt ?? 0),
                style: AppTextStyles.title2
                    .copyWith(fontSize: 16, color: AppColors.gray),
              )
            : null,
        trailing: type == 1
            ? Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                decoration: BoxDecoration(
                    color: ticket.status=="open"?AppColors.yello2:(ticket.status=="close"?AppColors.red:AppColors.green),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Text(
                      ticket.status ?? "",
                      style: AppTextStyles.title2
                          .copyWith(fontSize: 10, color:  ticket.status=="open"?AppColors.yello:Colors.white),
                    )))
            : Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }

  _getLeadingIcon(int type, ticket) {
    if (type == 1) {
      return SvgPicture.asset(Assets.imagesIcMessageSupport);
    } else {
      switch (ticket.type) {
        case "both":
          return Image.asset(Assets.imagesIcWhatsCall2);

        case "phone":
          return SvgPicture.asset(Assets.imagesIcSupportCall);

        default:
          return Image.asset(Assets
              .imagesWhatsappIcon); //SvgPicture.asset(Assets.imagesIcWhatsapp);
      }
    }
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
                child: TabBar(
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
                              child: Text(_local.technical_support, textAlign: TextAlign.center),),)),
                      Tab(
                          child: Container(
                            width: 180,
                            /* decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.primary, width: 1)),*/
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(_local.contact_the_administration, textAlign: TextAlign.center),),)),
                    ])),
          )),
    );
  }

  void _requestPermission() {
    // CallWithWhatsapp.requestPermissions().then((x) {
    //   print("success");
    // }).catchError((e) {
    //   print(e);
    // });
  }

  void _openStore() {
    // CallWithWhatsapp.openInPlayStore().then((x) {
    //   print("success");
    // }).catchError((e) {
    //   print(e);
    // });
  }

  void _initiateCall(String number) {
    Utils.openUrl(Uri.parse("tel:+2" + number));
  }

  _openSelectWhatsOrPhoneDialog(BuildContext context, String number) {
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 15),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24))),
              content: Container(
                  // width: MediaQuery.of(context).size.width * 1.9,
                  // height: MediaQuery.of(context).size.height * 0.4,
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap: () => {Get.back()},
                          child: Icon(Icons.close_rounded)),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        _local.contact_technical_support,
                        style: AppTextStyles.title
                            .copyWith(fontSize: 13, color: AppColors.graydark),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ListTile(
                    onTap: () => {Get.back(), _initiateCall(number)},
                    leading: SvgPicture.asset(Assets.imagesIcSupportCall),
                    title: Text(
                      "اتصال هاتفى",
                      style: AppTextStyles.title2
                          .copyWith(fontSize: 12, color: AppColors.gray2),
                    ),
                  ),
                  ListTile(
                    onTap: () => {
                      Get.back(),
                      Utils.openUrl(Uri.parse("https://wa.me/" + number))
                    },
                    leading: Image.asset(Assets.imagesWhatsappIcon),
                    title: Text(
                      "واتساب",
                      style: AppTextStyles.title2
                          .copyWith(fontSize: 12, color: AppColors.gray2),
                    ),
                  )
                ],
              )));
        });
  }
}
