import '../../data/models/auth/ProfileResponse.dart';
import '../../data/models/settings/SettingsResponse.dart';
import '../entities/user.dart';

abstract class SplashRepository {
  Future<User> signUp(String username);
  Future<ProfileResponse> getUserProfile(String userId);

  Future<SettingsResponse> getSettings();

}
