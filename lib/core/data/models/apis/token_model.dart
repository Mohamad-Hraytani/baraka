import 'package:jwt_decoder/jwt_decoder.dart';

class TokenModel {
  String? accessToken;
  String? refrechToken;
  int? expiresIn;
  String? uniqueName;
  List<dynamic>? claims;

  TokenModel(
      {this.accessToken, this.refrechToken, this.expiresIn, this.claims});

  TokenModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refrechToken = json['refrechToken'];
    expiresIn = json['expiresIn'];
    claims = json['accessToken'] == null
        ? null
        : JwtDecoder.decode(json['accessToken'])['claims'];
    uniqueName = json['accessToken'] == null
        ? null
        : JwtDecoder.decode(json['accessToken'])['unique_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['refrechToken'] = this.refrechToken;
    data['expiresIn'] = this.expiresIn;
    data['claims'] = this.claims;
    data['unique_name'] = this.uniqueName;
    return data;
  }
}
