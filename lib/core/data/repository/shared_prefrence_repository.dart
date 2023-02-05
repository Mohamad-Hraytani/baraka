import 'dart:convert';

import 'package:albarakakitchen/core/data/models/apis/token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/locator.dart';

class SharedPreferencesRepository {
  static const String PREF_TYPE_BOOL = "BOOL";
  static const String PREF_TYPE_INTEGER = "INTEGER";
  static const String PREF_TYPE_DOUBLE = "DOUBLE";
  static const String PREF_TYPE_STRING = "STRING";
  static const String PREF_IS_LOGGED_IN = "IS_LOGGED_IN";
  static const String BASE_URL = "BASE_URL";
  static const String LOCAL_URL = "LOCAL_URL";
  static const String PREF_USER = "PREF_USER";
  static const String PREF_USER_DATA = "PREF_USER_DATA";
  static const String PREF_RES_DATA = "PREF_RES_DATA";
  static const String PREF_APP_LANGUAGE = "PREF_APP_LANGUAGE";
  static const String SHOULD_RELOAD = "SHOULD_RELOAD";
  static const String PREF_ENVIRONMENT = "PREF_ENVIRONMENT";

  SharedPreferences? _preferences;

  static final SharedPreferencesRepository _instance =
      SharedPreferencesRepository._internal();

  factory SharedPreferencesRepository() => _instance;

  SharedPreferencesRepository._internal() {
    _preferences = locator<SharedPreferences>();
  }

  void setLoggedIn({required bool? isLoggedIn}) => setPreference(
      prefName: PREF_IS_LOGGED_IN,
      prefValue: isLoggedIn,
      prefType: PREF_TYPE_BOOL);

  bool getLoggedIn() {
    bool logIn = false;
    if (_preferences!.containsKey(PREF_IS_LOGGED_IN)) {
      logIn = _getPreference(prefName: PREF_IS_LOGGED_IN);
    } else {
      logIn = false;
    }
    return logIn;
  }

  void saveLoginInfo(TokenModel login) {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data = login.toJson();
    String strUser = jsonEncode(data);
    setPreference(
        prefName: PREF_USER, prefValue: strUser, prefType: PREF_TYPE_STRING);
  }

  TokenModel getLoginInfo() {
    Map<String, dynamic> userMap =
        jsonDecode(_getPreference(prefName: PREF_USER));
    TokenModel user = TokenModel.fromJson(userMap);
    return user;
  }

  Future<void> logout() async {
    setLoggedIn(isLoggedIn: false);
    saveLoginInfo(TokenModel());
  }

  void saveAppLanguage({required String langCode}) {
    setPreference(
        prefName: PREF_APP_LANGUAGE,
        prefValue: langCode,
        prefType: PREF_TYPE_STRING);
  }

  String getAppLanguage() {
    if (_preferences!.containsKey(PREF_APP_LANGUAGE)) {
      return _getPreference(prefName: PREF_APP_LANGUAGE);
    } else {
      return 'ar';
    }
  }

  void saveAppEnvironMent({required int env}) {
    setPreference(
        prefName: PREF_ENVIRONMENT,
        prefValue: env,
        prefType: PREF_TYPE_INTEGER);
  }

  int getAppEnvironMent() {
    if (_preferences!.containsKey(PREF_ENVIRONMENT)) {
      return _getPreference(prefName: PREF_ENVIRONMENT);
    } else {
      return 0;
    }
  }

  void setShouldReload({required bool shouldReload}) {
    setPreference(
        prefName: SHOULD_RELOAD,
        prefValue: shouldReload,
        prefType: PREF_TYPE_BOOL);
  }

  bool getShouldReload() {
    if (_preferences!.containsKey(SHOULD_RELOAD)) {
      return _getPreference(prefName: SHOULD_RELOAD);
    } else {
      return false;
    }
  }

  ///Locals

  //--------------------------------------------------- Private Preference Methods ----------------------------------------------------

  void setPreference(
      {required String? prefName,
      required dynamic prefValue,
      required String? prefType}) {
    // Make switch for Preference Type i.e. Preference-Value's data-type
    switch (prefType) {
      // prefType is bool
      case PREF_TYPE_BOOL:
        {
          _preferences!.setBool(prefName!, prefValue);
          break;
        }
      // prefType is int
      case PREF_TYPE_INTEGER:
        {
          _preferences!.setInt(prefName!, prefValue);
          break;
        }
      // prefType is double
      case PREF_TYPE_DOUBLE:
        {
          _preferences!.setDouble(prefName!, prefValue);
          break;
        }
      // prefType is String
      case PREF_TYPE_STRING:
        {
          _preferences!.setString(prefName!, prefValue);
          break;
        }
    }
  }

  dynamic _getPreference({required prefName}) => _preferences!.get(prefName);
}
