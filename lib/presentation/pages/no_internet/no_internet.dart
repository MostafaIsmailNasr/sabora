import '../../../app/config/app_colors.dart';
import '../../../app/config/app_text_styles.dart';
import '../../../generated/assets.dart';
import '../../widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import '../../widgets/custom_toast/custom_toast.dart';

import '../../controllers/network/GetXNetworkManager.dart';

class NoInternetScreen extends StatelessWidget {
  late AppLocalizations _local;
  final GetXNetworkManager _networkManager = Get.find<GetXNetworkManager>();

  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    _local = AppLocalizations.of(context)!;

    return  WillPopScope(
        onWillPop: () async {
          if(_networkManager.connectionType!=0) {
            _networkManager.isNoInternetScreenOpen=false;
            return true;
          }else{
            return false;
          }
    },
    child:SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.imagesNoInternet),
            Text(
              _local.problem_in_the_internet,
              style: AppTextStyles.title.copyWith(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Text(
              _local.please_check_your_internet_connection_and_try_again,
              style: AppTextStyles.title2
                  .copyWith(fontSize: 16, color: AppColors.gray),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: myButton(() {
                if(_networkManager.connectionType!=0) {
                 _networkManager.isNoInternetScreenOpen=false;
                  Navigator.pop(context, true);
                }
              }, _local.try_again),
            )
          ],
        ),
      ),
    ));
  }
}
