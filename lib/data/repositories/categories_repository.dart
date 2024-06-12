import '../../domain/repositories/categories_repository.dart';
import '../models/categories/CategoriesResponse.dart';
import '../providers/network/apis/course_api.dart';

class CategoriesRepositoryIml extends CategoriesRepository {


  @override
  Future<CategoriesResponse> getCategories(String? groupID) async {
    var response = await CourseAPI.getCategories(groupID).request();
    print(response);
    return CategoriesResponse.fromJson(response);
  }

}
