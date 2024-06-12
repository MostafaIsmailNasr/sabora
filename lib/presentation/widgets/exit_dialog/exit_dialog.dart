import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../app/config/app_colors.dart';
import '../../../app/config/app_text_styles.dart';
import '../button.dart';

Future<void> dialogExitBuilder(BuildContext context, AppLocalizations local,
    String title, VoidCallback? onApplyPressed) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          // title: const Text('Basic dialog title'),
          insetPadding: EdgeInsets.symmetric(horizontal: 15),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24))),
          content: Container(
            width: MediaQuery.of(context).size.width * 1.9,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                      textAlign: TextAlign.center,
                      title,
                      style: AppTextStyles.title2.copyWith(fontSize: 18)),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: myButton(onApplyPressed, local.yes),
                        ),
                        Expanded(
                          child: myButton(() {
                            Get.back();
                          }, local.no, fillColor: AppColors.red),
                        )
                      ]),
                ]),
          ));
    },
  );
}
