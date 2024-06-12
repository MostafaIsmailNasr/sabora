import 'dart:io';

import '../models/BaseResponse.dart';
import '../models/auth/LoginRequest.dart';
import '../models/auth/LoginResponse.dart';
import '../models/auth/forgetPass/ForgetPassRequest.dart';
import '../models/auth/forgetPass/ForgetPassResponse.dart';
import '../models/auth/organization/OrganizationResponse.dart';
import '../models/auth/register/RegisterRequest.dart';
import '../models/auth/register/RegisterStep3Request.dart';
import '../models/auth/register/RegisterStep3Response.dart';
import '../models/auth/register/UpdatePassRequest.dart';
import '../models/auth/resetPass/ResetPassRequest.dart';
import '../models/auth/verifyUser/VerifyUserRequest.dart';
import '../models/governorate/GovernorateResponse.dart';
import '../models/groups/GroupsResponse.dart';
import '../providers/network/apis/auth_api.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

import '../models/auth/forgetPass/UpdatePassRes.dart';

class AuthenticationRepositoryIml extends AuthenticationRepository {
  @override
  Future<User> signUp(String username) async {
    //Fake sign up action
    await Future.delayed(Duration(seconds: 1));
    return User(username: username);
  }

  Future<LoginResponse> login(LoginRequest loginRequest) async {
    print(loginRequest);
    print(loginRequest.toJson());
    var response = await AuthAPI.login(loginRequest.toJson()).request();
    print(response);
    return LoginResponse.fromJson(response);
  }

  @override
  Future<ForgetPassResponse> forgetPass(ForgetPassRequest forgetPassRequest) async {
    var response = await AuthAPI.forgetPass(forgetPassRequest.toJson()).request();
    print(response);
    return ForgetPassResponse.fromJson(response);
  }

  @override
  Future<GroupsResponse> getEducationLevels(String organID) async {
    var response = await AuthAPI.getEducationLevels(organID).request();
    print(response);
    return GroupsResponse.fromJson(response);
  }

  @override
  Future<GovernorateResponse> getGovernorate() async {
    var response = await AuthAPI.getGovernorate().request();
    print(response);
    return GovernorateResponse.fromJson(response);
  }

  @override
  Future<LoginResponse> register(RegisterRequest registerRequest) async {
    var response =
        await AuthAPI.registerAccount(registerRequest.toJson(true)).request();
    print(response);
    return LoginResponse.fromJson(response);
  }

  @override
  Future<LoginResponse> updateProfile(RegisterRequest registerRequest) async {
    var response =
    await AuthAPI.updateProfile(registerRequest.toJson(false)).request();
    print(response);
    return LoginResponse.fromJson(response);
  }

  @override
  Future<BaseResponse> resetPass(ResetPassRequest resetPassRequest,String resetPassToken) async {
    var response = await AuthAPI.resetPass(resetPassRequest.toJson(),resetPassToken).request();
    print(response);
    return BaseResponse.fromJson(response);
  }

  @override
  Future<BaseResponse> verifyUser(VerifyUserRequest verifyUserRequest) async {
    var response = await AuthAPI.verifyUser(verifyUserRequest.toJson()).request();
    print(response);
    return BaseResponse.fromJson(response);
  }

  @override
  Future<RegisterStep3Response> registerStep3(RegisterStep3Request registerStep3Request)async{
    var response =
    await AuthAPI.registerStep3(registerStep3Request.toJson()).request();
    print(response);
    return RegisterStep3Response.fromJson(response);
  }

  @override
  Future<OrganizationResponse> getOrganizations(String cityId)async {
    var response =
        await AuthAPI.getOrganizations(cityId).request();
    print(response);
    return OrganizationResponse.fromJson(response);
  }

  @override
  Future<UpdatePassRes> updateProfilePass(UpdatePassRequest updatePassRequest)async {
    var response = await AuthAPI.updateProfilePass(updatePassRequest.toJson()).request();
    print(response);
    return UpdatePassRes.fromJson(response);
  }

  @override
  Future<BaseResponse> updateProfileImage(File userImage) async{
    var response = await AuthAPI.updateProfileImage(userImage).request();
    print(response);
    return BaseResponse.fromJson(response);
  }

  @override
  Future<BaseResponse> logoutRequest() async{
    var response = await AuthAPI.logoutRequest().request();
    print(response);
    return BaseResponse.fromJson(response);
  }

  @override
  Future<BaseResponse> deleteAccount() async{
    var response = await AuthAPI.deleteAccount().request();
    print(response);
    return BaseResponse.fromJson(response);
  }
}
