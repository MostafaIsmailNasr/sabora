import 'dart:async';

import 'package:connectivity/connectivity.dart';
import '../../../app/base/base_controller/BaseController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../main.dart';

class GetXNetworkManager extends BaseController
{
  //this variable 0 = No Internet, 1 = connected to WIFI ,2 = connected to Mobile Data.
  int connectionType = 0;
  bool isNoInternetScreenOpen = false;

  //Instance of Flutter Connectivity
  final Connectivity _connectivity = Connectivity();

  //Stream to keep listening to network change state
  late final StreamSubscription _streamSubscription ;

  @override
  void onInit() {
    super.onInit();
    GetConnectionType(null);
    _streamSubscription = _connectivity.onConnectivityChanged.listen(GetConnectionType);
  }

  // a method to get which connection result, if you we connected to internet or no if yes then which network
  Future<void>GetConnectionType(ConnectivityResult? result) async{
    var connectivityResult;
    try{
      connectivityResult = await (_connectivity.checkConnectivity());
    }on PlatformException catch(e){
      print(e);
    }
    return _updateState(connectivityResult);
  }

  // state update, of network, if you are connected to WIFI connectionType will get set to 1,
  // and update the state to the consumer of that variable.
  _updateState(ConnectivityResult result)
  {
    switch(result)
    {
      case ConnectivityResult.wifi:
        connectionType=1;
        if(isNoInternetScreenOpen){
          isNoInternetScreenOpen=false;
          BuildContext currentContext = navigatorKey.currentState!.context;
          Navigator.pop(currentContext,true);
        }
        update();
        break;
      case ConnectivityResult.mobile:
        connectionType=2;
        if(isNoInternetScreenOpen){
          isNoInternetScreenOpen=false;
          BuildContext currentContext = navigatorKey.currentState!.context;
          Navigator.pop(currentContext,true);
        }
        update();
        break;
      case ConnectivityResult.none:
        connectionType=0;
        if(!isNoInternetScreenOpen){
          isNoInternetScreenOpen=true;
        goOfflineScreen().then((value) => {
          value??false ? {

          }:null
        });
        }
        update();
        break;
      default: Get.snackbar('Network Error', 'Failed to get Network Status');
      break;

    }
    print("connectionType==>${connectionType}");
  }

  @override
  void onClose() {
    //stop listening to network state when app is closed
    _streamSubscription.cancel();
  }
}
