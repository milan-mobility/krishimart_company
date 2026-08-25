import 'dart:convert';

import 'package:get/get.dart';
import 'package:krishi_mart/data/model/user_company_module.dart';
import 'package:krishi_mart/data/pref_helper/pref_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  SharedPreferenceHelper();

  final SharedPreferences _sharedPreference = Get.find<SharedPreferences>();

  Future<void> saveIsLoggedIn(final bool value) async {
    await _sharedPreference.setBool(PrefKeys.isLoggedIn, value);
  }

  bool get isLoggedIn {
    return _sharedPreference.getBool(PrefKeys.isLoggedIn) ?? false;
  }

  Future<void> saveRoleSelected(final bool value) async {
    await _sharedPreference.setBool(PrefKeys.hasUserRoleSelected, value);
  }

  bool get isRoleSelected {
    return _sharedPreference.getBool(PrefKeys.hasUserRoleSelected) ?? false;
  }

  Future<void> saveHasProfileCompleted(final bool value) async {
    await _sharedPreference.setBool(PrefKeys.hasProfileCompleted, value);
  }

  bool get hasProfileCompleted {
    return _sharedPreference.getBool(PrefKeys.hasProfileCompleted) ?? false;
  }

  Future<void> saveUserRole(final String value) async {
    await _sharedPreference.setString(PrefKeys.selectedUserRole, value);
  }

  String get getUserRole {
    return _sharedPreference.getString(PrefKeys.selectedUserRole) ?? '';
  }

  Future<void> saveAuthToken(final String fcmToken) async {
    await _sharedPreference.setString(PrefKeys.authToken, fcmToken);
  }

  String get authToken {
    return _sharedPreference.getString(PrefKeys.authToken) ?? '';
  }

  Future<void> saveUserInfo(final User user) async {
    await _sharedPreference.setString(PrefKeys.user, jsonEncode(user.toJson()));
  }

  User? get getUserInfo {
    final String? userPref = _sharedPreference.getString(PrefKeys.user);

    if (userPref != null && userPref.isNotEmpty) {
      return User.fromJson(jsonDecode(userPref));
    }
    return null;
  }

  Future<void> setLanguageCode(final String value) async {
    await _sharedPreference.setString(PrefKeys.languageCode, value);
  }

  String get getLanguageCode {
    return _sharedPreference.getString(PrefKeys.languageCode) ?? 'en';
  }

  Future<void> saveFcmToken(final String fcmToken) async {
    await _sharedPreference.setString(PrefKeys.fcmToken, fcmToken);
  }

  String? get fcmToken {
    return _sharedPreference.getString(PrefKeys.fcmToken);
  }

  Future<void> clear() async {
    final List<String> arrKeysToKeep = <String>[];

    final Set<String> keys = _sharedPreference.getKeys();
    for (String key in keys.toList()) {
      if (!arrKeysToKeep.contains(key)) {
        _sharedPreference.remove(key);
      }
    }
  }
}
