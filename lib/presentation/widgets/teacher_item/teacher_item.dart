import '../../../app/config/app_colors.dart';
import '../../../app/config/app_text_styles.dart';
import '../../../data/models/teachers/Teachers.dart';
import '../../../generated/assets.dart';
import '../../controllers/teachers/teachers_binding.dart';
import '../../pages/main/teachers/teacher_details/teacher_details.dart';
import '../rate_bar/rate_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

buildTeacherItem(Teachers teachers) {
  return GestureDetector(
    onTap: ()=>{
      //Get.to(TeacherDetailsScreen(teachers.id.toString()))
    Get.to(TeacherDetailsScreen(teachers!.id.toString()),binding:
    TeachersBinding())
    },
    child: Card(
      margin: EdgeInsets.symmetric(horizontal: 5,),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: Image.network(
                height: 68,
                width: 68,
                teachers.avatar??"",
                fit: BoxFit.fill,
                loadingBuilder: (context, child, loadingProgress) =>
                    (loadingProgress == null)
                        ? child
                        : Center(child: CircularProgressIndicator()),
                errorBuilder: (context, error, stackTrace) =>
                    Center(child: Container(
                        height: 68,
                        width: 68,
                        child: Image(image: AssetImage('assets/images/edu_gate_logo2.png'),))),
              )),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            teachers.fullName??"",
            style: AppTextStyles.title.copyWith(color: AppColors.gray),
            maxLines: 1,
          ),
        ),
        Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: Text(
              teachers.roleName??"",
              style: AppTextStyles.title2
                  .copyWith(fontSize: 12, color: AppColors.gray2),
            )),
        Center(
          child: Container(
            width: 100,
            child: StarRating(
              rating: double.parse((teachers.rate??0).toString()),
              onRatingChanged: (rating) =>
                  {} /* setState(() => this.rating = rating)*/,
              color: AppColors.yello,
            ),
          ),
        ),
        // SizedBox(height: 20,)
      ]),
    ),
  );
}
