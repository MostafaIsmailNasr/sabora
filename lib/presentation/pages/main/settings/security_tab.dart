import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../../generated/assets.dart';
import '../../../controllers/auth/register_controller.dart';
import '../../../widgets/custom_toast/custom_toast.dart';
import '../../auth/login/login_screen.dart';

class SecurityTab extends GetView<RegisterController> {
  late AppLocalizations _local;

  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    _local = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Form(
        child: Container(
          margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 60),
          child: Column(
            children: [

              getRowInput(
                  _local.current_password,
                  "************",
                  assetPrefex: Assets.assetsImagesPass,
                  isPass: true,
                  controller.currentPassController, (dynamic value) {
                if (value == null) {
                  return _local.password_is_required;
                }
                return (!value!.isNotEmpty)
                    ? _local.password_is_required
                    : null;
              }),
              SizedBox(height: 10,),
              getRowInput(
                  _local.new_password,
                  "************",
                  assetPrefex: Assets.assetsImagesPass,
                  isPass: true,
                  controller.newPassController, (dynamic value) {
                if (value == null) {
                  return _local.password_is_required;
                }
                return (!value!.isNotEmpty)
                    ? _local.password_is_required
                    : null;
              }),
              SizedBox(height: 10,),
              getRowInput(
                  _local.retype_the_new_password,
                  "************",
                  assetPrefex: Assets.assetsImagesPass,
                  isPass: true,
                  controller.newPassConfirmController, (dynamic value) {
                if (value == null) {
                  return _local.password_is_required;
                }
                return (!value!.isNotEmpty)
                    ? _local.password_is_required
                    : null;
              })
            ],
          ),
        ),
      ),
    );
  }
}
