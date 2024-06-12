import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../app/config/app_colors.dart';
import '../../../app/config/app_text_styles.dart';
import '../../../data/models/home/course_details/Course.dart';
import '../../../generated/assets.dart';
import '../../widgets/custom_toast/custom_toast.dart';
import '../../widgets/empty_widget/empty_widget.dart';
import '../../widgets/item_user_rate/user_rate_item.dart';
import '../../widgets/rate_bar/rate_bar.dart';

class CourseRate extends StatelessWidget {
  late AppLocalizations _local;
  List<dynamic> reviewsList;
  Course? course;
  CourseRate(this.reviewsList,this.course);

  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    _local = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child:reviewsList.isEmpty?buildEmptyWidget(context,SvgPicture.asset(Assets.imagesNoComments),
          _local.there_are_no_ratings,
          _local.there_is_no_reviews_for_this_track
      ): Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            (course?.rate??"").toString(),
            style: AppTextStyles.title
                .copyWith(color: AppColors.graydark, fontSize: 20),
          ),
          Container(
            width: 100,
            margin: const EdgeInsets.only(bottom: 10),
            child: StarRating(
              rating: double.parse((course?.rate??"0").toString()),
              onRatingChanged: (rating) =>
                  {} /* setState(() => this.rating = rating)*/,
              color: AppColors.yello,
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6), color: AppColors.gray4),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
              child: Text(
                reviewsList.length.toString()+" " + _local.rating,
                style: AppTextStyles.title2
                    .copyWith(color: AppColors.gray, fontSize: 12),
              ),
            ),
          ),

          buildSeekRate(_local.content_quality, (course?.rateType?.contentQuality??"").toString()),
          buildSeekRate(_local.teacher_skills, (course?.rateType?.instructorSkills??"").toString()),
          buildSeekRate(_local.purchase_value,(course?.rateType?.purchaseWorth??"").toString()),
          buildSeekRate(_local.technical_support_quality, (course?.rateType?.supportQuality??"").toString()),
          const SizedBox(height: 20,),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              physics:const ScrollPhysics() ,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount:reviewsList.length,
              itemBuilder: (context, position) {
                return buildUserCommentItem(reviewsList[position],isReview: true);
              },
            ),
          )
        ],
      ),
    );
  }

  buildSeekRate(String title, String rate) {
    return Container(
      margin: EdgeInsets.only(left: 20,right: 20,top: 10),
      child: Row(
        children: [
          Text(title,
              style: AppTextStyles.title2.copyWith(color: AppColors.gray2)),
          Expanded(
            child: Container(
                child: LinearPercentIndicator(
              //width: 100.0,
              barRadius: Radius.circular(20),
              lineHeight: 8.0,
              percent: (double.parse(rate)*5)/100,
              progressColor: AppColors.yello,
            )),
          )
        ],
      ),
    );
  }
}
