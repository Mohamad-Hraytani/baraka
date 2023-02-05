import 'dart:async';
import 'dart:developer';

import 'package:albarakakitchen/UI/shared/custom_widgets/custom_toasts.dart';
import 'package:albarakakitchen/UI/shared/utils.dart';
import 'package:albarakakitchen/app/locator.dart';
import 'package:albarakakitchen/app/router.router.dart';
import 'package:albarakakitchen/core/data/models/apis/order_model.dart';
import 'package:albarakakitchen/core/data/repository/auth_repository.dart';
import 'package:albarakakitchen/core/data/repository/orders_repository.dart';
import 'package:albarakakitchen/core/services/notification_service.dart';
import 'package:albarakakitchen/core/services/order_service.dart';
import 'package:albarakakitchen/core/utils/general_utils.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';

class OrdersViewModel extends ReactiveViewModel {
  List<OrderModel>? ordersList;
  final OrderService _orderService = locator<OrderService>();

  RefreshController _ordersListRefreshController =
      RefreshController(initialRefresh: false);

  RefreshController get ordersListRefreshController =>
      _ordersListRefreshController;

  void load() async {
    customLoader();
    await locator<OrderService>().loadOrders();
    BotToast.closeAllLoading();
    _ordersListRefreshController.refreshCompleted();
    ordersList = _orderService.orderList;
    notifyListeners();
  }

  void installationVisit(OrderModel order) async {
    try {
      customLoader();
      final response = await locator<OrdersRepository>().installingVisit(
        orderId: order.id!,
      );
      BotToast.closeAllLoading();
      _orderService.installationVisit(order);
      notifyListeners();
      log(response.toString());
    } catch (e) {
      BotToast.closeAllLoading();
      CustomToasts.showMessage(
          message: e.toString(), messageType: MessageType.errorMessage);

      log(e.toString());
    }
  }

  StreamSubscription<dynamic>? _streamSubscription;
  void listenToNewNotification() {
    _streamSubscription =
        NotificationService.stream.listen((notificationModel) {
      _ordersListRefreshController.requestRefresh();

      notifyListeners();
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    // _ordersListRefreshController.dispose();

    super.dispose();
  }

  void logoutRequest() {
    runBusyFutureWithLoader(logOut());
  }

    Future<void> logOut() async {
    try {
      var response = await locator<AuthenticationRepository>().logout();

      if (response.toString().isEmpty) {
        storage.logout();
        navigationService.clearStackAndShow(Routes.logInView);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_orderService];
}
