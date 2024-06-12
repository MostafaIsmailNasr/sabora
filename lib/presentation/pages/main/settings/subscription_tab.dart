import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../app/config/app_text_styles.dart';
import '../../../../generated/assets.dart';
import '../../../controllers/auth/register_controller.dart';
import '../../../widgets/button.dart';
import '../../../widgets/custom_toast/custom_toast.dart';

class SubscriptionTab extends GetView<RegisterController> {
  late AppLocalizations _local;

  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    _local = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Form(
        child: Container(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        child: myButton(() {}, _local.camera,
                            prefixIcon: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: SvgPicture.asset(Assets.imagesCamerasmall))),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: myButton(() {}, _local.upload,
                        prefixIcon: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: SvgPicture.asset(Assets.imagesGallarysmall))),
                      ),
                    )
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(left: 10,right: 10,top: 15),
                    child: Text(_local.certificates_documents,style: AppTextStyles.title2,)),
                Container(
                  child: myButton(() {}, _local.upload,
                      prefixIcon: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: SvgPicture.asset(Assets.imagesGallarysmall))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
