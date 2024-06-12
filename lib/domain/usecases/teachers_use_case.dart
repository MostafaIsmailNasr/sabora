import '../../data/models/BaseResponse.dart';
import '../../data/models/teachers/TeacherDetailsResponse.dart';
import '../../data/models/teachers/TeachersResponse.dart';
import '../repositories/teachers_repository.dart';

class TeachersUseCase  {
  final TeachersRepository _repo;
  TeachersUseCase(this._repo);


  Future<TeachersResponse> getTeachers(String? groupID){
    return _repo.getTeachers(groupID);
  }
  Future<TeacherDetailsResponse> getTeacherDetails(String? teacherID,String? groupID,String? organID){
    return _repo.getTeacherDetails(teacherID, groupID, organID);
  }

  Future<BaseResponse> followTeacher(String? teacherID, int status){
    return _repo.followTeacher(teacherID!,status);
  }
}
