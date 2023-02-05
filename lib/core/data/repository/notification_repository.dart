import 'dart:convert';
import 'dart:developer';

import 'package:albarakakitchen/app/locator.dart';
import 'package:albarakakitchen/core/data/models/apis/notification_model.dart';
import 'package:albarakakitchen/core/data/network/endpoints/notification_endpoints.dart';
import 'package:albarakakitchen/core/services/device_info_service.dart';
import 'package:albarakakitchen/core/utils/network_util.dart';

import '../network/network_config.dart';

class NotificationRepository {
  static Map<String, String> headers = {
    "accept": "application/json",
    "Content-Type": "application/json"
  };

  Future<List<NotificationModel>> getAllNotification({
    required int pageIndex,
    required int pageSize,
  }) async {
    return NetworkUtil.get(
      url: NotificationEndpoint.getUserNotifications,
      params: {
        'pageIndex': pageIndex.toString(),
        'pageSize': pageSize.toString(),
      },
      headers: NetworkConfig.getAuthHeaders(headers),
    ).then((dynamic response) {
      return (response['items'] as Iterable)
          .map((order) => NotificationModel.fromJson(order))
          .toList();
    });
  }

  Future<void> updateDeviceToken({
    required String fcmToke,
  }) async {
    return NetworkUtil.post(
        url: NotificationEndpoint.updateDeviceToken,
        params: {},
        headers: NetworkConfig.getAuthHeaders(headers),
        body: jsonEncode({
          'deviceId': locator<DeviceInfoService>().getDeviceId,
          'fcmToken': fcmToke
        })).then((dynamic response) {
      log(response);
    });
  }

  Future<dynamic> deleteNotification({
    required String id,
  }) async {
    return NetworkUtil.post(
        url: NotificationEndpoint.deleteNotification,
        params: {},
        headers: NetworkConfig.getAuthHeaders(headers),
        body: jsonEncode({
          'id': id,
        })).then((dynamic response) {
      log(response);
      return response;
    });
  }
}
