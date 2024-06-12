import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart' as dio1;

import '../../../app/services/local_storage.dart';
import '../../models/BaseResponse.dart';
import '../../models/couponModel/CouponResponse.dart';
import '../../models/listPointsModle/ListPointsResponse.dart';

class WebService {
  late dio1.Dio dio;
  late dio1.BaseOptions options;
  final storage = Get.find<LocalStorageService>();
  // var baseUrl = "http://edugatem.com";
  var baseUrl = "https://elsabora.com";

  WebService() {
    options = dio1.BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(milliseconds: 60 * 1000),
      receiveTimeout: Duration(milliseconds: 60 * 1000),
    );
    dio = dio1.Dio(options);
  }

  Future<ListPointsResponse> listPoints(String token)async{
    try {
      var Url="/api/development/redeem_points";
      //print(Url);
        print(options.baseUrl+Url);
        print(token.toString());
        dio1.Response response = await dio.get(Url,
            options: dio1.Options(
              headers: {
                'x-api-key': '1234321',
                "X-Locale": storage.lang ?? "ar",
                "authorization": "Bearer ${token}",
              },
            )
        );
        print(response);
        return ListPointsResponse.fromJson(response.data);

    }catch(e){
      print(e.toString());
      return ListPointsResponse();
    }
  }

  Future<CouponResponse> createCoupon(String token,int id)async{
    try {
      var Url="/api/development/redeem_points/$id";
      //print(Url);
      print(options.baseUrl+Url);
      print(token.toString());
      dio1.Response response = await dio.post(Url,
          options: dio1.Options(
            headers: {
              'x-api-key': '1234321',
              "X-Locale": storage.lang ?? "ar",
              "authorization": "Bearer ${token}",
            },
          )
      );
      print(response);
      return CouponResponse.fromJson(response.data);

    }catch(e){
      print(e.toString());
      return CouponResponse();
    }
  }

  Future<dynamic> addCommentWithImageAndVoice(String? itemID, String? itemName, String? courseId,
      String? commentImag, String? commentSound, String? comment)async{
    try {
      var Url="/api/development/panel/comments";
      print(Url);
      var formData =
      dio1.FormData.fromMap({
        'item_id': itemID,
        'item_name': itemName,
        'comment':comment,
      });
      if(commentImag!=null&&commentSound==null) {
        // //[4] ADD IMAGE TO UPLOAD
        var Imagefile = File(commentImag.toString());
        var file = await dio1.MultipartFile.fromFile(Imagefile.path,
            filename: basename(Imagefile.path));
        //contentType: MediaType("image", "title.png"));
        formData.files.add(MapEntry('image', file));
      }else if(commentImag==null&&commentSound!=null) {
        // //[4] ADD IMAGE TO UPLOAD
        var soundfile = File(commentSound.toString());
        var file = await dio1.MultipartFile.fromFile(soundfile.path,
            filename: basename(soundfile.path));
        //contentType: MediaType("image", "title.png"));
        formData.files.add(MapEntry('voice', file));
      }else if(commentImag!=null&&commentSound!=null) {
        // //[4] ADD IMAGE TO UPLOAD
        var soundfile = File(commentSound.toString());
        var file1 = await dio1.MultipartFile.fromFile(soundfile.path,
            filename: basename(soundfile.path));
        //contentType: MediaType("image", "title.png"));
        formData.files.add(MapEntry('voice', file1));
        //
        var Imagefile = File(commentImag.toString());
        var file2 = await dio1.MultipartFile.fromFile(Imagefile.path,
            filename: basename(Imagefile.path));
        //contentType: MediaType("image", "title.png"));
        formData.files.add(MapEntry('image', file2));
      }

      // if(commentSound!=null) {
      //   // //[4] ADD IMAGE TO UPLOAD
      //   var soundfile = File(commentSound.toString());
      //   var file = await dio1.MultipartFile.fromFile(soundfile.path,
      //       filename: basename(soundfile.path));
      //   //contentType: MediaType("image", "title.png"));
      //   formData.files.add(MapEntry('voice', file));
      // }
      print(options.baseUrl+Url+formData.files.toString());
      print(options.baseUrl+Url+formData.fields.toString());
      dio1.Response response = await dio.post(Url,data: formData,
          options: dio1.Options(
            headers: {
              'x-api-key': '1234321',
              "X-Locale": storage.lang ?? "ar",
              "authorization": "Bearer ${storage.apiToken}"
            },
          ));
      print(response);
      if(response.statusCode==200){
        print("klkl"+BaseResponse.fromJson(response.data).toString());
        return BaseResponse.fromJson(response.data);
      }else{
        print("klkl121"+response.statusMessage.toString());
        return BaseResponse();
      }
    }catch(e){
      print(e.toString());
      return BaseResponse();
    }
  }
}