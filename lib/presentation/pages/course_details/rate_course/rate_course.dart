import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../app/config/app_colors.dart';
import '../../../../app/config/app_text_styles.dart';
import '../../../../generated/assets.dart';
import '../../../widgets/button.dart';
import '../../../widgets/rate_bar/rate_bar.dart';
import '../../../widgets/textInput.dart';

typedef RateCallback = void Function(dynamic);

typedef SendRateCallback = void Function(
    dynamic, dynamic, dynamic, dynamic, dynamic);

showRateBottomSheet(BuildContext context,SendRateCallback sendRateCallback) {
  // when raised button is pressed
  // we display showModalBottomSheet
  // "description":"review1",
  // "content_quality":2,
  // "instructor_skills":3,
  // "purchase_worth":4,
  // "support_quality":6
  TextEditingController textEditingController = TextEditingController();
  String? rateComment = "";
  double contentQuality = 0;
  double instructorSkills = 0;
  double purchaseWorth = 0;
  double supportQuality = 0;
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
      builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext context, setState) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: InkWell(
                                  onTap: ()=>{
                                    Get.back()
                                  },
                                  child:  SvgPicture.asset(
                                Assets.imagesClose2,
                                color: Colors.black,
                              )))
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          _local.comment_on_the_track,
                          style: AppTextStyles.titleToolbar
                              .copyWith(fontSize: 16, color: AppColors.graydark),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _buildRateRow(_local.content_quality, contentQuality, (rate) {
                        setState(() => {contentQuality = rate});
                      }),
                      _buildRateRow(_local.teacher_skills, instructorSkills,
                          (rate) {
                        setState(() => {instructorSkills = rate});
                      }),
                      _buildRateRow(_local.purchase_value, purchaseWorth, (rate) {
                        setState(() => {purchaseWorth = rate});
                      }),
                      _buildRateRow(
                          _local.technical_support_quality, supportQuality, (rate) {
                        setState(() => {supportQuality = rate});
                      }),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                        child: MyTextFieldForm(
                          textEditingController: textEditingController,
                          minLines: 3,
                          maxLines: 4,
                          fillColor: AppColors.gray4,
                          hint: _local.message_text2,
                            validator: (dynamic value) {
                              if (value == null) {
                                return _local.please_add_comment; //_local.please_enter_coupon;
                              }
                              return (!value!.isNotEmpty)
                                  ? _local.please_add_comment // _local.please_enter_coupon
                                  : null;
                            }
                          // textEditingController: controller,
                          /*validator: validator*/
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        child: myButton(() {
  if (_formKey.currentState!.validate()) {
    Get.back();
    sendRateCallback(
        textEditingController.text, contentQuality, instructorSkills,
        purchaseWorth, supportQuality);
  }
                        }, _local.submit_comment),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ));
}

_buildRateRow(String title, double rate, RateCallback rateCallback) {
  return Container(
    margin: EdgeInsets.only(left: 20, right: 20, top: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(title,
              style: AppTextStyles.title2.copyWith(color: AppColors.gray2)),
        ),
        StarRating(
          starSize: 30,
          rating: rate,
          onRatingChanged: (rating) =>
              {rateCallback(rating)} /* setState(() => this.rating = rating)*/,
          color: AppColors.yello,
        )
      ],
    ),
  );
}
