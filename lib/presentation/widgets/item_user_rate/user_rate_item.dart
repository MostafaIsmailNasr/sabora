import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/config/app_colors.dart';
import '../../../app/config/app_text_styles.dart';
import '../../../app/util/util.dart';
import '../../../generated/assets.dart';
import '../rate_bar/rate_bar.dart';
import '../soundPlayer/CustomSoundPlayerWidget.dart';

buildUserRateItem(){
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10)
    ),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      ListTile(
        minVerticalPadding: 10,
        leading: Container(
          margin: const EdgeInsets.only(top: 10),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: Image.network(
                height: 60,
                width: 60,
                "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
                fit: BoxFit.fill,
                loadingBuilder: (context, child, loadingProgress) =>
                (loadingProgress == null)
                    ? child
                    : const Center(child: CircularProgressIndicator()),
                errorBuilder: (context, error, stackTrace) =>
                    Center(child: SvgPicture.asset(Assets.assetsImagesEClassesLogoMain)),
              )),
        ),
        title: Text(
          "the king",
          style: AppTextStyles.title.copyWith(color: AppColors.gray),
        ),
        subtitle: StarRating(
          rating: 4.2,
          onRatingChanged: (rating) =>
          {} /* setState(() => this.rating = rating)*/,
          color: AppColors.yello,
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          "Very good",
          style: AppTextStyles.title2.copyWith(color: AppColors.gray),
        ),
      ),
    Container(
        margin: EdgeInsets.only(left: 20,right: 20,bottom: 10),
        child: Text(
        "14 ديسمبر 2022",
        style: AppTextStyles.title2.copyWith(
            fontSize: 12,
            color: AppColors.gray2),
      ))
    ]),
  );
}

buildUserCommentItem(question, {bool isReview=false}){
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 5),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
    ),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            minVerticalPadding: 10,
            leading: Container(
              width: 40,
              margin: const EdgeInsets.only(top: 10),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Image.network(
                    height: 32,
                    width: 32,
                    (question.user.avatar??"").toString(),
                    fit: BoxFit.fill,
                    loadingBuilder: (context, child, loadingProgress) =>
                    (loadingProgress == null)
                        ? child
                        : const Center(child: CircularProgressIndicator()),
                    errorBuilder: (context, error, stackTrace) =>
                        const Center(child: Image(image: AssetImage('assets/images/edu_gate_logo2.png'))),
                  )),
            ),
            title: Text(
              question.user.fullName??"",
              style: AppTextStyles.title.copyWith(color: AppColors.gray),
            ),
            subtitle: StarRating(
              rating:double.parse((isReview?(question.rate??"0"):question.user.rate??"0").toString()),
              onRatingChanged: (rating) =>
              {} /* setState(() => this.rating = rating)*/,
              color: AppColors.yello,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      isReview?(question.description??""):question.comment??"",
                      style: AppTextStyles.title2.copyWith(color: AppColors.gray),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
                      child: Text(
                        Utils.getFormatedDate(question.createAt??0),
                        style: AppTextStyles.title2.copyWith(
                            fontSize: 12,
                            color: AppColors.gray2),
                      )),
                ],),
              ),
              question?.image == null
                  ? Container()
                  : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    //width: MediaQuery.of(context).size.width,
                    //width: 100,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          height: 50,
                          width: 50,
                          (question.image??
                              "").toString() /*"https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"*/,
                          fit: BoxFit.fill,
                          loadingBuilder: (context, child, loadingProgress) =>
                          (loadingProgress == null)
                              ? child
                              : Container(
                              width: 50,
                              height: 50,
                              child: const Center(child: CircularProgressIndicator())),
                          errorBuilder: (context, error, stackTrace) => Center(
                              child: Container(
                                  width: 50,
                                  height: 50,
                                  child:SvgPicture.asset(Assets.assetsImagesEClassesLogoMain))),
                        )),
                  )),
            ],
          ),
          question.voice==null?Container():  Padding(
            padding: EdgeInsetsDirectional.only(start: 20,bottom: 15),
            child: VoiceMessageV2(
              audioSrc: question.voice??""/*'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3'*/,
              played: false, // To show played badge or not.
              me: true, // Set message side.
              onPlay: () {}, // Do something when voice played.
            ),
          ),

          ListView.builder(
            physics:ScrollPhysics() ,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount:question.replies.length,
            itemBuilder: (context, position) {
              return buildUserReplyItem((question.replies as List)[position]);
            },
          )
        ]),
  );
}


buildUserReplyItem(reply){
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
    ),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            minLeadingWidth: 40,
            minVerticalPadding: 10,
            leading: Container(
              width: 40,
              margin: EdgeInsets.only(top: 10),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Image.network(
                    height: 32,
                    width: 32,
                     ( reply.user.avatar??"").toString(),
                    fit: BoxFit.fill,
                    loadingBuilder: (context, child, loadingProgress) =>
                    (loadingProgress == null)
                        ? child
                        : Center(child: CircularProgressIndicator()),
                    errorBuilder: (context, error, stackTrace) =>
                        Center(child: SvgPicture.asset(Assets.assetsImagesEClassesLogoMain)),
                  )),
            ),
            title: Text(
              reply.user.fullName??"",
              style: AppTextStyles.title.copyWith(color: AppColors.gray),
            ),
            subtitle: StarRating(
              rating:double.parse(reply.user.rate.toString()),
              onRatingChanged: (rating) =>
              {} /* setState(() => this.rating = rating)*/,
              color: AppColors.yello,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              reply.comment??"",
              style: AppTextStyles.title2.copyWith(color: AppColors.gray),
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 20,right: 20,bottom: 10),
              child: Text(
                Utils.getFormatedDate(reply.createAt),
                style: AppTextStyles.title2.copyWith(
                    fontSize: 12,
                    color: AppColors.gray2),
              )),
        ]),
  );
}