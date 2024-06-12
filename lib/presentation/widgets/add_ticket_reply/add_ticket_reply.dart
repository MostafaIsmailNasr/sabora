import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../app/config/app_colors.dart';
import '../../../app/config/app_text_styles.dart';
import '../../../app/util/util.dart';
import '../../../generated/assets.dart';
import '../button.dart';
import '../textInput.dart';

typedef AddTicketReplyCallback = void Function(dynamic, dynamic);



showAddTicketReplyBottomSheet(BuildContext context,
    AddTicketReplyCallback addTicketReplyCallback) {
  File? attachedFile;
  TextEditingController textEditingController = TextEditingController();
  // when raised button is pressed
  // we display showModalBottomSheet
  final _formKey = GlobalKey<FormState>();
  var _local = AppLocalizations.of(context)!;
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
                                  onTap: () =>
                                  {
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
                                _local.support_response,
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
                                hint: _local.message_text,
                                textEditingController: textEditingController,
                                validator: (dynamic value) {
                                  if (value == null) {
                                    return "Please add Message text"; //_local.please_enter_coupon;
                                  }
                                  return (!value!.isNotEmpty)
                                      ? "Please add Message text" // _local.please_enter_coupon
                                      : null;
                                }),
                          ),


                          /*imagePath == null
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
                                        label: 'Delete',
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
                          ),*/

                          Container(
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: 20, top: 20),
                            child: Row(children: [
                              Expanded(
                                child: myButton(() {
                                  if (_formKey.currentState!.validate()) {
                                    Get.back();
                                    addTicketReplyCallback(textEditingController.text,attachedFile);
                                    // courseDetailsController.loading();
                                    // courseDetailsController.validateCourseCoupon();
                                  }
                                }, _local.reply),
                              ),
                              InkWell(
                                onTap: ()async  =>
                                {
                                 await Utils.pickFile((dynamic file){
                                   setState(()=>{
                                   attachedFile=file
                                   });
                                  })
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: AppColors.primary),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16))
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Icon(Icons.attach_file_rounded),
                                  ),
                                ),
                              )
                            ]),
                          ),
                          //  SizedBox(height: 40,)
                        ],
                      ),
                    ),
                  ),
                ),
          ));


}




