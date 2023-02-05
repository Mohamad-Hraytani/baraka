import 'dart:convert';
import 'dart:developer';

import 'package:albarakakitchen/core/data/models/apis/account_model.dart';
import 'package:albarakakitchen/core/data/network/endpoints/account_endpoints.dart';
import 'package:albarakakitchen/core/utils/network_util.dart';

import '../network/network_config.dart';

class AccountRepository {
  static Map<String, String> headers = {
    "accept": "application/json",
    "Content-Type": "application/json"
  };

  Future<bool> changeAccountLanguage({required bool isEnglash}) async {
    return NetworkUtil.post(
      url: AccountEndPoints.changeAccountLanguage,
      params: {'culture': isEnglash ? 'en' : 'ar'},
      headers: NetworkConfig.getAuthHeaders(headers),
    ).then((response) {
      return true;
    });
  }

  Future<bool> changeAccountPassword({
    required String currenPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    return NetworkUtil.post(
      url: AccountEndPoints.changeAccountPassword,
      params: {},
      body: jsonEncode({
        "currenPassword": currenPassword,
        "newPassword": newPassword,
        "newPasswordConfirmation": newPasswordConfirmation,
      }),
      headers: NetworkConfig.getAuthHeaders(headers),
    ).then((response) {
      return true;
    });
  }

  Future<AccountModel> profile() async {
    return NetworkUtil.get(
      url: AccountEndPoints.profile,
      params: {},
      headers: NetworkConfig.getAuthHeaders(headers),
    ).then((response) {
      log(response.toString());
      return AccountModel.fromJson(response);
    });
  }
}
