import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../app/config/app_colors.dart';
import '../../../../app/config/app_text_styles.dart';
import '../../../../generated/assets.dart';
import '../../../controllers/my_Comments/my_comments_controller.dart';
import '../../../widgets/add_comment/add_comment.dart';
import '../../../widgets/button.dart';
import '../../../widgets/custom_toast/custom_toast.dart';
import '../../../widgets/main_toolbar/main_toolbar.dart';
import '../../../widgets/soundPlayer/CustomSoundPlayerWidget.dart';

class CommentDetailsScreen extends GetView<MyCommentsController> {
  late AppLocalizations _local;
  dynamic comment;
  final _scaffoldKey =
      GlobalKey<ScaffoldState>(); // <---- Another instance variable

  CommentDetailsScreen(this.comment, {super.key});

  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);

    print("my courses==>");
    ToastMContext().init(context);
    _local = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white24,
      appBar: buildMainToolBar(
          controller, _local.comments, () => Navigator.pop(context, true)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20, bottom: 20),
                            height: 36,
                            width: 36,
                            child: SvgPicture.asset(Assets.imagesPlayVideo),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _local.this_comment_is_for,
                                        style: AppTextStyles.title.copyWith(
                                            fontSize: 14,
                                            color: AppColors.gray2),
                                      ),
                                    ),
                                  ],
                                ),

                                Row(
                                  children: [
                                    Container(
                                      width: 200,
                                      child: Text(
                                        comment.webinar?.title ?? "",
                                        style: AppTextStyles.title3,
                                      ),
                                    )
                                  ],
                                ),

                                const SizedBox(
                                  height: 15,
                                )
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
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          comment.comment ?? "",
                          style: AppTextStyles.title3,
                        ),
                      ),
                    ],
                  ),
                ),
                comment.voice == null
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: VoiceMessageV2(
                          audioSrc: comment.voice ??
                              "" /*'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3'*/,
                          played: false, // To show played badge or not.
                          me: true, // Set message side.
                          onPlay: () {}, // Do something when voice played.
                        )),
                comment.image == null
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Container(
                          //width: MediaQuery.of(context).size.width,
                          //width: 100,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                height: 180,
                                width: 190,
                                (comment.image ?? "")
                                    .toString() /*"https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"*/,
                                fit: BoxFit.fill,
                                loadingBuilder: (context, child,
                                        loadingProgress) =>
                                    (loadingProgress == null)
                                        ? child
                                        : const Center(
                                            child: CircularProgressIndicator()),
                                errorBuilder: (context, error, stackTrace) =>
                                    const Center(
                                        child: Image(image: AssetImage('assets/images/edu_gate_logo2.png'),)),
                              )),
                        )),
                //  AudioPlayerView(source: AudioSource.asset("https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3"), id: "1")
                // , RecordButton(recordingFinishedCallback: (value ) {
                //   print(value);
                //   print(Uri.directory(value));
                //  },)
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ]),
            child: Row(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: myButton(() {
                    showAddCommentBottomSheet(context,
                        (imagePth, soundPath, mComment) {
                      controller.editComment(
                          comment.id.toString(), imagePth, soundPath, mComment);
                    });
                  }, _local.edit),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: myButton(
                    () {
                      controller.deleteComment(comment.id.toString(), context);
                    },
                    _local.delete,
                    fillColor: AppColors.red,
                  ),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
