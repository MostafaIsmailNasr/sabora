import 'package:flutter/material.dart';

import 'app_colors.dart';

/// AppTextStyle format as follows:
/// [fontWeight][fontSize][colorName][opacity]
/// Example: bold18White05
///
class AppTextStyles {
  static TextStyle title = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w700,
    fontSize: 16,
    fontFamily: "Cairo",
  );

  static TextStyle title2 =  TextStyle(
    color: AppColors.graydark,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    fontFamily: "Cairo",
  );

  static TextStyle title3 =  TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    fontFamily: "Cairo",
  );

  static TextStyle titleToolbar =  TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w600,
    fontSize: 18,
    fontFamily: "Cairo",
  );


  static TextStyle body = const TextStyle(
    fontSize: 12,
    color: Colors.grey,
    fontWeight: FontWeight.w400,
    fontFamily: "Cairo",

  );

  static TextStyle splashTextStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 32,
      fontFamily: "Cairo");

  static TextStyle authTitleStyle = TextStyle(
      color: AppColors.primary,
      fontWeight: FontWeight.w700,
      fontSize: 24,
      fontFamily: "Cairo");

  static TextStyle drawerMenu =  TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    fontFamily: "Cairo",
  );

}
