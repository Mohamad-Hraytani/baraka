import 'dart:async';
import 'dart:developer';

import 'package:albarakakitchen/UI/shared/utils.dart';
import 'package:albarakakitchen/app/locator.dart';
import 'package:albarakakitchen/app/router.router.dart';
import 'package:albarakakitchen/core/data/models/apis/maintenance_request.dart';
import 'package:albarakakitchen/core/services/notification_service.dart';
import 'package:albarakakitchen/core/utils/general_utils.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';
import 'package:albarakakitchen/core/services/order_service.dart';
import 'package:albarakakitchen/core/data/repository/auth_repository.dart';

class MaintenanceRequetViewModel extends BaseViewModel {
  List<MaintenanceRequest> requestsList = [];
  final OrderService _orderService = locator<OrderService>();

  RefreshController _requestListRefreshController =
      RefreshController(initialRefresh: false);

  RefreshController get requestListRefreshController =>
      _requestListRefreshController;

  void load() async {
    customLoader();
    await locator<OrderService>().loadMaintenanceRequests();
    BotToast.closeAllLoading();
    _requestListRefreshController.refreshCompleted();
    requestsList = _orderService.requestList;
    notifyListeners();
  }

  StreamSubscription<dynamic>? _streamSubscription;
  void listenToNewNotification() {
    _streamSubscription =
        NotificationService.stream.listen((notificationModel) {
      _requestListRefreshController.requestRefresh();

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
}
