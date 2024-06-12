import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../app/config/app_colors.dart';
import '../../../../app/config/app_text_styles.dart';
import '../../../../data/models/categories/Categories.dart';
import '../../../../generated/assets.dart';
import '../../../controllers/categories/categories_controller.dart';
import '../../../controllers/teachers/teachers_binding.dart';
import '../../../widgets/custom_toast/custom_toast.dart';
import '../../../widgets/main_toolbar/main_toolbar.dart';
import '../teachers/teacher_details/teacher_details.dart';

class CategoriesScreen extends GetView<CategoriesController> {
  late AppLocalizations _local;

  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    controller.getCategories();
    _local = AppLocalizations.of(context)!;

    return Scaffold(
        backgroundColor: Colors.white24,
        appBar: buildMainToolBar(controller,isMenu: true, _local.categories, () => controller.toggleDrawer()
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20, right: 10, top: 30),
                child: Text(
                  _local.browse_articles,
                  style: AppTextStyles.title3,
                ),
              ),
              Expanded(
                  child: Obx(
                () => controller.isLoading.value?Center(
                  child: CircularProgressIndicator(),
                ):ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.categoriesList.value.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildCategoryItem(
                          controller.categoriesList.value[index]);
                    }),
              ))
            ],
          ),
        ));
  }

  Widget _buildCategoryItem(Categories category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          onTap: () => {
            category.isExpanded = !category.isExpanded,
            controller.categoriesList.refresh()
          },
          leading: SizedBox(
            height: 52,
            width: 52,
            child: ClipRRect(
                //borderRadius: BorderRadius.circular(100),
                child: Image.network(
              height: 52,
              width: 52,
              category.icon ?? "",
              fit: BoxFit.fill,
              loadingBuilder: (context, child, loadingProgress) =>
                  (loadingProgress == null)
                      ? child
                      : Center(child: CircularProgressIndicator()),
              errorBuilder: (context, error, stackTrace) => Container(
                  height: 52,
                  width: 52,
                  child: Image(image: AssetImage('assets/images/edu_gate_logo2.png'),)),
            )),
          ),
          title: Text(
            category.title ?? "",
            style: AppTextStyles.title3,
          ),
          subtitle: Text(
            "${category.teachers?.length.toString()} ${_local.teachers}",
            style: AppTextStyles.title2.copyWith(color: AppColors.gray2),
          ),
          trailing: category.isExpanded
              ? Icon(Icons.keyboard_arrow_up_rounded)
              : Icon(Icons.keyboard_arrow_down_rounded),
        ),
        category.isExpanded
            ? ListView.builder(
                itemCount: category.teachers?.length,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () => {
                      Get.to(
                          TeacherDetailsScreen(
                              category.teachers![index].id.toString()),
                          binding: TeachersBinding())
                    },
                    leading: Icon(Icons.radio_button_off_rounded),
                    title: Text(
                      category.teachers![index].fullName ?? "",
                      style: AppTextStyles.title3,
                    ),
                    subtitle: Text(
                      category.teachers![index].roleName ?? "",
                      style:
                          AppTextStyles.title2.copyWith(color: AppColors.gray2),
                    ),
                  );
                })
            : Container(),
      ],
    );
  }
}
