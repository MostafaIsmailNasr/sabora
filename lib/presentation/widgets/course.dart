import 'package:Sabora/app/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/config/app_text_styles.dart';
import '../../data/models/home/course_details/Course.dart';
import '../../generated/assets.dart';

Widget getCourseItem(BuildContext context, Course course,
    {GestureTapCallback? callback}) {
 // ScreenUtil.init(context, designSize: const Size(360, 690));
  AppLocalizations _local = AppLocalizations.of(context)!;
  return InkWell(
    onTap: callback,
    child: Container(
      width:( MediaQuery.of(context).size.width * 0.44),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.down,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 116,
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                        child: Center(
                          child: Image.network(
                            height: 116,
                            course?.image??"",
                            fit: BoxFit.fill,
                            loadingBuilder: (context, child, loadingProgress) =>
                                (loadingProgress == null)
                                    ? child
                                    : const Center(child: CircularProgressIndicator()),
                            errorBuilder: (context, error, stackTrace) =>
                                Center(child: Image(image: AssetImage('assets/images/edu_gate_logo2.png'),)),
                          ),
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10,),
                    child: Text(
                      "${course.title}",
                      style: AppTextStyles.title2.copyWith(color: Colors.black),
                      maxLines: 1,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(Assets.imagesUser,color: AppColors.secoundry,),
                      const SizedBox(width: 5,),
                      Expanded(
                        child: Text(
                          "${course.teacher?.fullName}",
                          style: AppTextStyles.body,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 5,),
                      SvgPicture.asset(Assets.imagesDollarSquare,color: AppColors.secoundry),
                      const SizedBox(width: 5,),
                      Expanded(
                        child: Text(
                          course.price == 0
                              ? _local.free
                              : "${course.price} ${_local.egp}",
                          style: AppTextStyles.body,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,)
                ],
              ),
            ),
          ),
          Container(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              margin: EdgeInsets.all(10),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15,vertical: 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("${course.rate}",style: AppTextStyles.title2.copyWith(
                      color: Colors.black
                    ),),
                    const SizedBox(
                      width: 5,
                    ),
                    SvgPicture.asset(Assets.imagesStarYello)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
