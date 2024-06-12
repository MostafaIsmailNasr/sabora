import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:just_audio/just_audio.dart';

import '../../../app/config/app_colors.dart';
import '../../../app/config/app_text_styles.dart';
import '../../../app/util/util.dart';
import '../../../generated/assets.dart';
import '../audio_player/record_button.dart';
import '../button.dart';
import '../soundPlayer/CustomSoundPlayerWidget.dart';
import '../textInput.dart';

typedef AddCommentCallback = void Function(dynamic, dynamic, dynamic);

showAddCommentBottomSheet(BuildContext context,
    AddCommentCallback addCommentCallback, {bool isCourseDetails = false}) {
  //PersistentBottomSheetController _controller; // <------ Instance variable
  var soundUrl;
  var pickedImage;
  var imagePath;
  var audioDuration;
  TextEditingController textEditingController = TextEditingController();
  // when raised button is pressed
  // we display showModalBottomSheet
  final _formKey = GlobalKey<FormState>();
  var _local = AppLocalizations.of(context)!;


  Future<Duration?> getAudioDuration(String audioFilePath) async {
    final player = AudioPlayer();
    final duration = await player.setFilePath(audioFilePath);
    await player.dispose();
    return duration;
  }

  Future<File> getFile(String path) async {
    // Retrieve the audio file using your desired method
    // For example, using the file picker package to select a file
    // or by downloading the file from a remote URL

    // In this example, let's assume you use the file picker package

    // Import the file_picker package
    //import 'package:file_picker/file_picker.dart';

    // Use the file picker to select an audio file
    //FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio);

    // Check if a file was selected
    //if (result != null && result.files.isNotEmpty) {
    // Get the selected file
    //File file = File(result.files.single.path!);
    File file = File(path);

    // Return the file
    return file;
    //}

    // Return null if no file was selected or an error occurred
    //return null;
  }



   getAudioWidget() async{
    var audioDuration=await getAudioDuration((soundUrl ?? ""));
    return VoiceMessageV2(
      audioFile: getFile((soundUrl ?? "")),
      //     .toString() /*'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3'*/,
      played: false,
      duration: audioDuration,
      // To show played badge or not.
      me: true,
      // Set message side.
      onPlay:
          () {}, // Do something when voice played.
    );
  }


  showModalBottomSheet<void>(
      isScrollControlled: true,
      // context and builder are
      // required properties in this widget
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      builder: (BuildContext context) =>

           StatefulBuilder(
            builder: (BuildContext context, setState) =>
                 Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery
                          .of(context)
                          .viewInsets
                          .bottom),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
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
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                  onTap: ()=>{
                                    Get.back()
                                  },
                                  child: SvgPicture.asset(Assets.imagesClose2)),
                              SizedBox(
                                width: 20,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                _local.the_comment,
                                style: AppTextStyles.titleToolbar.copyWith(
                                    color: AppColors.graydark, fontSize: 16),
                              ),
                              // SizedBox(
                              //   width: 10,
                              // ),
                              // SvgPicture.asset(Assets.imagesVisa)
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 25),
                            child: MyTextFieldForm(
                                fillColor: AppColors.gray4,
                                maxLines: 5,
                                minLines: 1,
                                hint: _local.content,
                                textEditingController: textEditingController,
                                validator: (dynamic value) {
                                  if (value == null) {
                                    return _local.please_add_comment; //_local.please_enter_coupon;
                                  }
                                  return (!value!.isNotEmpty)
                                      ? _local.please_add_comment // _local.please_enter_coupon
                                      : null;
                                }),
                          ),
                          soundUrl == null
                              ? Container()
                              : Slidable(
                            // Specify a key if the Slidable is dismissible.
                              key: const ValueKey(0),

                              // The start action pane is the one at the left or the top side.
                              startActionPane: ActionPane(
                                // A motion is a widget used to control how the pane animates.
                                motion: ScrollMotion(),

                                // A pane can dismiss the Slidable.
                                // dismissible: DismissiblePane(onDismissed: () {}),

                                // All actions are defined in the children parameter.
                                children: [
                                  // A SlidableAction can have an icon and/or a label.
                                  SlidableAction(
                                    padding: EdgeInsets.all(0),
                                    spacing: 0,
                                    onPressed: (mContext) =>
                                    {
                                      setState(() {
                                        soundUrl = null;
                                      })
                                    },
                                    //backgroundColor: Color(0xFFFE4A49),
                                    // foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: _local.delete,
                                  ),
                                ],
                              ),

                              // The child of the Slidable is what the user sees when the
                              // component is not dragged.
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child:// Replace the previous Slidable code with this FutureBuilder
                                  FutureBuilder<Widget>(
                                    future: getAudioWidget(),
                                    builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        // While the future is loading, display a loading indicator
                                        return CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        // If an error occurred while fetching the audio widget, display an error message
                                        return Text('Error loading audio widget');
                                      } else {
                                        // Once the future completes, return the audio widget
                                        return Slidable(
                                          key: const ValueKey(0),
                                          startActionPane: ActionPane(
                                            motion: ScrollMotion(),
                                            children: [
                                              SlidableAction(
                                                padding: EdgeInsets.all(0),
                                                spacing: 0,
                                                onPressed: (mContext) => setState(() {
                                                  soundUrl = null;
                                                }),
                                                icon: Icons.delete,
                                                label: _local.delete,
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 10,
                                            ),
                                            child: snapshot.data,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                //AudioPlayerView(source: AudioSource.asset(soundUrl), id: "1")
                                  )),

                          imagePath == null
                              ? Container()
                              : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Slidable(
                                // Specify a key if the Slidable is dismissible.
                                  key: const ValueKey(0),

                                  // The start action pane is the one at the left or the top side.
                                  startActionPane: ActionPane(
                                    // A motion is a widget used to control how the pane animates.
                                    motion: ScrollMotion(),

                                    // A pane can dismiss the Slidable.
                                    // dismissible: DismissiblePane(onDismissed: () {}),

                                    // All actions are defined in the children parameter.
                                    children: [
                                      // A SlidableAction can have an icon and/or a label.
                                      SlidableAction(
                                        padding: EdgeInsets.all(0),
                                        spacing: 0,
                                        onPressed: (mContext) =>
                                        {
                                          setState(() {
                                            imagePath = null;
                                          })
                                        },
                                        //backgroundColor: Color(0xFFFE4A49),
                                        // foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: _local.delete,
                                      ),
                                    ],
                                  ),

                                  // The child of the Slidable is what the user sees when the
                                  // component is not dragged.
                                  child: Container(
                                    height: 116,
                                    child: Image.file(File(imagePath)),
                                  )),
                            ],
                          ),
                          isCourseDetails  ?Container(): Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () async =>
                                {
                                  pickedImage =
                                  await Utils.getImage(context, ImgSource.Both),
                                  if (pickedImage != null)
                                    setState(() {
                                      imagePath = pickedImage.path;
                                      print("imagePath====>");
                                      print(imagePath);
                                    })
                                },
                                child: Column(
                                  children: [
                                    SvgPicture.asset(Assets.imagesIcPic,color: AppColors.secoundry,),
                                    Text(
                                      _local.attach_photo,
                                      style: AppTextStyles.titleToolbar.copyWith(
                                          color: AppColors.graydark,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  RecordButton(
                                    recordingFinishedCallback: (value) {
                                      print("value===>");
                                      print(File(value).absolute.path);
                                      setState(() {
                                        soundUrl = File(value).absolute.path;
                                      });
                                    },
                                  ),
                                  // SvgPicture.asset(Assets.imagesIcMic),
                                  Text(
                                    _local.voice_message,
                                    style: AppTextStyles.titleToolbar.copyWith(
                                        color: AppColors.graydark, fontSize: 16),
                                  )
                                ],
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: 20, top: 20),
                            child: myButton(() {
                              if (_formKey.currentState!.validate()) {
                                Get.back();
                                addCommentCallback(imagePath, soundUrl,textEditingController.text);
                                // courseDetailsController.loading();
                                // courseDetailsController.validateCourseCoupon();
                              }
                            }, _local.save),
                          ),
                          //  SizedBox(height: 40,)
                        ],
                      ),
                    ),
                  ),
                )
          ));


}


