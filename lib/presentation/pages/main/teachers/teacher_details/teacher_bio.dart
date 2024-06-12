import 'package:flutter/cupertino.dart';

import '../../../../../app/config/app_text_styles.dart';
import '../../../../widgets/custom_toast/custom_toast.dart';

class TeacherBio extends StatelessWidget {

  String bio;
  TeacherBio(this.bio);
  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            bio,
            style: AppTextStyles.title2,
          )),
    );
  }
}
