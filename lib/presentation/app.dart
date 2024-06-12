//import 'package:screenshot_callback/screenshot_callback.dart';
import 'package:Sabora/presentation/widgets/custom_toast/custom_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../app/config/app_colors.dart';
import '../app/services/local_storage.dart';
import '../main.dart';
import 'controllers/splash/splash_binding.dart';
import 'pages/splash/splash_screen.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    final store = Get.find<LocalStorageService>();
   var  locale = store.lang == "ar" ? Locale('ar', '') : Locale('en', '');
        return GetCupertinoApp(
          navigatorKey: navigatorKey,
          initialRoute: "/",
          initialBinding: SplashBinding(),
          debugShowCheckedModeBanner: false,
          // localizationsDelegates: const [
          //   AppLocalizations.delegate, // Add this line
          //   GlobalMaterialLocalizations.delegate,
          //   GlobalWidgetsLocalizations.delegate,
          //   GlobalCupertinoLocalizations.delegate,
          // ],
          builder: EasyLoading.init(),
          // supportedLocales: const [
          //   Locale('en'), // English
          //   Locale('es'), // Spanish
          // ],
          localizationsDelegates:
          AppLocalizations.localizationsDelegates, // important
          supportedLocales: AppLocalizations.supportedLocales, //
          locale: locale,
          theme: CupertinoThemeData(
            // Define the default brightness and colors.
            brightness: Brightness.dark,
            primaryColor: AppColors.primary,
            barBackgroundColor: AppColors.primary,
            primaryContrastingColor: AppColors.primary,
            // Define the default `TextTheme`. Use this to specify the default
            // text styling for headlines, titles, bodies of text, and more.
            textTheme: CupertinoTextThemeData(
              primaryColor: AppColors.primary,
            ),
          ),
          home: SplashScreen(),
        );

  }
}




