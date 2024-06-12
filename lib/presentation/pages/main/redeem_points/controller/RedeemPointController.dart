import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../../app/base/base_controller/BaseController.dart';
import '../../../../../app/services/local_storage.dart';
import '../../../../../data/models/couponModel/CouponResponse.dart';
import '../../../../../data/models/listPointsModle/ListPointsResponse.dart';
import '../../../../../data/providers/web_servies/WebServies.dart';
import '../../../../../data/repositories/Redmee_points_repository.dart';
import '../../../../widgets/custom_toast/custom_toast.dart';
import '../CouponBottomSheet/Coupon_bottom_sheet.dart';

class RedeemPointsController extends BaseController {
  PointsRepository repo = PointsRepository(WebService());
  var listPointsResponse = ListPointsResponse().obs;
  var couponResponse = CouponResponse().obs;
  var isLoading=false.obs;
  RxList<dynamic> pointsList=[].obs;
  RxList<dynamic> recordsList=[].obs;

  getPoints()async{
    final storage = Get.find<LocalStorageService>();
    isLoading.value=true;
    listPointsResponse.value = await repo.listPoints(storage.apiToken!);
    pointsList.value=listPointsResponse.value.data??[] as List;
    recordsList.value=listPointsResponse.value.coupons??[];
    isLoading.value=false;
    return listPointsResponse.value;
  }

  createCoupon(int id,BuildContext context)async{
    final storage = Get.find<LocalStorageService>();
    //isLoading.value=true;
    couponResponse.value = await repo.createCoupon(storage.apiToken!,id);
    if(couponResponse.value.success==true){
      Get.back();
      getPoints();
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
                child: CouponBottomSheet(code:couponResponse.value.data!.code!),
              )
          )
      );
    }else{
      Get.back();
      showToast(couponResponse.value.message!,
          gravity: Toast.bottom, isSuccess: false);
    }
    return listPointsResponse.value;
  }

}