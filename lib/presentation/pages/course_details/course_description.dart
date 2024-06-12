import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/config/app_colors.dart';
import '../../../app/config/app_text_styles.dart';
import '../../../app/util/util.dart';
import '../../../data/models/home/course_details/Course.dart';
import '../../../generated/assets.dart';
import '../../widgets/custom_toast/custom_toast.dart';

class CourseDescription extends StatelessWidget {
  late AppLocalizations _local;
  Course? course;
  CourseDescription(this.course);

  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    _local = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(width: 50,),
              // Expanded(
              //   child: Row(children: [
              //     SvgPicture.asset(Assets.imagesStudents),
              //     SizedBox(width: 15,),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           _local.the_students,
              //           style: AppTextStyles.title2.copyWith(color: AppColors.gray),
              //         ),
              //         Text(
              //           (course?.studentsCount??"").toString(),
              //           style: AppTextStyles.title
              //               .copyWith(fontSize: 14, color: AppColors.graydark),
              //         )
              //       ],
              //     )
              //   ],),
              // ),
              Expanded(
                child: Row(children: [
                  SvgPicture.asset(Assets.imagesChapters),
                  const SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _local.parts,
                        style: AppTextStyles.title2.copyWith(color: AppColors.gray),
                      ),
                      Text(
                        (course?.chaptersCount??"").toString(),
                        style: AppTextStyles.title
                            .copyWith(fontSize: 14, color: AppColors.graydark),
                      )
                    ],
                  )
                ],),
              )
            ],
          ),
          const SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(width: 50,),
              Expanded(
                child: Row(children: [
                  SvgPicture.asset(Assets.imagesCalender),
                  const SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _local.publish_date,
                        style: AppTextStyles.title2.copyWith(color: AppColors.gray),
                      ),
                      Text(
                        Utils.getFormatedDate(course?.createdAt??0),
                        style: AppTextStyles.title
                            .copyWith(fontSize: 14, color: AppColors.graydark),
                      )
                    ],
                  )
                ],),
              ),
              Expanded(
                child: Row(children: [
                  SvgPicture.asset(Assets.imagesClock2),
                  const SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _local.duration,
                        style: AppTextStyles.title2.copyWith(color: AppColors.gray),
                      ),
                      Text(
                    (course?.duration??"").toString(),
                        style: AppTextStyles.title
                            .copyWith(fontSize: 14, color: AppColors.graydark),
                      )
                    ],
                  )
                ],),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25,vertical: 20),
            child:Html(data:course?.description??"") /*Text(
              course?.description??"",
              style: AppTextStyles.title2.copyWith(color: AppColors.gray),
            )*/,
          )
        ],
      ),
    );
  }
}

