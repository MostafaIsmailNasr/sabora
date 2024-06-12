import '../../domain/entities/user.dart';
import '../../domain/repositories/splash_repository.dart';
import '../models/auth/ProfileResponse.dart';
import '../models/settings/SettingsResponse.dart';
import '../providers/network/apis/auth_api.dart';

class SplashRepositoryIml extends SplashRepository {
  @override
  Future<User> signUp(String username) async {
    //Fake sign up action
    await Future.delayed(Duration(seconds: 1));
    return User(username: username);
  }

  @override
  Future<ProfileResponse> getUserProfile(String userId) async{
    print(userId);

    var response = await AuthAPI.getUserProfile(userId).request();
    print(response);
    return ProfileResponse.fromJson(response);
  }

  @override
  Future<SettingsResponse> getSettings() async{


    var response = await AuthAPI.getSettings().request();
    print(response);
    return SettingsResponse.fromJson(response);
  }

}
