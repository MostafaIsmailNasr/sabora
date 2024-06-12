import 'dart:io';

import '../../data/models/BaseResponse.dart';
import '../../data/models/auth/LoginRequest.dart';
import '../../data/models/auth/LoginResponse.dart';
import '../../data/models/auth/ProfileResponse.dart';
import '../../data/models/auth/forgetPass/ForgetPassRequest.dart';
import '../../data/models/auth/forgetPass/ForgetPassResponse.dart';
import '../../data/models/auth/organization/OrganizationResponse.dart';
import '../../data/models/auth/register/RegisterRequest.dart';
import '../../data/models/auth/register/RegisterStep3Request.dart';
import '../../data/models/auth/register/RegisterStep3Response.dart';
import '../../data/models/auth/register/UpdatePassRequest.dart';
import '../../data/models/auth/resetPass/ResetPassRequest.dart';
import '../../data/models/auth/verifyUser/VerifyUserRequest.dart';
import '../../data/models/governorate/GovernorateResponse.dart';
import '../../data/models/groups/GroupsResponse.dart';
import '../entities/user.dart';

import '../../data/models/auth/forgetPass/UpdatePassRes.dart';

abstract class AuthenticationRepository {

  Future<User> signUp(String username);

  Future<LoginResponse> login(LoginRequest loginRequest);

  Future<GovernorateResponse> getGovernorate();

  Future<GroupsResponse> getEducationLevels(String cityId);

  Future<LoginResponse> register(RegisterRequest registerRequest);

  Future<LoginResponse> updateProfile(RegisterRequest registerRequest);

  Future<RegisterStep3Response> registerStep3(RegisterStep3Request registerStep3Request);

  Future<BaseResponse> verifyUser(VerifyUserRequest verifyUserRequest);

  Future<ForgetPassResponse> forgetPass(ForgetPassRequest forgetPassRequest);

  Future<BaseResponse> resetPass(ResetPassRequest resetPassRequest,String resetPassToken);

  Future<OrganizationResponse> getOrganizations(String cityId);

  Future<UpdatePassRes> updateProfilePass(UpdatePassRequest updatePassRequest) ;

  Future<BaseResponse> updateProfileImage(File userImage);

  Future<BaseResponse> logoutRequest();

  Future<BaseResponse> deleteAccount();

}
