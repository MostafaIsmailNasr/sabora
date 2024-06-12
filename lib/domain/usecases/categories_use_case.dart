import '../../data/models/categories/CategoriesResponse.dart';
import '../repositories/categories_repository.dart';

class CategoriesUseCase  {
  final CategoriesRepository _repo;
  CategoriesUseCase(this._repo);


  Future<CategoriesResponse> getCategories(String? groupID){
    return _repo.getCategories(groupID);
  }

}
