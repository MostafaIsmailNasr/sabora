import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/models/home/course_details/Course.dart';
import '../../controllers/course_details/course_details_binding.dart';
import '../../controllers/course_details/course_details_controller.dart';
import '../../widgets/chapter_item/chapter_item.dart';
import '../../widgets/custom_toast/custom_toast.dart';
import 'chapter_details/chapter_details.dart';

class CourseContent extends StatelessWidget with WidgetsBindingObserver{
  List<dynamic> contentList;
  Course? mCourse;
  CourseDetailsController? controller;
  late AppLocalizations _local;

  bool isFirstQuizLocked = false;
  bool isFirstQuizMustPass = false;
  bool locked = false;
  int positionLocked = -1;

  CourseContent(this.contentList, this.mCourse, this.controller);



  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    locked=false;
    positionLocked = -1;
    _local = AppLocalizations.of(context)!;

    // final MyInheritedWidget myInheritedWidget = context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
    // Now you have access to the value of MyInheritedWidget!
  //   return Container();
  // }
  // @override
  // Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    //ToastMContext().init(context);
    return ListView.builder(
     physics: const ScrollPhysics(),
      shrinkWrap: true,
     // scrollDirection: Axis.vertical,
      itemCount: contentList.length,
      itemBuilder: (context, position) {



        print("locked==>isFirstQuizMustPass${position}==>${positionLocked}");
        //if(!locked){
        if ((position>positionLocked)&&positionLocked!=-1 ) {
          (contentList[position]).setLocked( locked);
          print("locked==>position${position}${locked}");
        }
      //  }


        if (contentList[position].type == "quiz") {
          print("locked==>"+contentList[position].authStatus);
          if ((contentList[position].mustPass == 1)){
          if (contentList[position].authStatus != "passed") {
            isFirstQuizMustPass = true;
            locked = true;
            positionLocked = position;
          } else {
            //locked = false;
          }

          }else{
            //positionLocked = position;
            //locked = false;
          }}


       ///calc file percentage
        if (contentList[position].type != "quiz") {
          calCulatePercentage(contentList[position]);
          print("contentList[position].percentage");
          print(contentList[position].percentage);
        }
        print("locked==>${locked}${contentList[position].locked}");

        return buildChapterItem(
            contentList[position],
            mCourse,
            (position == 0) ||
                (contentList.length > 0 &&
                    position < contentList.length &&
                    contentList[position].chapterName !=
                        contentList[position - 1].chapterName),
            () => {

            if (contentList[position].accessibility == "paid" &&
                      !(mCourse?.authHasBought ?? false))
                    {controller?.showToast(context:context,controller!.getLocale().you_must_subscribe_to_this_course,isSuccess: false)}
                  else
                    {
                      if (contentList[position].type == "quiz")
                        {
                          if ((mCourse?.authHasBought ?? false))
                            {
                              if(!(contentList[position].locked??false)){
                              controller?.getQuizDetails(context,
                                  contentList[position].quizId.toString())
                              }else{
                                controller
                                    ?.showToast(context:context,_local.take_the_previous_quiz_first,isSuccess: false)
                              }
                            }
                          else
                            {
                              controller
                                  ?.showToast(context:context,_local.you_must_subscribe_to_this_course,isSuccess: false)
                            }
                        }
                      else
                        {
                          //controller.courseDetailsVideoController?.dispose(),

                          if ((double.parse((contentList[position].percentage??0).toString())) >= 100.0)
                            {
                              if (!(mCourse?.canAddToCart == ("free")))
                                {
                                  if ((contentList[position]?.codeUsableTime??0) != 0)
                                    {
                                      if ((contentList[position].locked ??
                                          false)||(double.parse((contentList[position].percentage??0).toString())) >= 100.0)
                                        {
                                          controller?.showToast(context:context,
                                              _local.you_watched_course,isSuccess: false)
                                        }
                                    }else{
                                    Future.delayed(const Duration(seconds: 0))
                                        .then((value) {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChapterDetailsScreen(
                                                      contentList[position],
                                                      mCourse)));
                                      CourseDetailsBinding().dependencies();

                                      //Get.off(ChapterDetailsScreen(contentList[position],mCourse),binding: CourseDetailsBinding())
                                    })
                                  }
                                }
                            }
                          else
                            {
                            if(!(contentList[position].locked??false)){
                              Future.delayed(Duration(seconds: 0))
                                  .then((value) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChapterDetailsScreen(
                                                contentList[position],
                                                mCourse)));
                                CourseDetailsBinding().dependencies();

                                //Get.off(ChapterDetailsScreen(contentList[position],mCourse),binding: CourseDetailsBinding())
                              })
                            }else{

                              controller?.showToast(context:context,
                                  _local.take_the_previous_quiz_first,isSuccess: false)
                            }
                            }
                        }
                    }
                });
      },
    );
  }

  void calCulatePercentage(contentList) {
    if((contentList?.codeUsableTime??0)==0){
      contentList.setPercentage(0.0);
      return;
    }
    print("(mCourse?.codeUsableTime??0===>)${(contentList.viewCount??0).toString()}==>${(contentList?.codeUsableTime??1).toString()}");

    print((contentList?.codeUsableTime??0));

    var percentage=((((double.parse((contentList.viewCount??0).toString()))/(double.parse((contentList?.codeUsableTime??1).toString())))));
    percentage=percentage.isNaN?0:(percentage*100.0);
    print("====010>>${percentage}");
    //if(percentage==NaN)

    contentList.setPercentage(percentage>100.0?100.0:percentage);
    print(percentage>100.0?100.0:percentage);
  }
}
