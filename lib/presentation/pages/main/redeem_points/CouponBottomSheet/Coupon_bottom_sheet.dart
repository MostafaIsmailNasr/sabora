import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../app/config/app_colors.dart';
import '../../../../widgets/custom_toast/custom_toast.dart';
import '../controller/RedeemPointController.dart';

class CouponBottomSheet extends StatefulWidget{
  var code;
  CouponBottomSheet({required this.code});
  @override
  State<StatefulWidget> createState() {
    return _CouponBottomSheet();
  }
}

class _CouponBottomSheet extends State<CouponBottomSheet>{
  late AppLocalizations _local;
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    backgroundColor: AppColors.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ));
  final redeemPointsController=Get.put(RedeemPointsController());

  @override
  Widget build(BuildContext context) {
    _local = AppLocalizations.of(context)!;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 60,
              height: 5,
              color: AppColors.gray,),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: EdgeInsetsDirectional.all(25),
            child: Text(_local.voucher_purchase,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Cairo",
                  color: AppColors.graydark),
              textAlign: TextAlign.start,
            ),
          ),
          _buildCodeItem(),
          Container(
            margin: EdgeInsetsDirectional.only(end: 30,start: 30),
            width:  MediaQuery.of(context).size.width,
              height: 60,
              child: TextButton(
                  style: flatButtonStyle ,
                  onPressed: (){
                    Clipboard.setData(ClipboardData(text: widget.code));
                    redeemPointsController.showToast(widget.code!,
                        gravity: Toast.bottom, isSuccess: true);
                    print(widget.code);
                  },
                  child: Text(_local.copy_code,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Cairo",
                        color:Colors.white)
                  )
              )),
        ],
      ),
    );
  }


  _buildCodeItem() {
    return Container(
      width: Size.infinite.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12)),
      child: DottedBorder(
        borderType: BorderType.RRect,
        strokeCap: StrokeCap.round,
        color: AppColors.pointsColor,
        dashPattern: const [5, 4, 5, 4],
        strokeWidth: 1,
        radius: const Radius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ... widget.code.split("").map((e) => Text(
                    e,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Cairo",
                        color: AppColors.pointsColor),
                  ),).toList()
                ]),
          ),
        ),
      ),
    );
  }

}