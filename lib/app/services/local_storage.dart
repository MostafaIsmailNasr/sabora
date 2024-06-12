import 'dart:convert';

import '../../data/models/auth/User.dart';
import '../../data/models/settings/SettingsResponse.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum _Key {
  user,
  apiToken,
  isFirsLaunch,
  userID,
  lang,
  config
}

class LocalStorageService extends GetxService {
  SharedPreferences? _sharedPreferences;
  Future<LocalStorageService> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  User? get user {
    final rawJson = _sharedPreferences?.getString(_Key.user.toString());
    if (rawJson == null) {
      return null;
    }
    Map<String, dynamic> map = jsonDecode(rawJson);
    return User.fromJson(map);
  }

  set user(User? value) {
    if (value != null) {
      _sharedPreferences?.setString(
          _Key.user.toString(), json.encode(value.toJson()));
    } else {
      _sharedPreferences?.remove(_Key.user.toString());
    }
  }


  String? get apiToken {
    final token = _sharedPreferences?.getString(_Key.apiToken.toString());
    if (token == null) {
      return null;
    }

    return token;
  }

  set apiToken(String? value) {
    if (value != null) {
      _sharedPreferences?.setString(
          _Key.apiToken.toString(),value);
    } else {
      _sharedPreferences?.remove(_Key.apiToken.toString());
    }
  }

  String? get lang {
    final lang = _sharedPreferences?.getString(_Key.lang.toString());
    if (lang == null) {
      return "ar";
    }

    return lang;
  }

  set lang(String? value) {
    if (value != null) {
      _sharedPreferences?.setString(
          _Key.lang.toString(),value);
    } else {
      _sharedPreferences?.remove(_Key.lang.toString());
    }
  }


  String? get userID {
    final userID = _sharedPreferences?.getString(_Key.userID.toString());
    if (userID == null) {
      return null;
    }

    return userID;
  }

  set userID(String? value) {
    if (value != null) {
      _sharedPreferences?.setString(
          _Key.userID.toString(),value);
    } else {
      _sharedPreferences?.remove(_Key.userID.toString());
    }
  }




  SettingsResponse? get settingsConfig {
    final rawJson = _sharedPreferences?.getString(_Key.config.toString());
    if (rawJson == null) {
      return null;
    }
    Map<String, dynamic> map = jsonDecode(rawJson);
    return SettingsResponse.fromJson(map);
  }

  set settingsConfig(SettingsResponse? value) {
    if (value != null) {
      _sharedPreferences?.setString(
          _Key.config.toString(), json.encode(value.toJson()));
    } else {
      _sharedPreferences?.remove(_Key.config.toString());
    }
  }


  bool? get isFirsLaunch {
    final isFirstOpen = _sharedPreferences?.getBool(_Key.isFirsLaunch.toString());
    if (isFirstOpen == null) {
      return true;
    }

    return isFirstOpen;
  }

  set isFirsLaunch(bool? value) {
    if (value != null) {
      _sharedPreferences?.setBool(
          _Key.isFirsLaunch.toString(),value);
    } else {
      _sharedPreferences?.remove(_Key.isFirsLaunch.toString());
    }
  }
}
