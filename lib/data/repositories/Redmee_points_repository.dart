import '../models/couponModel/CouponResponse.dart';
import '../models/listPointsModle/ListPointsResponse.dart';
import '../providers/web_servies/WebServies.dart';

class PointsRepository {
  WebService webService;
  PointsRepository(this.webService);

  Future<ListPointsResponse> listPoints(String token)async{
    final points=await webService.listPoints(token);
    return points;
  }

  Future<CouponResponse> createCoupon(String token,int id)async{
    final coupon=await webService.createCoupon(token,id);
    return coupon;
  }

  Future<dynamic> addCommentWithImageAndVoice(String? itemID, String? itemName, String? courseId,
      String? commentImag, String? commentSound, String? comment)async{
    final addCommentWithImage=await webService.addCommentWithImageAndVoice(itemID, itemName, courseId, commentImag, commentSound, comment);
    return addCommentWithImage;
  }

}