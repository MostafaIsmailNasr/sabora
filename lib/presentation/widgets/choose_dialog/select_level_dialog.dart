import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../data/models/Governorate/Cities.dart';
import '../../../data/models/auth/organization/Organizations.dart';
import '../../controllers/auth/register_controller.dart';

Future<void> dialogSelectBuilder(BuildContext context, AppLocalizations local,
    String title, List<dynamic> itemsList, RegisterController controller) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          title: Text(title),
          actions:[
            // GestureDetector(
            //   onTap: ()=>{
            //     Get.back()
            //   },
            //   child: Icon(Icons.close),
            // )
          ],
          insetPadding: EdgeInsets.symmetric(horizontal: 15),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24))),
          content: Container(
              width: MediaQuery.of(context).size.width * 1.9,
            //  height: MediaQuery.of(context).size.height * 0.4,
              child: ListView.builder(
                  // the number of items in the list
                  itemCount: itemsList.length,
                  shrinkWrap: true,
                  // display each item of the product list
                  itemBuilder: (context, index) {
                    var item = itemsList[index];

                    return GestureDetector(
                      onTap: () => {
                        if (item is Cities)
                          {
                            controller.governorateController.text =
                                item.title.toString(),
                            controller.registerRequest.cityId =
                                item.id.toString(),
                            controller.getOrganizations(item.id.toString()),
                            controller.organizationController.text = "",

                            controller.isOnline==1?controller.educationLevelController.text = "":null,
                            controller.isOnline==1?controller.registerRequest.organId = "":null,
                            controller.registerRequest.groupId = "",
                          }else if (item is Organizations)
                          {
                            controller.organizationController.text =
                                item.name.toString(),
                            controller.registerRequest.organId =
                                item.id.toString(),
                            controller.getEducationLevels(item.id.toString()),
                            controller.educationLevelController.text = "",
                            controller.registerRequest.groupId = "",
                          }
                        else
                          {
                            controller.educationLevelController.text =
                                item.name.toString(),
                            controller.registerRequest.groupId =
                                item.id.toString(),
                          },
                        Get.back()
                      },
                      child: Card(
                        // In many cases, the key isn't mandatory
                        key: ValueKey(item),
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text((item is Cities)
                                ? (item.title != null ? item.title! : "")
                                : ((item.name != null ? item.name! : "")))),
                      ),
                    );
                  })));
    },
  );
}
