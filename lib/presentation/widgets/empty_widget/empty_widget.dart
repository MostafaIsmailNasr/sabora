import 'package:flutter/cupertino.dart';

import '../../../app/config/app_colors.dart';
import '../../../app/config/app_text_styles.dart';

buildEmptyWidget(BuildContext context,Widget imageWidget,String title,String description ){
  return SingleChildScrollView(
    physics: ScrollPhysics(),
    child: Center(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*0.15,),
          imageWidget,
          Text(title,style: AppTextStyles.title.copyWith(
              fontSize: 20
          ),textAlign: TextAlign.center,),
          Text(description,style: AppTextStyles.title2.copyWith(
              fontSize: 16
              ,
              color: AppColors.gray
          ),textAlign: TextAlign.center,)

        ],
      ),
    ),
  );
}