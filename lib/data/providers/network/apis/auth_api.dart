import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../../../../app/services/local_storage.dart';
import '../api_endpoint.dart';
import '../api_provider.dart';
import '../api_request_representable.dart';


enum AuthType {
  login,
  logout,
  userProfile,
  settings,
  register,
  registerStep3,
  forgetPass,
  resetPass,
  verifyUser,
  educationLevels,
  organizations,
  updateProfile,
  updatePass,
  updateUserImage,
  deleteAccount,
  governorate
}

class AuthAPI implements APIRequestRepresentable {
  final AuthType type;
  final storage = Get.find<LocalStorageService>();

  Map<String, dynamic>? loginRequest;
  Map<String, dynamic>? registerRequest;

  Map<String, dynamic>? forgetPassRequest;
  Map<String, dynamic>? resetPassRequest;
  Map<String, dynamic>? verifyUserRequest;
  Map<String, dynamic>? registerStep3Request;
  Map<String, dynamic>? updatePassRequest;

  String? cityId;
  String? organID;

  String? userID;
  File? userImage;

  String? resetPassToken;

  AuthAPI._(
      {required this.type,
      this.loginRequest,
      this.registerRequest,
      this.userID,
      this.cityId,
      this.userImage,
      this.forgetPassRequest,
      this.resetPassRequest,
      this.verifyUserRequest,
      this.updatePassRequest,
      this.resetPassToken,
      this.organID,
      this.registerStep3Request});

  AuthAPI.login(Map<String, dynamic> loginRequest)
      : this._(loginRequest: loginRequest, type: AuthType.login);

  AuthAPI.register(String password, String username)
      : this._(type: AuthType.login);

  AuthAPI.getUserProfile(String userID)
      : this._(userID: userID, type: AuthType.userProfile);

  AuthAPI.getSettings() : this._(type: AuthType.settings);

  AuthAPI.registerAccount(Map<String, dynamic> registerRequest)
      : this._(registerRequest: registerRequest, type: AuthType.register);

  AuthAPI.updateProfile(Map<String, dynamic> registerRequest)
      : this._(registerRequest: registerRequest, type: AuthType.updateProfile);

  AuthAPI.registerStep3(Map<String, dynamic> registerStep3Request)
      : this._(registerStep3Request: registerStep3Request, type: AuthType.registerStep3);

  AuthAPI.forgetPass(Map<String, dynamic> forgetPassRequest)
      : this._(forgetPassRequest: forgetPassRequest, type: AuthType.forgetPass);

  AuthAPI.resetPass(
      Map<String, dynamic> resetPassRequest, String resetPassToken)
      : this._(
            resetPassRequest: resetPassRequest,
            resetPassToken: resetPassToken,
            type: AuthType.resetPass);

  AuthAPI.verifyUser(Map<String, dynamic> verifyUserRequest)
      : this._(verifyUserRequest: verifyUserRequest, type: AuthType.verifyUser);

  AuthAPI.getGovernorate() : this._(type: AuthType.governorate);

  AuthAPI.getEducationLevels(String organID)
      : this._(organID: organID, type: AuthType.educationLevels);

  AuthAPI.getOrganizations(String cityId)
      : this._(cityId: cityId, type: AuthType.organizations);

  AuthAPI.updateProfilePass(Map<String, dynamic> updatePassRequest)
      : this._(updatePassRequest: updatePassRequest, type: AuthType.updatePass);

  AuthAPI.updateProfileImage(File userImage)
      : this._(userImage: userImage, type: AuthType.updateUserImage);

  AuthAPI.logoutRequest()
      : this._(type: AuthType.logout);

  AuthAPI.deleteAccount()
      : this._(type: AuthType.deleteAccount);


  @override
  String get endpoint => APIEndpoint.apiURL;

  String get path {
    switch (type) {
      case AuthType.login:
        return "/development/login";
      case AuthType.logout:
        return "/development/logout";
      case AuthType.userProfile:
        return "/development/users/${userID}/profile";
      case AuthType.settings:
        return "/development/config";
      case AuthType.register:
        return "/development/register/step/1";

      case AuthType.forgetPass:
        return "/development/forget-password";

      case AuthType.resetPass:
        return "/development/reset-password/${resetPassToken}";

      case AuthType.verifyUser:
        return "/development/register/step/2";
      case AuthType.registerStep3:
        return "/development/register/step/3";
      case AuthType.governorate:
        return "/development/cities";
      case AuthType.educationLevels:
        return "/development/groups";
      case AuthType.organizations:
        return "/development/organizations";
      case AuthType.updateProfile:
        return "/development/panel/profile-setting";
      case AuthType.updatePass:
        return "/development/panel/profile-setting/password";

        case AuthType.updateUserImage:
        return "/development/panel/profile-setting/images";
      case AuthType.deleteAccount:
        return "/development/panel/delete-user";

      default:
        return "";
    }
  }

  @override
  HTTPMethod get method {
    switch (type) {
      case AuthType.userProfile:
      case AuthType.settings:
      case AuthType.educationLevels:
      case AuthType.governorate:
      case AuthType.organizations:
      case AuthType.deleteAccount:
        return HTTPMethod.get;
      case AuthType.updateProfile:
      case AuthType.updatePass:
        return HTTPMethod.put;

      default:
        return HTTPMethod.post;
    }
  }

  Map<String, String> get headers => {
        HttpHeaders.contentTypeHeader: 'application/json',
        'x-api-key': '1234321',
         "X-Locale" : storage.lang??"ar",
        'Authorization': storage.apiToken == null ? "" : ("Bearer "+storage.apiToken!)
      };

  Map<String, String> get query {
    switch (type) {
      case AuthType.educationLevels:
        return {
          HttpHeaders.contentTypeHeader: 'application/json',
          "organ_id": organID.toString()
        };

      case AuthType.organizations:
        return {
          HttpHeaders.contentTypeHeader: 'application/json',
          "city_id": cityId.toString()
        };

      default:
        return {HttpHeaders.contentTypeHeader: 'application/json'};
    }
  }

  @override
  Map<dynamic, dynamic>? get body {
    switch (type) {
      case AuthType.login:
        return loginRequest;
      case AuthType.register:
        return registerRequest;
      case AuthType.updateProfile:
        return registerRequest;

      case AuthType.registerStep3:
        return registerStep3Request;
        case AuthType.updatePass:
        return updatePassRequest;
      case AuthType.resetPass:
        return resetPassRequest;

      case AuthType.forgetPass:
        return forgetPassRequest;

      case AuthType.verifyUser:
        return verifyUserRequest;
      case AuthType.logout:
        return null;
      default:
        return null;
    }
  }

  Future request() {
    switch (type) {
      case AuthType.updateUserImage:
        return updateUserImageRequest();
      default:
        return APIProvider.instance.request(this, type: 0);
    }
  }

  @override
  String get url => endpoint + path;

  @override
  // TODO: implement contentType
  String? get contentType => null;

  Future updateUserImageRequest() async {

    var multipartFile;
    print("attachedFile55");
    print(userImage);
    if (userImage != null) {
      // open a bytestream
      var stream =
      http.ByteStream(DelegatingStream.typed(userImage!.openRead()));
      // get file length
      var length = await userImage!.length();
      multipartFile = http.MultipartFile('profile_image', stream, length,
          filename: basename(userImage!.path));
      print("attachedFile55");
      print(multipartFile);
    }


    // string to uri
    var uri = Uri.parse(url);

    // create multipart request
    var request = http.MultipartRequest("POST", uri);

    // multipart that takes file
    // var multipartFile = new http.MultipartFile('file', stream, length,
    //     filename: basename(imageFile.path));

    request.headers.addAll(headers);
    // add file to multipart
    if (multipartFile != null)  request.files.add(multipartFile);


    // send
    var response = await request.send();
    print(response.statusCode);
    //return response;
    Completer completer =  Completer();

    // listen for response
    var body;
    response.stream.transform(utf8.decoder).listen((value) {
      print("value");
      print(value);
      body= value;
      completer.complete( APIProvider.instance.returnResponse(Response(statusCode: response.statusCode,body: {
        "data":  jsonDecode(body)
      }))["data"]);
    });
    return completer.future;
  }




}
