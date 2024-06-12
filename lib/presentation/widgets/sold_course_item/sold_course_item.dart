import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/config/app_colors.dart';
import '../../../app/config/app_text_styles.dart';
import '../../../data/models/home/course_details/Course.dart';
import '../../../generated/assets.dart';
import '../../controllers/course_details/course_details_binding.dart';
import '../../pages/course_details/course_details.dart';
import '../rate_bar/rate_bar.dart';

Widget getSoldCourseItem(AppLocalizations _local,Course course,{bool isSolid=true}) {
  return InkWell(
    onTap: ()=>{
      Get.to(CourseDetailsScreen(course.id.toString()),binding: CourseDetailsBinding())
    },
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 70,
                width: 100,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      height: 70,
                      width: 100,
                      course.image ??
                      "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
                      fit: BoxFit.fill,
                      loadingBuilder: (context, child, loadingProgress) =>
                          (loadingProgress == null)
                              ? child
                              : const Center(child: CircularProgressIndicator()),
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(child: Image(image: AssetImage('assets/images/edu_gate_logo2.png'),)),
                    )),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                       // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10,),
                          Text(
                            course.title??"",
                            style: AppTextStyles.title.copyWith(fontSize: 14),
                          ),
                          isSolid?StarRating(
                            rating: double.parse(course.rate??"0"),
                            onRatingChanged: (rating) =>
                                {} /* setState(() => this.rating = rating)*/,
                            color: AppColors.yello,
                          ):Wrap(
                            children: [ Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                             SvgPicture.asset(  isSolid? Assets.imagesClock:Assets.imagesUser,color:AppColors.secoundry),
                             Expanded(
                               child: Text(
                                  course.teacher?.fullName??"",
                                  //maxLines: 2,
                                  style: AppTextStyles.title2
                                      .copyWith(color: AppColors.gray2,fontSize: 13),
                                ),
                             ),

                            ],),
                            StarRating(
                            rating: double.parse(course.teacher?.rate??"0"),
                            onRatingChanged: (rating) =>
                            {} /* setState(() => this.rating = rating)*/,
                            color: AppColors.yello,
                            ),]
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(  isSolid? Assets.imagesClock:Assets.imagesCalendar2,color:AppColors.secoundry),
                              Text(
                                "${course.duration??"-"} hours",
                                style: AppTextStyles.title2
                                    .copyWith(color: AppColors.gray2, fontSize: 13),
                              ),
                              const Spacer(),
                              Container(
                                alignment: Alignment.bottomCenter,
                                margin: const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  course.price == 0
                                      ? _local.free
                                      : "${course.price} ${_local.egp}",
                                  style: AppTextStyles.title2
                                      .copyWith(color: AppColors.primary, fontSize: 13),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          isSolid? Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      child: Text(
                        _local.categories,
                        style: AppTextStyles.title2
                            .copyWith(color: AppColors.gray2, fontSize: 13),
                      ),
                    ),
                    Container(
                      child: Text(
                        course.category??"",
                        style: AppTextStyles.title2
                            .copyWith(color: AppColors.gray2, fontSize: 13),
                      ),
                    )
                  ],
                ),
                // Expanded(
                //   child: Column(
                //     children: [
                //       Container(
                //         child: Text(
                //           _local.number,
                //           style: AppTextStyles.title2
                //               .copyWith(color: AppColors.gray2, fontSize: 13),
                //         ),
                //       ),
                //       Container(
                //         child: Text(
                //           "1",
                //           style: AppTextStyles.title2
                //               .copyWith(color: AppColors.gray2, fontSize: 13),
                //         ),
                //       )
                //     ],
                //   ),
                // )
              ],
            ),
          ):Container(),
          isSolid? Container(
            margin: const EdgeInsets.all(20),
            height: 10,
            decoration: BoxDecoration(
              color: AppColors.gray3,
              border: Border.all(width: 1, color: AppColors.gray4),
              borderRadius: BorderRadius.circular(20),
              // border: BorderSide(
              //
              // )
            ),
          ):Container(height: 20,)
        ],
      ),
    ),
  );
}
