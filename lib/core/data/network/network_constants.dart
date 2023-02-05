import 'dart:io';

class NetworkConstants {
  static const String BASE_API = '/api/v1/';
  static const String BASE_PROVIDER_API = '/API/alphameal-provider/';
  static const String NEW_BASE_API = '/API/v1/';
  static const String BASE_IMAGE = '/API/images/';
  static const String BASE_EXTENSION = '.php';
  static const String USER_TYPE = '4';

  static String get dEVICETYPE => Platform.isAndroid ? 'android' : 'iphone';

  static String getFullURL(String apiName) {
    return BASE_API + apiName;
  }

  static String getNewFullURL(String route, String apiName) {
    return NEW_BASE_API +
        route +
        '/' +
        apiName +
        NetworkConstants.BASE_EXTENSION;
  }

  static String getImageFullURL(String? imageName) {
    return 'https://alphamealstorageaccount.blob.core.windows.net/alphamealstorage/' +
        imageName!;
  }

  static String getProviderFullURL(String apiName) {
    return BASE_PROVIDER_API + apiName + NetworkConstants.BASE_EXTENSION;
  }
}
