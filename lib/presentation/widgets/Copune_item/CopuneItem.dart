import 'package:Sabora/app/config/app_colors.dart';
import 'package:Sabora/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../data/models/listPointsModle/ListPointsResponse.dart';
import '../../pages/main/redeem_points/controller/RedeemPointController.dart';
class CopuneItem extends StatelessWidget{
  late AppLocalizations _local;
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        side: BorderSide(color: AppColors.secoundry, width: 2),
      ));
  final Points? points;
  final redeemPointsController=Get.put(RedeemPointsController());


  CopuneItem({required this.points});

  @override
  Widget build(BuildContext context) {
    _local = AppLocalizations.of(context)!;
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 120,
        margin: const EdgeInsetsDirectional.only(start: 8,end: 8,bottom: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white
        ),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration:points!.image!.isNotEmpty?
              BoxDecoration(
                  image: DecorationImage(image: NetworkImage(points!.image!),fit: BoxFit.fill),
                  //borderRadius: BorderRadius.circular(50)
              ):
              BoxDecoration(
                image: const DecorationImage(image: AssetImage(Assets.imagesCopune)),
                //borderRadius: BorderRadius.circular(50)
              ),
            ),
            const SizedBox(width: 5,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text((points!.name!+" "+"( "+points!.value!+ " )")??_local.coupon,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Cairo",
                      color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                 Text((points!.pointsNumber.toString()+"Points")??"",
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Cairo",
                      color: Colors.black),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 8,),
                Container(
                  width: 200,
                  child: TextButton(
                    style: flatButtonStyle ,
                    onPressed: (){
                      _onAlertButtonsPressed(context,points!.message??"");
                    },
                    child: Text(_local.replace,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Cairo",
                          color: AppColors.primary),
                    )
                  ),
                ),
              ],
            )
          ],
        ),
      );
  }

  _onAlertButtonsPressed(context,String des) {
    Alert(
      context: context,
      title: _local.confirm_replacement,
      style:  AlertStyle(
        titleStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: AppColors.graydark,fontFamily: 'Cairo'),
        descStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.gray,fontFamily: 'Cairo'),
      ),
      desc: des,
      buttons: [
        DialogButton(
          height: 53,
          child: Text(
            _local.confirm,
            style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'Cairo'),
          ),
          onPressed: () => {
            redeemPointsController.createCoupon(points!.id!,context)
          },
          color: AppColors.primary,
        ),
        DialogButton(
          height: 53,
          child: Text(
            _local.cancel_all,
            style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: AppColors.gray,fontFamily: 'Cairo'),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.white,

        )
      ],
    ).show();
  }

}