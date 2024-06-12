import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../data/models/auth/User.dart';
import '../../../main.dart';
import '../../../presentation/controllers/auth/auth_binding.dart';
import '../../../presentation/controllers/home/home_controller.dart';
import '../../../presentation/pages/auth/login/login_screen.dart';
import '../../../presentation/pages/no_internet/no_internet.dart';
import '../../../presentation/widgets/custom_toast/custom_toast.dart';
import '../../config/app_colors.dart';
import '../../services/local_storage.dart';

abstract class BaseController extends GetxController {
  final store = Get.find<LocalStorageService>();
  var isLoggedIn = false.obs;
  var isLoading = false.obs;
  var isInternetAvailable = true.obs;
  RxBool isKeyboardVisible = false.obs;

  RxInt selectedIndex = 2.obs;
  static String? clickAction;
  static String? clickActionID;
  static final drawerController = ZoomDrawerController();
  late StreamSubscription<InternetConnectionStatus> connectionListener ;

  User? get user => store.user;

  void showToast(String msg,
      {int? duration, int? gravity, BuildContext? context,bool isSuccess=true}) {
    //if (context != null) ToastMContext().init(context);

    print(isSuccess);
    BuildContext currentContext = navigatorKey.currentState!.context;
    ToastMContext().init(currentContext);
    var _local = getLocale();
    Toast.show(msg,isSuccess?_local.done:_local.incorrect,
        duration: duration, gravity: gravity??Toast.bottom,border: Border.all(color: AppColors.gray4,width: 1),isSuccess:isSuccess);
  }

  AppLocalizations getLocale() {
    BuildContext currentContext = navigatorKey.currentState!.context;

    var _local = AppLocalizations.of(currentContext)!;
    return _local;
  }

  Future goOfflineScreen()async{
    BuildContext currentContext = navigatorKey.currentState!.context;

   return await Navigator.of(currentContext)
        .push(
      MaterialPageRoute(
          builder: (_) => NoInternetScreen()),
    );
  }

  toggleDrawer() {
    print("Toggle drawer");
    drawerController.toggle?.call();
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    isLoggedIn.value = store.userID != null;

    // // Check internet connection with singleton (no custom values allowed)
    // await execute(InternetConnectionChecker());
    //
    // // Create customized instance which can be registered via dependency injection
    // final InternetConnectionChecker customInstance =
    // InternetConnectionChecker.createInstance(
    //   checkTimeout: const Duration(seconds: 1),
    //   checkInterval: const Duration(seconds: 1),
    // );
    //
    // // Check internet connection with created instance
    // await execute(customInstance);
  }

  void loading() {
    EasyLoading.show(
        status: 'loading...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black);
  }

  void dismissLoading() async {
    await EasyLoading.dismiss();
  }

  void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  logout(BuildContext context) {
    store.user = null;
    isLoggedIn.value = false;
    store.apiToken = null;
    store.userID = null;
    selectedIndex.value = 2;
    isLoggedIn.refresh();

    Get.delete<HomeController>();
    AuthBinding().dependencies();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false);
    // Get.offAll(LoginScreen(), binding: AuthBinding());
  }

  Future<void> execute(
    InternetConnectionChecker internetConnectionChecker,
  ) async {
    // Simple check to see if we have Internet
    // ignore: avoid_print
    print('''The statement 'this machine is connected to the Internet' is: ''');
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    // ignore: avoid_print
    print(
      isConnected.toString(),
    );
    // returns a bool

    // We can also get an enum instead of a bool
    // ignore: avoid_print
    print(
      'Current status: ${await InternetConnectionChecker().connectionStatus}',
    );
    // Prints either InternetConnectionStatus.connected
    // or InternetConnectionStatus.disconnected

    // actively listen for status updates

    // connectionListener.
    // close listener after 30 seconds, so the program doesn't run forever
    // await Future<void>.delayed(const Duration(seconds: 30));
    //await listener.cancel();
  }
}
