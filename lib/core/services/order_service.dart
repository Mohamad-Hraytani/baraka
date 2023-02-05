import 'dart:developer';

import 'package:albarakakitchen/app/locator.dart';
import 'package:albarakakitchen/core/data/models/apis/maintenance_request.dart';
import 'package:albarakakitchen/core/data/models/apis/order_model.dart';
import 'package:albarakakitchen/core/data/repository/orders_repository.dart';
import 'package:stacked/stacked.dart';

class OrderService with ReactiveServiceMixin {
  //1

  //2
  ReactiveValue<List<OrderModel>> _orderList =
      ReactiveValue<List<OrderModel>>([]);
  List<OrderModel> get orderList => _orderList.value;

  ReactiveValue<List<MaintenanceRequest>> _requestList =
      ReactiveValue<List<MaintenanceRequest>>([]);
  List<MaintenanceRequest> get requestList => _requestList.value;

  Future<void> loadOrders() async {
    try {
      final response = await locator<OrdersRepository>().getAllTechOrders();
      _orderList.value = response;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> loadMaintenanceRequests() async {
    try {
      final response =
          await locator<OrdersRepository>().getAllMaintenanceRequest();
      _requestList.value = response;
    } catch (e) {
      log(e.toString());
    }
  }

  void installationVisit(OrderModel order) {
    final index = _orderList.value.indexOf(order);
    if (index >= 0) {
      _orderList.value[index].actions!.setOrdersStartInstaillingProcess = false;
      _orderList.value[index].actions!.setOrdersReportInstallationIssue = true;
      _orderList.value[index].actions!.setOrdersCompleteInstallingProcess =
          true;
    }

    notifyListeners();
  }
}
