import 'package:Sabora/app/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../widgets/Copune_item/CopuneItem.dart';
import '../../../widgets/main_toolbar/main_toolbar.dart';
import '../../../widgets/replacement_record/ReplacementRecordItem.dart';
import 'controller/RedeemPointController.dart';

class RedeemPointsScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _RedeemPointsScreen();
  }
}

class _RedeemPointsScreen extends State<RedeemPointsScreen>{
 late AppLocalizations _local;
 final redeemPointsController=Get.put(RedeemPointsController());


 @override
  void initState() {
   redeemPointsController.getPoints();
  }

  @override
  Widget build(BuildContext context) {
    _local = AppLocalizations.of(context)!;
    return DefaultTabController(
      length: 1,
      child: Scaffold(
          backgroundColor: Colors.white24,
          appBar:buildMainToolBar(redeemPointsController,
              isMenu: true,
              _local.redeem_points,()=>redeemPointsController.toggleDrawer()),
        body: ListView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              margin: const EdgeInsetsDirectional.only(start: 8,end: 8,top: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                color: AppColors.primary
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => !redeemPointsController.isLoading.value?Text(redeemPointsController.listPointsResponse.value.balance??"",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Cairo",
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ):Text("")),
                Obx(() => !redeemPointsController.isLoading.value?Text(_local.wallet_points,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Cairo",
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ):Container())
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8,),
            Container(
              height: MediaQuery.of(context).size.height/2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsetsDirectional.only(start: 8,end: 8),
                        child: Text(_local.redeem_points_for,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Cairo",
                              color: AppColors.gray),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(child:Obx(() => !redeemPointsController.isLoading.value
                            ? CopuneList()
                            : Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        )))
                  ],
                    )
            ),
            Container(
                height: MediaQuery.of(context).size.height/4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsetsDirectional.only(start: 8,end: 8),
                      child: Text(_local.replacement_record,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Cairo",
                            color: AppColors.gray),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(child:Obx(() => !redeemPointsController.isLoading.value
                        ? ReplacementRecord()
                        : Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ))),
                  ],

                )
            ),
          ],
        ),

      ),
    );
  }

  Widget CopuneList(){
    return ListView.builder(
        itemCount: redeemPointsController.pointsList.length,
        itemBuilder: (context,int index){
          return CopuneItem(
            points: redeemPointsController.pointsList[index],
          );
        }
    );
  }

  Widget ReplacementRecord(){
    if(redeemPointsController.recordsList.isNotEmpty) {
      return ListView.builder(
          itemCount: redeemPointsController.recordsList.length,
          itemBuilder: (context, int index) {
            return ReplacementRecordItem(
              coupon: redeemPointsController.recordsList[index],
            );
          }
      );
    }else{
      return emptyRecord();
    }
  }

  Widget emptyRecord(){
   return Container(
     margin: EdgeInsetsDirectional.only(start: 8,end: 8),
     child: Text(_local.nothing,
       style: TextStyle(
           fontSize: 16,
           fontWeight: FontWeight.w400,
           fontFamily: "Cairo",
           color: AppColors.gray),
       textAlign: TextAlign.center,
     ),
   );
  }
}

