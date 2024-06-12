import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/config/app_colors.dart';
import '../../../../app/config/app_text_styles.dart';
import '../../../../app/util/util.dart';
import '../../../../data/models/home/course_details/Course.dart';
import '../../../../generated/assets.dart';
import '../../../controllers/course_details/course_details_controller.dart';
import '../../../widgets/button.dart';
import '../../../widgets/rate_bar/rate_bar.dart';
import '../../../widgets/textInput.dart';

showEnrollBottomSheet(BuildContext context, Course courseToBeEnrolled,
    CourseDetailsController courseDetailsController) {
  // when raised button is pressed
  // we display showModalBottomSheet
  courseDetailsController.couponTextController.clear();
  final _formKey = GlobalKey<FormState>();
  var _local = AppLocalizations.of(context)!;
  showModalBottomSheet<void>(
    isScrollControlled: true,
    // context and builder are
    // required properties in this widget
    context: context,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25))),
    builder: (BuildContext context) => Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 5,
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.gray5),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Container(
                    height: 100,
                    width: 146,
                    margin: EdgeInsets.all(20),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.network(
                          height: 116,
                          "${courseToBeEnrolled.image}",
                          fit: BoxFit.fill,
                          loadingBuilder: (context, child, loadingProgress) =>
                              (loadingProgress == null)
                                  ? child
                                  : Center(child: CircularProgressIndicator()),
                          errorBuilder: (context, error, stackTrace) => Center(
                              child: Image(image: AssetImage('assets/images/edu_gate_logo2.png'))),
                        )),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                            "${courseToBeEnrolled.title}",
                            style: AppTextStyles.title2
                                .copyWith(color: Colors.black),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            StarRating(
                              rating: double.parse(
                                  courseToBeEnrolled.rate.toString()),
                              onRatingChanged: (rating) =>
                                  {} /* setState(() => this.rating = rating)*/,
                              color: AppColors.yello,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                "${courseToBeEnrolled.price} جنيه",
                                style: AppTextStyles.titleToolbar
                                    .copyWith(color: AppColors.red),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(Assets.imagesIcCalendar,color: AppColors.primary,),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                Utils.getFormatedDate(
                                    courseToBeEnrolled.createdAt!.toInt()),
                                style: AppTextStyles.body
                                    .copyWith(color: AppColors.primary),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.all(20),
                height: 1,
                color: AppColors.gray4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _local.please_enter_the_subscription_code,
                    style: AppTextStyles.titleToolbar
                        .copyWith(color: AppColors.graydark, fontSize: 16),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SvgPicture.asset(Assets.imagesVisa,color: AppColors.primary)
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: MyTextFieldForm(
                  fillColor: AppColors.gray4,
                  assetNamePrefex: Assets.imagesVisa2,
                  hint: _local.please_enter_the_subscription_code,
                  textEditingController: courseDetailsController
                      .couponTextController,
                        validator:
                        (dynamic value) {
                      if (value == null) {
                        return _local.please_enter_coupon;
                      }
                      return (!value!.isNotEmpty)
                          ? _local.please_enter_coupon
                          : null;
                    }
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: myButton(() {
                  if (_formKey.currentState!.validate()) {
                    courseDetailsController.loading();
                    courseDetailsController.validateCourseCoupon();
                  }
                }, _local.accept),
              ),
              //  SizedBox(height: 40,)
            ],
          ),
        ),
      ),
    ),
  );
}
