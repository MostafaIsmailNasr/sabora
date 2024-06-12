import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../app/config/app_text_styles.dart';
import '../../generated/assets.dart';
import '../controllers/auth/auth_binding.dart';
import '../pages/auth/login/login_screen.dart';
import 'button.dart';

Future<void> dialogSuccessPassResetBuilder(
    BuildContext context, AppLocalizations local) {
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
                  SvgPicture.asset(Assets.imagesSuccessRestPass),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                      textAlign: TextAlign.center,
                      local.password_changed_successfully,
                      style: AppTextStyles.title2.copyWith(fontSize: 18)),
                  const SizedBox(
                    height: 24,
                  ),
                  myButton(() {
                    Get.back();
                    Get.offAll(LoginScreen(),binding: AuthBinding());
                  }, local.login),
                ]),
          ));
    },
  );
}

// Future<void> dialogSuccessPassResetBuilder(BuildContext context) {
//   return showDialog<void>(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text('Basic dialog title'),
//         content: const Text('A dialog is a type of modal window that\n'
//             'appears in front of app content to\n'
//             'provide critical information, or prompt\n'
//             'for a decision to be made.'),
//         actions: <Widget>[
//           TextButton(
//             style: TextButton.styleFrom(
//               textStyle: Theme.of(context).textTheme.labelLarge,
//             ),
//             child: const Text('Disable'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           TextButton(
//             style: TextButton.styleFrom(
//               textStyle: Theme.of(context).textTheme.labelLarge,
//             ),
//             child: const Text('Enable'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
