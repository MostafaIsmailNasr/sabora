
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../app/config/app_text_styles.dart';
import '../button.dart';

//0 --> error  1-->success
Future<void> dialogSuccessErrorEnrollBuilder(
    BuildContext context, {int type=0}) {
  AppLocalizations local= AppLocalizations.of(context)!;
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
                  Lottie.network(
                    type==0?"https://assets1.lottiefiles.com/packages/lf20_0CD5wOHfFt.json":"https://assets5.lottiefiles.com/private_files/lf30_z1sghrbu.json",
                    width: 170,
                    height: 170,
                   // fit: BoxFit.fill,
                  ),
                  Text(
                      textAlign: TextAlign.center,
                      type==0?local.the_code_is_incorrect:local.subscription_completed_successfully,
                      style: AppTextStyles.title2.copyWith(fontSize: 18)),
                  const SizedBox(
                    height: 24,
                  ),
                  myButton(() {
                    Get.back();

                  }, type==0?local.try_again:local.back_to_the_course),
                ]),
          ));
    },
  );
}