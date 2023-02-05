import 'package:albarakakitchen/core/data/network/network_constants.dart';

class AuthEndPoints {
  static String token = NetworkConstants.getFullURL('Auth/Token');
  static String logout = NetworkConstants.getFullURL('Auth/Logout');
}
