import 'package:albarakakitchen/core/data/network/network_constants.dart';

class AccountEndPoints {
  static String changeAccountLanguage =
      NetworkConstants.getFullURL('Account/ChangeAccountLanguage');
  static String profile = NetworkConstants.getFullURL('Account/Profile');
  static String changeAccountPassword =
      NetworkConstants.getFullURL('Account/ChangeAccountPassword');
}
