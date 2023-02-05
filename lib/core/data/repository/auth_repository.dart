import 'dart:convert';

import 'package:albarakakitchen/core/data/models/apis/token_model.dart';
import 'package:albarakakitchen/core/data/network/endpoints/auth_endpoints.dart';
import 'package:albarakakitchen/core/utils/network_util.dart';

import '../network/network_config.dart';

class AuthenticationRepository {
  static Map<String, String> headers = {
    "accept": "application/json",
    "Content-Type": "application/json"
  };

  Future<TokenModel> login({
    required String username,
    required String password,
  }) async {
    return NetworkUtil.post(
        url: AuthEndPoints.token,
        params: {},
        headers: NetworkConfig.getHeaders(headers),
        body: jsonEncode({
          "grantType": "password",
          "username": username,
          "password": password
        })).then((dynamic response) {
      return TokenModel.fromJson(response);
    });
  }

  Future<dynamic> logout() async {
    return NetworkUtil.post(
        url: AuthEndPoints.logout,
        params: {},
        headers: NetworkConfig.getAuthHeaders(headers),
        body: jsonEncode({})).then((dynamic response) {
      return response;
    });
  }

  // Future<Either<Map, bool>> contactUsRequest(
  //     {required String message,
  //     required String subject,
  //     required String mobile}) async {
  //   Map<String, String> _fields = {
  //     'delivery_ability': "0",
  //     'traffic_accident': "0",
  //     'message': message,
  //     'subject': subject,
  //     'mobile': mobile,
  //     'type': 'Customer',
  //   };
  //   try {
  //     String _url = ProviderEndPoints().contactUs;
  //     return NetworkUtil.postMultipart(
  //             url: _url,
  //             headers: storage.getLoggedIn()
  //                 ? NetworkConfig.getAuthHeaders(headers)
  //                 : NetworkConfig.getHeaders(headers),
  //             fields: _fields)
  //         .then((response) {
  //       CommonResponseV1 commonResponse =
  //           CommonResponseV1<bool>.fromJson(response);
  //       if (commonResponse.status ?? false) {
  //         return Right(commonResponse.status ?? false);
  //       } else {
  //         return Left(commonResponse.getError);
  //       }
  //     });
  //   } catch (e) {
  //     log(e.toString());
  //     return Left(unKnownError);
  //   }
  // }
}
