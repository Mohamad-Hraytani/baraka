import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:http_parser/http_parser.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;

///! Network Util Class -> A utility class for handling network operations
class NetworkUtil {
  //------------------------------------------------------------- Variables ---------------------------------------------------------------------------
  // JsonDecoder object
  static final JsonDecoder _decoder = new JsonDecoder();
  static String? baseUrl;

  static IOClient getHttpClient() {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return new IOClient(ioc);
  }

  //!------------------------------------------------------------- Methods -----------------------------------------------------------------------------

  static Future<dynamic> get(
      {required String? url,
      Map<String, String>? headers,
      Map<String, String>? params}) async {
    if (params == null) {
      params = {};
    }
    var uri = Uri.http(baseUrl!, url!, params);

    http.Response response = await getHttpClient()
        .get(uri, headers: headers); // Make HTTP-GET request

    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 400) {
      throw CustomNetWorkException(response.bodyBytes, response.statusCode);
    } else {
      final String res = Utf8Codec().decode(response.bodyBytes);
      return _decoder.convert(res);
    }
  }

  static Future<dynamic> post(
      {required String? url,
      Map<String, String>? headers,
      Map<String, dynamic>? params,
      body,
      encoding}) async {
    if (params == null) {
      params = {};
    }
    var uri = Uri.http(baseUrl!, url!, params);

    http.Response response = await getHttpClient()
        .post(uri, body: body, headers: headers, encoding: encoding);

    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 400) {
      throw CustomNetWorkException(response.bodyBytes, response.statusCode);
    } else {
      final String res = response.body;
      return res.isNotEmpty ? _decoder.convert(res) : res;
    }
  }

  static Future<dynamic> postMultipart({
    @required String? url,
    Map<String, String>? headers,
    Map<String, String>? fields,
    Map<String, String>? files,
    Map<String, dynamic>? params,
  }) async {
    if ([null].contains(files)) {
      files = {};
    }
    if ([null].contains(params)) {
      params = {};
    }
    var request =
        http.MultipartRequest('POST', Uri.http(baseUrl!, url!, params!));
    var _filesKeyList = files?.keys.toList();
    var _filesNameList = files?.values.toList();
    for (int i = 0; i < _filesKeyList!.length; i++) {
      if (_filesNameList![i] != "") {
        var multipartFile = http.MultipartFile.fromPath(
          _filesKeyList[i],
          _filesNameList[i],
          filename: path.basename(_filesNameList[i]),
          //
          // use the real name if available, or omit
          contentType: getContentType(_filesNameList[i]),
        );
        request.files.add(await multipartFile);
      }
    }
    request.headers.addAll(headers!);
    request.fields.addAll(fields!);
    var response = await request.send();
    String jsonResponse;
    try {
      var value = await response.stream.toBytes();

      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode >= 400) {
        throw CustomNetWorkException(value, response.statusCode);
      } else {
        jsonResponse = value.toString();
        return _decoder.convert(jsonResponse);
      }
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }

  static String getUrlWithParams(String url, Map<String, String> params) {
    String strUrl = url;
    var _paramsKeyList = params.keys.toList();
    var _paramsValueList = params.values.toList();
    for (var i = 0; i < params.length; i++) {
      if (i == 0) {
        strUrl += '?' + _paramsKeyList[i] + '=' + _paramsValueList[i];
      } else {
        strUrl += '&' + _paramsKeyList[i] + '=' + _paramsValueList[i];
      }
    }
    return strUrl;
  }

  static MediaType getContentType(String name) {
    var fileName = name.split('/').last;
    var ext = fileName.split('.').last;
    if (ext == "png" || ext == "jpeg") {
      return MediaType.parse("image/jpg");
    } else if (ext == 'pdf') {
      return MediaType.parse("application/pdf");
    } else {
      return MediaType.parse("image/jpg");
    }
  }

  static Future<dynamic> postMultipartArry({
    required String url,
    required Map<String, String> headers,
    required Map<String, String> fields,
    required Map<String, List<String>?> files,
  }) async {
    var request = http.MultipartRequest('POST', Uri.http(baseUrl!, url));
    var _filesKeyList = files.keys.toList();
    var _filesNameList = files.values.toList();
    for (int i = 0; i < _filesKeyList.length; i++) {
      if (_filesNameList[i] != null) {
        for (int j = 0; j < _filesNameList[i]!.length; j++) {
          {
            if (_filesNameList[i]![j] != 'add' &&
                _filesNameList[i]![j] != 'vid') {
              var multipartFile = http.MultipartFile.fromBytes(
                _filesKeyList[i],
                File(_filesNameList[i]![j]).readAsBytesSync(),
                filename: path.basename(_filesNameList[i]![j]),
              );

              //   var multipartFile = http.MultipartFile.fromPath(
              //   _filesKeyList[i],
              //  _filesNameList[i]![j],
              //  filename: path.basename(_filesNameList[i]![
              //     j]),
              // use the real name if available, or omit
              // contentType: MediaType.parse("image/*"),
              // );

              request.files.add(await multipartFile);
            }
          }
        }
      }
    }

    request.headers.addAll(headers);
    request.fields.addAll(fields);

    var response = await request.send();
    print(response.toString());
    String jsonResponse;
    try {
      var value = await response.stream.toBytes();
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode >= 400) {
        throw CustomNetWorkException(value, response.statusCode);
      } else {
        jsonResponse = value.toString();

        return jsonResponse.isNotEmpty ? _decoder.convert(jsonResponse) : '';
      }
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }
}

class CustomNetWorkException implements Exception {
  Uint8List? cause;
  int code;
  CustomNetWorkException(this.cause, this.code);
  @override
  String toString() {
    final message = (jsonDecode(utf8.decode(cause!)) as Map<String, dynamic>);
    log(message.toString());

    return cause != null && cause!.isNotEmpty ? message.values.first : '';
  }

  int get statusCode => code;
}
