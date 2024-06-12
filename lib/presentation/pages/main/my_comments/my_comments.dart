import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../app/config/app_colors.dart';
import '../../../../app/config/app_text_styles.dart';
import '../../../../app/util/util.dart';
import '../../../../generated/assets.dart';
import '../../../controllers/my_Comments/my_comments_controller.dart';
import '../../../widgets/custom_toast/custom_toast.dart';
import '../../../widgets/empty_widget/empty_widget.dart';
import '../../../widgets/main_toolbar/main_toolbar.dart';
import '../../../widgets/soundPlayer/CustomSoundPlayerWidget.dart';
import 'comment_details.dart';

class MyCommentsScreen extends GetView<MyCommentsController> {
  late AppLocalizations _local;

  initAudioPlayer() async{

  }
  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    print("my courses==>");
    initAudioPlayer();
    ToastMContext().init(context);
    _local = AppLocalizations.of(context)!;
    controller.isLoading.value=true;
    controller.currentPage=1;
    controller.isLastPage=false;
    controller.myCommentsList.value=[];
    print("getMyComments==>0");
    controller.getMyComments();
    return DefaultTabController(
        length: 1,
        child: Scaffold(
          backgroundColor: Colors.white24,
          appBar: buildMainToolBar(controller,
            isMenu: true,
              _local.comments, () => controller.toggleDrawer()
          )
          ,
          body: Column(
            children: [
              _buildMyCommentsTabs(),
              Expanded(
                child: TabBarView(children: [
                  Obx(() =>
                  controller.isLoading.value ? const Center(
                      child: CircularProgressIndicator()) : _buildTabMyComments(
                      controller.myCommentsList.value,context)),
                  /*Icon(Icons.movie),
                  Icon(Icons.games),*/
                ]),
              ),
            ],
          ),
        ));
  }

  _buildTabMyComments(List<dynamic> commentsList,BuildContext context) {
    return commentsList.isEmpty?buildEmptyWidget(context,SvgPicture.asset(Assets.imagesNoComments),
        _local.no_comment,
       "engane in classes & blogs to\n post comments"
    ):ListView.builder(
      // physics: ClampingScrollPhysics(),
      controller: controller.scrollController,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: commentsList.length,
      itemBuilder: (context, position) {
        return buildMyCommentItem(context,commentsList[position]);
      },
    );
  }

  buildMyCommentItem(BuildContext context, commentsList) {
    return InkWell(
      onTap: () async=>
      {
        await Navigator.of(context)
          .push(
        MaterialPageRoute(
            builder: (_) => CommentDetailsScreen(commentsList)),
      )
          .then((val) =>
      val??false ? {
      print("getMyComments==>3"),
      controller.currentPage=1,
            controller.isLastPage=false,
            controller.myCommentsList.value=[],
            controller.getMyComments()} : null),

      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20,bottom: 10),
                  height: 70,
                  width: 90,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        height: 70,
                        width: 90,
                        (commentsList.webinar?.image??"").toString()/*"https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"*/,
                        fit: BoxFit.fill,
                        loadingBuilder: (context, child, loadingProgress) =>
                        (loadingProgress == null)
                            ? child
                            : const Center(child: CircularProgressIndicator()),
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(
                                child: Image(image: AssetImage('assets/images/edu_gate_logo2.png'),)),
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              commentsList.comment??"",
                              style: AppTextStyles.title.copyWith(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(Assets.imagesIcCalendar,
                            color: AppColors.gray2,),
                          Text(
                          Utils.getFormatedDate(commentsList.createAt),
                            style: AppTextStyles.title2
                                .copyWith(color: AppColors.gray2, fontSize: 13),
                          )
                        ],
                      ),
                      commentsList.voice==null?Container():  VoiceMessageV2(

          audioSrc: commentsList.voice??""/*'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3'*/,
          played: false, // To show played badge or not.
          me: true, // Set message side.
          onPlay: () {}, // Do something when voice played.
        ),
                      const SizedBox(height: 15,)
                      //https://github.com/HayesGordon/stream-audio-attachment-tutorial
                    //  AudioPlayerView(source: AudioSource.asset("https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3"), id: "1")
                       ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildMyCommentsTabs() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 10),
      child: PreferredSize(
          preferredSize: Size.fromHeight(130),

          ///Note: Here I assigned 40 according to me. You can adjust this size acoording to your purpose.
          child: Align(
              alignment: controller.store.lang=="ar"?Alignment.centerRight:Alignment.centerLeft,
              child: TabBar(
                  isScrollable: true,
                  unselectedLabelColor: AppColors.primary,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelPadding: EdgeInsets.symmetric(horizontal: 7),
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.primary),
                  tabs: [
                    Tab(
                        child: Container(
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: AppColors.primary, width: 1)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(_local.my_comments,
                              style: AppTextStyles.title2.copyWith(
                                  color: Colors.white
                              ),),
                          ),
                        ))
                  ]))),
    );
  }

}
