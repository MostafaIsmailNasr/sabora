import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../app/config/app_colors.dart';
import '../../../../../app/config/app_text_styles.dart';
import '../../../../../data/models/my_quizes_results/Quiz.dart';
import '../../../../../generated/assets.dart';
import '../../../../controllers/my_quizes/my_quizes_controller.dart';
import '../../../../controllers/my_quizes/quize_binding.dart';
import '../../../../widgets/custom_toast/custom_toast.dart';
import '../../../../widgets/empty_widget/empty_widget.dart';
import '../quiz_details/quiz_details.dart';

class NotSubscripedQuizesScreen extends GetView<MyQuizesController> {
  late AppLocalizations _local;
  var returnValue=false;
  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    print("not partic==>");
    _local = AppLocalizations.of(context)!;
    Future.delayed(Duration.zero,(){
      //your code goes here
      ToastMContext().init(context);
      controller.getMyNotPQuizes();
    });

    return Obx(() => controller.isLoading.value?Center(child: CircularProgressIndicator()):_buildListItems(context));
  }

  _buildListItems(BuildContext context){
   return controller.myNotPQuizesList.value.isEmpty?buildEmptyWidget(context,SvgPicture.asset(Assets.imagesNoQuizAnswers),
       _local.no_results,
       _local.you_have_participated_in_all_of_your_semester_exams
   ):ListView.builder(
      //  physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: controller.myNotPQuizesList.length,
      itemBuilder: (context, position) {
        return _buildNotSubscripedITem(
                ()async => {

                  if(!controller.myNotPQuizesList.value[position].locked){
              QuizeBinding().dependencies(),
                  returnValue=await Navigator.of(context)
                  .push(
                MaterialPageRoute(
                    builder: (_) => QuizDetailsScreen(controller
                        .myNotPQuizesList.value[position])),
              )
                  .then((val) =>
              val??false ? controller.getMyNotPQuizes() : null),
                  if(returnValue){
                    controller.getMyNotPQuizes()
                  }
              // Get.to(QuizDetailsScreen(quiz),binding: QuizeBinding())
                }else{
                    controller.showToast(_local.you_must_pass_the_previous_quiz,isSuccess: false)
                  }
            },
            controller.myNotPQuizesList.value[position]);
      },
    );
  }

  _buildNotSubscripedITem(GestureTapCallback callback, Quiz quiz) {
    return GestureDetector(
      onTap: callback,
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 2),
        child: Row(
          children: [
            Container(
              height: 70,
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
              width: 90,
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  child: Image.network(
                    height: 70,
                    quiz.webinar?.image ??
                        "" /*"https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"*/,
                    fit: BoxFit.fill,
                    loadingBuilder: (context, child, loadingProgress) =>
                        (loadingProgress == null)
                            ? child
                            : const Padding(
                                padding: EdgeInsets.all(15),
                                child: CircularProgressIndicator()),
                    errorBuilder: (context, error, stackTrace) =>
                        const Center(child: Image(image: AssetImage('assets/images/edu_gate_logo2.png'),)),
                  )),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quiz.title ?? "",
                    style: AppTextStyles.titleToolbar.copyWith(fontSize: 14),
                  ),
                  Text(
                    quiz.webinar?.category ?? "",
                    style: AppTextStyles.body.copyWith(fontSize: 13),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(Assets.imagesClock,color: AppColors.secoundry,),
                          Text(
                            " ساعه${quiz.time} ",
                            style: AppTextStyles.body
                                .copyWith(fontSize: 13, color: AppColors.gray2),
                          )
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(Assets.imagesMessageQuestion,color: AppColors.secoundry),
                          Text(
                            quiz.questionCount.toString(),
                            style: AppTextStyles.body.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: AppColors.gray2),
                          ),
                          const SizedBox(
                            width: 20,
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
