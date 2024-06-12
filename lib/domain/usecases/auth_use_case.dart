import 'dart:io';

import '../../app/core/usecases/pram_usecase.dart';
import '../../data/models/BaseResponse.dart';
import '../../data/models/auth/LoginRequest.dart';
import '../../data/models/auth/LoginResponse.dart';
import '../../data/models/auth/ProfileResponse.dart';
import '../../data/models/auth/forgetPass/ForgetPassRequest.dart';
import '../../data/models/auth/forgetPass/ForgetPassResponse.dart';
import '../../data/models/auth/forgetPass/UpdatePassRes.dart';
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
import '../repositories/auth_repository.dart';

class AuthUseCase extends ParamUseCase<User, String> {
  final AuthenticationRepository _repo;

  AuthUseCase(this._repo);

  @override
  Future<User> execute(String username) {
    return _repo.signUp(username);
  }


  @override
  Future<LoginResponse> login(LoginRequest loginRequest) {
    return _repo.login(loginRequest);
  }

  @override
  Future<GovernorateResponse> getGovernorate() {
    return _repo.getGovernorate();
  }

  @override
  Future<GroupsResponse> getEducationLevels(String organID) {
    return _repo.getEducationLevels(organID);
  }

  @override
  Future<LoginResponse> register(RegisterRequest registerRequest) {
    return _repo.register(registerRequest);
  }

  @override
  Future<LoginResponse> updateProfile(RegisterRequest registerRequest) {
    return _repo.updateProfile(registerRequest);
  }

  Future<UpdatePassRes> updateProfilePass(UpdatePassRequest updatePassRequest) {
    return _repo.updateProfilePass(updatePassRequest);
  }

  @override
  Future<RegisterStep3Response> registerStep3(RegisterStep3Request registerRequest) {
    return _repo.registerStep3(registerRequest);
  }

  @override
  Future<BaseResponse> verifyUser(VerifyUserRequest verifyUserRequest) {
    return _repo.verifyUser(verifyUserRequest);
  }

  @override
  Future<ForgetPassResponse> forgetPass(ForgetPassRequest forgetPassRequest) {
    return _repo.forgetPass(forgetPassRequest);
  }

  @override
  Future<BaseResponse> resetPass(ResetPassRequest resetPassRequest,String resetPassToken) {
    return _repo.resetPass(resetPassRequest,resetPassToken);
  }

  @override
  Future<OrganizationResponse> getOrganizations(String cityId) {
    return _repo.getOrganizations(cityId);
  }


  @override
  Future<BaseResponse> updateProfileImage(File userImage) {
    return _repo.updateProfileImage(userImage);
  }


  @override
  Future<BaseResponse> logoutRequest() {
    return _repo.logoutRequest();
  }

  @override
  Future<BaseResponse> deleteAccount() {
    return _repo.deleteAccount();
  }



}
