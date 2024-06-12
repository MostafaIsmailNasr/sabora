import 'package:Sabora/app/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../controllers/auth/register_controller.dart';
import '../../../widgets/choose_dialog/select_level_dialog.dart';
import '../../../widgets/custom_toast/custom_toast.dart';
import '../../auth/login/login_screen.dart';

class PublicTab extends GetView<RegisterController> {

  late AppLocalizations _local;

  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    _local = AppLocalizations.of(context)!;
    print("0000000");
    Future.delayed(const Duration()).then((_) async {
      controller.bindData();
    });
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Form(
        key: controller.formKey,
        child: Container(
          margin: EdgeInsets.only(top: 20,left: 20,right: 20,bottom: 60),
          child: Column(
            children: [
              getRowInput(
                  _local.the_name,
                  _local.the_name,

                  controller.nameTextController, (dynamic value) {
                if (value == null) {
                  return _local.name_is_required;
                }
                return (!value!.isNotEmpty) ? _local.name_is_required : null;
              }),
              SizedBox(height: 25),
              getRowInput(
                  _local.phone_number,
                  "01xxxxxxxxx",
                  controller.phoneController, (dynamic value) {
                if (value == null) {
                  return _local.phone_is_required;
                }
                return (!value!.isNotEmpty) ? _local.phone_is_required : null;
              },isEditable:false),

              SizedBox(height: 25),
              GestureDetector(
                onTap: () => {

                  dialogSelectBuilder(
                      context,
                      _local,
                      _local.select_governorate,
                      controller.governorateList,
                      controller)

                },
                child: getRowInput(_local.governorate, _local.governorate,
                   controller.governorateController,
                        (dynamic value) {
                      if (value == null) {
                        return _local.select_governorate;
                      }
                      return (!value!.isNotEmpty)
                          ? _local.select_governorate
                          : null;
                    }, isEditable: false),
              ),


              SizedBox(height: 25),

              /*Obx(() =>   Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: RadioListTile(
                      activeColor: AppColors.primary,
                      title: Text(_local.online),
                      value: 0,
                      groupValue: controller.isOnline.value,
                      onChanged: (value){
                        controller.isOnline.value=0;
                        controller.registerRequest.organId="2";
                        controller.registerRequest.groupId ="";
                        controller.educationLevelController.text="";
                        controller.getEducationLevels(0.toString());
                      },
                    ),
                  ),

                  Expanded(
                    child: RadioListTile(
                      activeColor: AppColors.primary,
                      title: Text(_local.center),
                      value: 1,
                      groupValue: controller.isOnline.value,
                      onChanged: (value){
                        controller.isOnline.value=1;
                        controller.registerRequest.organId="";
                        controller.organizationController.text = "";
                        controller.educationLevelController.text = "";
                        controller.registerRequest.organId = "";
                        controller.registerRequest.groupId = "";
                        if(((controller.registerRequest.cityId??"").toString()).isNotEmpty){
                          controller.getOrganizations(controller.registerRequest.cityId.toString());
                        }
                      },
                    ),
                  ),
                ],)),*/
              Obx(() =>controller.isOnline.value==1?     SizedBox(height: 25):Container()),
              Obx(() =>controller.isOnline.value==1?   GestureDetector(
                  onTap: () => {
                    if (controller.registerRequest.cityId == null ||
                        controller.registerRequest.cityId!.isEmpty)
                      {
                        controller
                            .showToast(_local.select_governorate,isSuccess: false),
                      }
                    else
                      {
                        dialogSelectBuilder(
                            context,
                            _local,
                            _local.select_center,
                            controller.organizationList,
                            controller)
                      }
                  },
                  child: getRowInput(
                      _local.center,  _local.center,
                       controller.organizationController,
                          (dynamic value) {
                        if (value == null) {
                          return _local.select_center;
                        }
                        return (!value!.isNotEmpty)
                            ? _local.select_center
                            : null;
                      }, isEditable: false)):Container()),

              SizedBox(height: 25),
              GestureDetector(
                  onTap: () => {
                    if (controller.registerRequest.organId == null ||
                        controller.registerRequest.organId!.isEmpty)
                      {
                        controller
                            .showToast(_local.select_center,isSuccess: false),
                      }
                    else
                      {
                        dialogSelectBuilder(
                            context,
                            _local,
                            _local.select_education_level,
                            controller.educationLevelsList,
                            controller)
                      }
                  },
                  child: getRowInput(
                      _local.educational_level, _local.educational_level,
                       controller.educationLevelController,
                          (dynamic value) {
                        if (value == null) {
                          return _local.select_education_level;
                        }
                        return (!value!.isNotEmpty)
                            ? _local.select_education_level
                            : null;
                      }, isEditable: false)),



            ],
          ),
        ),
      ),
    );
  }
}
