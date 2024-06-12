import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../app/config/app_text_styles.dart';
import '../../../app/config/app_colors.dart';
import '../../../app/util/util.dart';
import '../../../data/models/home/course_details/Course.dart';
import '../../../generated/assets.dart';
import '../../controllers/course_details/course_details_binding.dart';
import '../../controllers/favourits/favourits_controller.dart';
import '../../widgets/custom_toast/custom_toast.dart';
import '../../widgets/empty_widget/empty_widget.dart';
import '../../widgets/main_toolbar/main_toolbar.dart';
import '../../widgets/rate_bar/rate_bar.dart';
import '../course_details/course_details.dart';


class FavouritsScreen extends GetView<FavouritsController> {
  late AppLocalizations _local;

  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    controller.getFavourits();
    _local = AppLocalizations.of(context)!;

    return Scaffold(
        backgroundColor: Colors.white24,
        appBar: buildMainToolBar(controller,isMenu: true, _local.favorite, () => {
          controller.toggleDrawer()
        }),
        body:  Obx(
              () => controller.isLoading.value?Center(child: CircularProgressIndicator()): _buildFavList(context)));
  }

  _buildFavList(BuildContext context){
    return controller.favouritsList.value.isEmpty?buildEmptyWidget(context,SvgPicture.asset(Assets.imagesNoFavorites),
       // _local.there_are_no_favourites,
        "",""
        //_local.add_the_track_to_your_favorites_list
    )
        :Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.favouritsList.value.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildFavouritsItem(controller.favouritsList.value[index].webinar, () {
                    Get.to(CourseDetailsScreen(controller.favouritsList.value[index].webinar.id.toString()),binding: CourseDetailsBinding());
                  });
                }),
          ),
        ],
      ),
    );
  }

  Widget _buildFavouritsItem(Course course,GestureTapCallback callback) {
    return GestureDetector(
      onTap: callback,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.only(bottom: 2,left: 20,right: 20),
        child: Row(
          children: [
            Container(
              height: 70,
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
              width: 90,
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: Image.network(
                    height: 70,

                    course.image??""/*"https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"*/,
                    fit: BoxFit.fill,
                    loadingBuilder: (context, child, loadingProgress) =>
                    (loadingProgress == null)
                        ? child
                        : Padding(
                        padding: EdgeInsets.all(15),
                        child: CircularProgressIndicator()),
                    errorBuilder: (context, error, stackTrace) =>
                        Center(child: Image(image: AssetImage('assets/images/edu_gate_logo2.png'),)),
                  )),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title??"",
                    style: AppTextStyles.authTitleStyle.copyWith(fontSize: 14,
                    color: Colors.black),
                  ),
                  Container(
                    width: 100,
                    child: StarRating(
                      rating: double.parse(course.rate??"0"),
                      onRatingChanged: (rating) =>
                      {} /* setState(() => this.rating = rating)*/,
                      color: AppColors.yello,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(Assets.imagesCalendar2,
                            color: AppColors.gray2,),
                            SizedBox(width: 5,),
                            Text(
                              Utils.getFormatedDate((course.createdAt??0).toInt()),
                              style: AppTextStyles.body
                                  .copyWith(fontSize: 13, color: AppColors.gray2),
                            )
                          ],
                        ),
                      ),
                      Text(
                        course.price == 0
                            ? _local.free
                            : "${course.price} ${_local.egp}",
                        style: AppTextStyles.body.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: AppColors.primary),
                      ),
                      SizedBox(width: 10,)
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
