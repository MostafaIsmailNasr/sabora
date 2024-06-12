import '../../app/core/usecases/pram_usecase.dart';
import '../../data/models/auth/ProfileResponse.dart';
import '../repositories/settings_repository.dart';

class SettingsUseCase extends ParamUseCase<ProfileResponse, String> {
  final SettingsRepository _repo;
  SettingsUseCase(this._repo);

  @override
  Future<ProfileResponse> execute(String userID) {
    return _repo.getUserProfile(userID);
  }

}
