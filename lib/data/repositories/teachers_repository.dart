import '../../domain/repositories/teachers_repository.dart';
import '../models/BaseResponse.dart';
import '../models/teachers/TeacherDetailsResponse.dart';
import '../models/teachers/TeachersResponse.dart';
import '../providers/network/apis/course_api.dart';

class TeachersRepositoryIml extends TeachersRepository {


  @override
  Future<TeacherDetailsResponse> getTeacherDetails(String? teacherID,String? groupID, String? organID) async{
    var response = await CourseAPI.getTeacherDetails(teacherID,groupID,organID).request();
    print(response);
    return TeacherDetailsResponse.fromJson(response);
  }

  @override
  Future<TeachersResponse> getTeachers(String? groupID) async{
    var response = await CourseAPI.getTeachers(groupID).request();
    print(response);
    return TeachersResponse.fromJson(response);
  }

  @override
  Future<BaseResponse> followTeacher(String teacherID,int status)async {
    var response = await CourseAPI.followTeacher(teacherID,status).request();
    print(response);
    return BaseResponse.fromJson(response);
  }

}
