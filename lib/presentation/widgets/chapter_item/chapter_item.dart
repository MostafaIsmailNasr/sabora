import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../app/config/app_colors.dart';
import '../../../app/config/app_text_styles.dart';
import '../../../data/models/course_details/ContentData.dart';
import '../../../data/models/home/course_details/Course.dart';
import '../../../generated/assets.dart';

buildChapterItem(ContentData contentList, Course? mCourse, bool showHeader,
    GestureTapCallback callback) {
  return Column(
    children: [
      showHeader
          ? Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                children: [
                  SvgPicture.asset(Assets.imagesMessageContent),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      contentList.chapterName ?? "",
                      style: AppTextStyles.title.copyWith(fontSize: 18),
                    ),
                  )
                ],
              ),
            )
          : Container(),
      buildContentItem(contentList, mCourse, callback)
      // ListView.builder(
      //   physics: ClampingScrollPhysics(),
      //   shrinkWrap: true,
      //   scrollDirection: Axis.vertical,
      //   itemCount:3,
      //   itemBuilder: (context, position) {
      //    return buildContentItem();
      //   },
      // )
    ],
  );
}

buildContentItem(
    ContentData contentList, Course? mCourse, GestureTapCallback callback) {
  print("content1==>${contentList.title}${(double.parse(
      (contentList.percentage ?? 0)
          .toString())
      )}");
  return GestureDetector(
    onTap: callback,
    child: Card(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: contentList.type == "quiz"
                    ? AppColors.yello
                    : AppColors.primary,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: SvgPicture.asset(contentList.type == "quiz"
                    ? Assets.imagesQuizIc
                    : (contentList.fileType == "pdf"
                        ? Assets.imagesPdfIc
                        : Assets.imagesIcVideoPlay))),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        contentList.title ?? "",
                        style:
                            AppTextStyles.titleToolbar.copyWith(fontSize: 14),
                      ),
                      Text(
                        contentList.videoDuration ?? "",
                        style: AppTextStyles.body,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                contentList.accessibility == "paid"
                    ? ((mCourse?.authHasBought ?? false)
                        ? Row(mainAxisSize: MainAxisSize.min, children: [
                            ((!(mCourse?.canAddToCart == ("free")) &&
                                        contentList.percentage == 100) ||
                                    ((contentList.accessibility == "paid" &&
                                            !(mCourse?.authHasBought ??
                                                false)) ||
                                        (contentList?.locked ?? false)))
                                ? const Icon(Icons.lock)
                                : Row(
                                  children: [
                                    SizedBox(
                                        width: 50,
                                        height: 30,
                                        child: Card(
                                          elevation: 0,
                                          child: Stack(
                                            children: [
                                              Center(
                                                  child: SvgPicture.asset(
                                                Assets.imagesEya,
                                                width: 35,
                                                height: 35,
                                              )),
                                              Center(
                                                child: Text(
                                                  contentList.viewCount.toString(),
                                                  style: const TextStyle(fontSize: 8),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    (contentList?.codeUsableTime??0)!=0?  CircularPercentIndicator(
                                      radius: 25.0,
                                      lineWidth: 4.0,
                                      percent: (double.parse(
                                          (contentList.percentage ?? 0)
                                              .toString()) /
                                          100.0),
                                      center: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            width: 30,
                                            child: Text(
                                              "${contentList.percentage ?? "0"}",
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          const Text(
                                            "%",
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                      progressColor: Colors.red,
                                    ):Container()
                                  ],
                                ),

                          ])
                        : Container())
                    : Container(),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
