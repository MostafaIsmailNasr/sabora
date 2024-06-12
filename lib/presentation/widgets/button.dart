
import 'package:flutter/material.dart';

import '../../app/config/app_colors.dart';
import '../../app/config/app_text_styles.dart';

Widget myButton(VoidCallback? onPressed, String text, {Widget? prefixIcon,bool isFilled = true,Color? fillColor}) {
  return Container(
    margin: EdgeInsets.all(5),
    child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: isFilled ? fillColor??AppColors.primary : Colors.white,
          padding: const EdgeInsets.all(16.0),
          side: BorderSide(color: AppColors.primary, width: isFilled ? 0 : 1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: onPressed,
        child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          prefixIcon??Container(),
            Text(text,
            style: AppTextStyles.title.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: isFilled ? Colors.white : AppColors.primary))
  ])),
  );
}
