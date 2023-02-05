import 'dart:developer';
import 'dart:io';

import 'package:package_info/package_info.dart';

import '../../../app/locator.dart';
import '../../services/device_info_service.dart';
import '../repository/shared_prefrence_repository.dart';

class NetworkConfig {
  static const String Auth_Bearer = "Bearer ";
  static String get getDeviceId {
    DeviceInfoService deviceInfoService = locator<DeviceInfoService>();
    return deviceInfoService.getDeviceId;
  }

  static String get getUserAgent {
    PackageInfo packageInfo = locator<PackageInfo>();
    if (Platform.isIOS) {
      return "[EXA-IOS]/" + packageInfo.version;
    } else if (Platform.isAndroid) {
      return "[EXA-Android]/" + packageInfo.version;
    } else {
      return "Error Retriving The Version Number";
    }
  }

  static Map<String, String> getHeaders(Map<String, String> otherHeaders) {
    Map<String, String> headers = {
      'User-Agent': getUserAgent,
      'deviceId': getDeviceId,
      'Accept-Language':
          locator<SharedPreferencesRepository>().getAppLanguage(),
      'NBS-TimeZone': DateTime.now().timeZoneOffset.inSeconds.toString(),
      'NBS-AppName': 'Customer'
    };

    headers.addAll(otherHeaders);
    return headers;
  }

  static Map<String, String> getAuthHeaders(Map<String, String> otherHeaders) {
    SharedPreferencesRepository sharedPreferencesRepository =
        locator<SharedPreferencesRepository>();
    String _authToken = sharedPreferencesRepository.getLoginInfo().accessToken!;

    log("The authToken is $_authToken");
    Map<String, String> authHeaders = {
      'User-Agent': getUserAgent,
      'Accept-Language':
          locator<SharedPreferencesRepository>().getAppLanguage(),
      'Authorization': Auth_Bearer + (_authToken),
      'deviceId': getDeviceId,
      'NBS-TimeZone': DateTime.now().timeZoneOffset.inSeconds.toString(),
      'NBS-AppName': 'Customer'
    };
    authHeaders.addAll(otherHeaders);
    return authHeaders;
  }
}
