import '../../app/core/usecases/pram_usecase.dart';
import '../../data/models/auth/ProfileResponse.dart';
import '../../data/models/settings/SettingsResponse.dart';
import '../repositories/splash_repository.dart';

class SplashUseCase extends ParamUseCase<ProfileResponse, String> {
  final SplashRepository _repo;
  SplashUseCase(this._repo);

  @override
  Future<ProfileResponse> execute(String userID) {
    return _repo.getUserProfile(userID);
  }

  @override
  Future<SettingsResponse> getSettings() {
    return _repo.getSettings();
  }
}
