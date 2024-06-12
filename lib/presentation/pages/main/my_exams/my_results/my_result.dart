import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../app/config/app_colors.dart';
import '../../../../../app/config/app_text_styles.dart';
import '../../../../../app/util/util.dart';
import '../../../../../data/models/quiz/store_quiz_result/Result.dart';
import '../../../../../generated/assets.dart';
import '../../../../controllers/my_quizes/my_quizes_controller.dart';
import '../../../../widgets/custom_toast/custom_toast.dart';
import '../../../../widgets/empty_widget/empty_widget.dart';
import '../quiz_status/quiz_status.dart';

class MyResultsScreen extends GetView<MyQuizesController> {
  late AppLocalizations _local;
  var returnValue=false;
  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    print("my result==>");
    _local = AppLocalizations.of(context)!;

    Future.delayed(Duration.zero, () {
      //your code goes here
      ToastMContext().init(context);
      controller.getMyQuizesResult();
    });
    return Obx(() => controller.isLoading.value
        ? const Center(child: CircularProgressIndicator())
        : controller.myQuizesResultsList.value.isEmpty?buildEmptyWidget(context,SvgPicture.asset(Assets.imagesNoQuizAnswers),
        _local.no_results,
        _local.you_do_not_have_test_results
    ):_buildMyResultsItems());
  }

  _buildMyResultsItems() {
    return ListView.builder(
      //  physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: controller.myQuizesResultsList.length,
      itemBuilder: (context, position) {
        return _buildResultITem(
            ()async => {
                Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                            builder: (_) => QuizStatusScreen(controller
                                .myQuizesResultsList.value[position].quiz?.id.toString())),
                      ),
                  // Get.to(QuizDetailsScreen(quiz),binding: QuizeBinding())
              if(returnValue){
                controller.getMyQuizesResult()
              }
                },
            controller.myQuizesResultsList.value[position]);
      },
    );
  }

  _buildResultITem(GestureTapCallback callback, QuizResult result) {
    return GestureDetector(
      onTap: callback,
      child: Stack(
        children: [
          Card(
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 2),
            child: Row(
              children: [
                Container(
                  height: 70,
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
                  width: 90,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      child: Image.network(
                        height: 70,
                        result.webinar?.image ??
                            "" /*"https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"*/,
                        fit: BoxFit.fill,
                        loadingBuilder: (context, child, loadingProgress) =>
                            (loadingProgress == null)
                                ? child
                                : const Center(child: CircularProgressIndicator()),
                        errorBuilder: (context, error, stackTrace) => const Center(
                            child: Image(image: AssetImage('assets/images/edu_gate_logo2.png'),)),
                      )),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        result.quiz?.title ?? "",
                        style:
                            AppTextStyles.titleToolbar.copyWith(fontSize: 14),
                      ),
                      Text(
                        result.webinar?.category ?? "" /*"رياضه"*/,
                        style: AppTextStyles.body.copyWith(fontSize: 13),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(Assets.imagesCalendar2,color: AppColors.secoundry,),
                              Text(
                                Utils.getFormatedDate(
                                    result.createdAt!.toInt()),
                                style: AppTextStyles.body.copyWith(
                                    fontSize: 13, color: AppColors.gray2),
                              )
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _getResultStatusIcon(result.status),
                              Text(
                                  result.status=="waiting"?_local.waiting: result.userGrade.toString(),
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
          Card(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
            color: _getResultStatusColor(result.status),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
              child: Text(
                result.status ?? "",
                style: AppTextStyles.title.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  _getResultStatusColor(String? status) {
    switch(status){
      case "passed" :
        return AppColors.green;
      case "waiting" :
        return AppColors.yello;
      default:
        return AppColors.red;
    }
  }
  _getResultStatusIcon(String? status) {
    switch(status){
      case "passed" :
        return SvgPicture.asset(Assets.imagesIcSuccess);
      case "waiting" :
        return SvgPicture.asset(Assets.imagesIcWaiting);
      default:
        return SvgPicture.asset(Assets.imagesIcFail);
    }
  }
}


