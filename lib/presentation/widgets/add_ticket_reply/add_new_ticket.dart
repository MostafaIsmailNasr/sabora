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
import '../custom_toast/custom_toast.dart';
import '../textInput.dart';

typedef AddTicketCallback = void Function(dynamic, dynamic,dynamic, dynamic);

showAddNewTicketBottomSheet(
    BuildContext context,List<dynamic> departmentsList, AddTicketCallback addTicketCallback) {
  File? attachedFile;
  TextEditingController textTitleEditingController = TextEditingController();
  TextEditingController textEditingController = TextEditingController();
  // Initial Selected Value
  String? dropdownvalue = null;

  // List of items in our dropdown menu
  var items = departmentsList.map(( element) {
    return DropdownMenuItem(
      value: element["id"].toString(),
      child: Text(element["title"]),
    );
  }).toList()/* [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ]*/;

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
      builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext context, setState) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
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
                              onTap: () => {Get.back()},
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
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 25),
                        child: MyTextFieldForm(
                            fillColor: AppColors.gray4,
                          //  assetNamePrefex: Assets.imagesUser,
                            hint: _local.message_text,
                            textEditingController: textTitleEditingController,
                            validator: (dynamic value) {
                              if (value == null) {
                                return  _local.please_add_ticket_title; //_local.please_enter_coupon;
                              }
                              return (!value!.isNotEmpty)
                                  ? _local.please_add_ticket_title // _local.please_enter_coupon
                                  : null;
                            }),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 25),
                        padding:  const EdgeInsets.only(left: 10, right: 10,top: 5,bottom: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),

                          border: Border.all(width: 1,color:AppColors.gray)

                        ),
                        child: DropdownButton(
                          // Initial Value
                          hint: Text(_local.select_department),
                          value: dropdownvalue,
                          isExpanded: true,
                          underline: Container(),
                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items:items,
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (dynamic newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 25),
                        child: MyTextFieldForm(
                            fillColor: AppColors.gray4,
                            maxLines: 3,
                            minLines: 1,
                            hint: _local.message_text,
                            textEditingController: textEditingController,
                            validator: (dynamic value) {
                              if (value == null) {
                                return _local.please_add_message_text;
                              }
                              return (!value!.isNotEmpty)
                                  ? _local.please_add_message_text
                                  : null;
                            }),
                      ),

                      Container(
                        margin: EdgeInsets.only(
                            left: 20, right: 20, bottom: 20, top: 20),
                        child: Row(children: [
                          Expanded(
                            child: myButton(() {
                              if (_formKey.currentState!.validate()) {
                                if(dropdownvalue==null){
                                  Toast.show(_local.please_select_department,_local.done,isSuccess: false);
                                  return;
                                }
                                Get.back();
                                addTicketCallback(
                                    textTitleEditingController.text,
                                    textEditingController.text,
                                    dropdownvalue,
                                    attachedFile);
                                // courseDetailsController.loading();
                                // courseDetailsController.validateCourseCoupon();
                              }
                            }, _local.reply),
                          ),
                          InkWell(
                            onTap: () async => {
                              await Utils.pickFile((dynamic file) {
                                setState(() => {attachedFile = file});
                              })
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: AppColors.primary),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16))),
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
