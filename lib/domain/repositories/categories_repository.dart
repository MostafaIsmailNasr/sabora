import '../../data/models/categories/CategoriesResponse.dart';

abstract class CategoriesRepository {
  Future<CategoriesResponse> getCategories(String? groupID);



}
