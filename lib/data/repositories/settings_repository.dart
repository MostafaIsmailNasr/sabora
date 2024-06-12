import '../../domain/repositories/settings_repository.dart';
import '../models/auth/ProfileResponse.dart';
import '../providers/network/apis/home_api.dart';

class SettingsRepositoryIml extends SettingsRepository {



  @override
  Future<ProfileResponse> getUserProfile(String userId) async{
    print(userId);

    var response = await HomeAPI.getUserProfile(userId).request();
    print(response);
    return ProfileResponse.fromJson(response);
  }

}
