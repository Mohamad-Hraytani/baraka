import 'dart:io';

import 'package:device_info/device_info.dart';

class DeviceInfoService {
  static DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  static DeviceInfoService _deviceInfoService = DeviceInfoService();
  static String _deviceId = "";

  String get getDeviceId => _deviceId;

  static Future<DeviceInfoService> getInstance() async {
    try {
      var _info;
      if (Platform.isAndroid) {
        _info = await _deviceInfoPlugin.androidInfo;
        _deviceId = (_info as AndroidDeviceInfo).androidId;
      } else if (Platform.isIOS) {
        _info = await _deviceInfoPlugin.iosInfo;
        _deviceId = (_info as IosDeviceInfo).identifierForVendor;
      }
    } catch (e) {
      print('device info plagin : $e');
    }
    return _deviceInfoService;
  }
}
