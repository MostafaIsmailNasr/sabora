import '../../../../../data/models/home/course_details/Course.dart';
import '../../../../controllers/course_details/course_details_binding.dart';
import '../../../course_details/course_details.dart';
import '../../../../widgets/course.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../widgets/custom_toast/custom_toast.dart';

class TeacherCourses extends StatelessWidget {
  List<Course> webinars;

  TeacherCourses(this.webinars, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    return GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.9,
        shrinkWrap: true,
        children: List.generate(webinars?.length ?? 0, (index) {
          return getCourseItem(context, webinars[index],
              callback: () => {
                    Get.to(CourseDetailsScreen(webinars[index].id.toString()),
                        binding: CourseDetailsBinding())
                  });
        }));
  }
}
