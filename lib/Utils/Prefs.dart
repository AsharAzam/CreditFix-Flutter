import 'dart:convert';

import 'package:core/Models/User.dart';

import '../Services/SocialLogin.dart';
import 'Const.dart';
import 'PreferencesHelper.dart';

class Prefs {
  static Future<String?> get getFCMToken {
    return PreferencesHelper.getString(Const.FCM_TOKEN);
  }

  static Future setFCMToken(String value) {
    return PreferencesHelper.setString(Const.FCM_TOKEN, value);
  }

  static void removeFCMToken() {
    PreferencesHelper.remove(Const.FCM_TOKEN);
  }

  // static Future<SocialUser> get getAppleCredentials async {
  //   String value = await PreferencesHelper.getString(Const.APPLE_PREFS);
  //   return value != null ? SocialUser.fromJson(json.decode(value)) : null;
  // }

  static Future setAppleCredentials(SocialUser socialUser) {
    return PreferencesHelper.setString(
        Const.APPLE_PREFS, json.encode(socialUser.toMap()));
  }

  static Future<bool> get isSecondLaunch {
    return PreferencesHelper.getBool(Const.ONBOARDING);
  }

  static Future setSecondLaunch(bool value) {
    return PreferencesHelper.setBool(Const.ONBOARDING, value);
  }

  static Future setUser(User user) {
    return PreferencesHelper.setString(Const.USER, json.encode(user.toMap()));
  }

  static Future<void> getUser(Function(User?) success) async {
    String? string = await PreferencesHelper.getString(Const.USER);
    if (string != null) {
      return success(User.fromJson(json.decode(string)));
    } else {
      return success(null);
    }
  }

  static Future<User?> getUserSync() async {
    String? string = await PreferencesHelper.getString(Const.USER);
    if (string != null) {
      return User.fromJson(json.decode(string));
    } else {
      return null;
    }
  }

  static void removeUser() {
    PreferencesHelper.remove(Const.USER);
    // removeFCMToken();
  }
}
