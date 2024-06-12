import '../../data/models/BaseResponse.dart';
import '../../data/models/teachers/TeacherDetailsResponse.dart';
import '../../data/models/teachers/TeachersResponse.dart';

abstract class TeachersRepository {
  Future<TeachersResponse> getTeachers(String? groupID);
  Future<TeacherDetailsResponse> getTeacherDetails(String? teacherID,String? groupID,String? organID);

  Future<BaseResponse> followTeacher(String teacherID, int status);


}
