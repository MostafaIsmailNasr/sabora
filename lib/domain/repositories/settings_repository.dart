import '../../data/models/auth/ProfileResponse.dart';

abstract class SettingsRepository {

  Future<ProfileResponse> getUserProfile(String userId);


}
