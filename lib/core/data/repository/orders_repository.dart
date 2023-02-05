import 'dart:convert';

import 'package:albarakakitchen/core/data/models/apis/maintenance_request.dart';
import 'package:albarakakitchen/core/data/models/apis/order_model.dart';
import 'package:albarakakitchen/core/data/network/endpoints/order_enpoints.dart';
import 'package:albarakakitchen/core/utils/network_util.dart';

import '../network/network_config.dart';

class OrdersRepository {
  static Map<String, String> headers = {
    "accept": "application/json",
    "Content-Type": "application/json"
  };

  Future<List<OrderModel>> getAllTechOrders() async {
    return NetworkUtil.get(
      url: OrdersEndpoints.getAllTechOrders,
      params: {},
      headers: NetworkConfig.getAuthHeaders(headers),
    ).then((response) {
      List<OrderModel> result = [];

      final morningPeriodOrders = (response['morningPeriodOrders'] as Iterable)
          .map((order) => OrderModel.fromJson(order))
          .toList();

      final eveningPeriodOrders = (response['eveningPeriodOrders'] as Iterable)
          .map((order) => OrderModel.fromJson(order))
          .toList();
      result.addAll(morningPeriodOrders);
      result.addAll(eveningPeriodOrders);
      return result;
    });
  }

  Future<List<MaintenanceRequest>> getAllMaintenanceRequest() async {
    return NetworkUtil.get(
      url: OrdersEndpoints.getAllMaintenanceRequest,
      params: {},
      headers: NetworkConfig.getAuthHeaders(headers),
    ).then((response) {
      List<MaintenanceRequest> result = [];

      final allRequest = (response as Iterable)
          .map((order) => MaintenanceRequest.fromJson(order))
          .toList();

      result.addAll(allRequest);
      return result;
    });
  }

  Future<bool> measuringVisit({
    required String orderId,
    required List<String> measurmentImages,
    required List<String> kitchenBeforeImages,
    required List<String> kitchenVideo,
    required String actualKitchenHeight,
    required String visitNotes,
    required String wallASize,
    required String wallBSize,
    required String wallCSize,
    required String wallDSize,
    required String washtubCenter,
  }) async {
    return NetworkUtil.postMultipartArry(
        url: OrdersEndpoints.masuringVisit,
        headers: NetworkConfig.getAuthHeaders(headers),
        fields: {
          'orderId': orderId,
          'visitNotes': visitNotes,
          'actualKitchenHeight': actualKitchenHeight,
          'wallASize': wallASize,
          'wallBSize': wallBSize,
          'wallCSize': wallCSize,
          'wallDSize': wallDSize,
          'washtubCenter': washtubCenter,
        },
        files: {
          'measurmentImages': measurmentImages,
          'kitchenBeforeImages': kitchenBeforeImages,
          'kitchenVideo': kitchenVideo
        }).then((dynamic response) {
      return true;
    });
  }

  Future<bool> installingVisit({
    required String orderId,
  }) async {
    return NetworkUtil.post(
      url: OrdersEndpoints.installingVisit,
      headers: NetworkConfig.getAuthHeaders(headers),
      params: {"id": orderId},
    ).then((dynamic response) {
      return true;
    });
  }

  Future<bool> installingSuccessfully({
    required String orderId,
    required List<String> images,
  }) async {
    return NetworkUtil.postMultipartArry(
        url: OrdersEndpoints.installingSuccessfully,
        headers: NetworkConfig.getAuthHeaders(headers),
        fields: {
          'orderId': orderId,
        },
        files: {
          'kitchenAfterImages': images,
        }).then((dynamic response) {
      return true;
    });
  }

  Future<bool> installingWithIssue({
    required String orderId,
    required List<String> kitchenIssueImages,
    required String installingIssueDetails,
  }) async {
    return NetworkUtil.postMultipartArry(
        url: OrdersEndpoints.installingWithIssue,
        headers: NetworkConfig.getAuthHeaders(headers),
        fields: {
          'orderId': orderId,
          'installingIssueDetails': installingIssueDetails
        },
        files: {
          'kitchenIssueImages': kitchenIssueImages,
        }).then((dynamic response) {
      return true;
    });
  }

  Future<bool> requestInstallingWithIssue({
    required String requestId,
    required String requestIssueDetails,
  }) async {
    return NetworkUtil.post(
      url: OrdersEndpoints.requestInstallingWithIssue,
      headers: NetworkConfig.getAuthHeaders(headers),
      body: jsonEncode(
          {'id': requestId, 'requestIssueDetails': requestIssueDetails}),
    ).then((dynamic response) {
      return true;
    });
  }

  Future<bool> insertBeforeProcessImages({
    required String requestId,
    required List<String> images,
  }) async {
    return NetworkUtil.postMultipartArry(
        url: OrdersEndpoints.insertBeforeProcessImages,
        headers: NetworkConfig.getAuthHeaders(headers),
        fields: {
          'id': requestId,
        },
        files: {
          'requestBeforeImages': images,
        }).then((dynamic response) {
      return true;
    });
  }

  Future<bool> completeRequestProcess({
    required String requestId,
    required List<String> images,
  }) async {
    return NetworkUtil.postMultipartArry(
        url: OrdersEndpoints.completeRequestProcess,
        headers: NetworkConfig.getAuthHeaders(headers),
        fields: {
          'id': requestId,
        },
        files: {
          'requestAfterProcessImages': images,
        }).then((dynamic response) {
      return true;
    });
  }
}
