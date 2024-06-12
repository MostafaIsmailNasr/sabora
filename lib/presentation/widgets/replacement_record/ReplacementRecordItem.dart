import 'package:Sabora/app/config/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import '../../../data/models/listPointsModle/ListPointsResponse.dart';
import '../../../generated/assets.dart';
import '../../pages/main/redeem_points/CouponBottomSheet/Coupon_bottom_sheet.dart';
class ReplacementRecordItem extends StatelessWidget{
  late AppLocalizations _local;
  final Coupons coupon;


  ReplacementRecordItem({required this.coupon});

  @override
  Widget build(BuildContext context) {
    _local = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            child: SvgPicture.asset(Assets.imagesRecord),
          ),
          SizedBox(width: 8,),
          Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_local.coupon,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Cairo",
                        color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                   Text((coupon.amount.toString()+" "+ "ج.م")??"",
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Cairo",
                        color: Colors.black),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
          Spacer(),
          InkWell(
            onTap: (){
              showModalBottomSheet<void>(
                  isScrollControlled: true,
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  //backgroundColor:MyColors.DarkWHITE,
                  builder: (BuildContext context)=>DraggableScrollableSheet(
                      expand: false,
                      initialChildSize: 0.4,
                      minChildSize: 0.32,
                      maxChildSize: 0.9,
                      builder: (BuildContext context, ScrollController scrollController)=> SingleChildScrollView(
                        controller:scrollController,
                        child: CouponBottomSheet(code:coupon!.code!),
                      )
                  )
              );
            },
            child: Text(_local.view2,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Cairo",
                  color: AppColors.MainColor),
              textAlign: TextAlign.center,
            ),
          ),


        ],
      ),
    );
  }
}