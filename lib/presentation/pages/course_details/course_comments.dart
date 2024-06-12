 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../generated/assets.dart';
import '../../controllers/course_details/course_details_controller.dart';
import '../../widgets/custom_toast/custom_toast.dart';
import '../../widgets/empty_widget/empty_widget.dart';
import '../../widgets/item_user_rate/user_rate_item.dart';

class CourseComments extends StatelessWidget {
  late AppLocalizations _local;
  List<dynamic> comments;
  CourseDetailsController controller;
  CourseComments(this.comments,this.controller);

  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    _local = AppLocalizations.of(context)!;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child:comments.isEmpty?buildEmptyWidget(context,SvgPicture.asset(Assets.imagesNoComments),
          _local.no_comment,
          _local.there_are_no_comments_for_this_track
      ):  SingleChildScrollView(
    physics: ScrollPhysics(),
    child:Container(
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(top: 5,bottom: 5),
      child: ListView.builder(
        controller: controller.scrollController,
          physics:ClampingScrollPhysics() ,
          //shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount:comments.length,
          itemBuilder: (context, position) {
            return  buildUserCommentItem(comments[position??0]);
          },
        ),
    )
      ),
    );
  }


}
