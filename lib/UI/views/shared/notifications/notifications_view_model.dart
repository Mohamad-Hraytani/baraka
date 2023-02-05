import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:albarakakitchen/UI/shared/custom_widgets/custom_toasts.dart';
import 'package:albarakakitchen/UI/shared/utils.dart';
import 'package:albarakakitchen/app/locator.dart';
import 'package:albarakakitchen/app/router.router.dart';
import 'package:albarakakitchen/core/data/models/apis/notification_model.dart';
import 'package:albarakakitchen/core/data/repository/auth_repository.dart';
import 'package:albarakakitchen/core/data/repository/notification_repository.dart';
import 'package:albarakakitchen/core/services/notification_service.dart';
import 'package:albarakakitchen/core/utils/general_utils.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NotificationsViewModel extends BaseViewModel {
  List<NotificationModel> _notifictionList = [];
  List<NotificationModel> get notifictionList => _notifictionList;
  set setNotificationList(List<NotificationModel> value) {
    _notifictionList = value;
    notifyListeners();
  }

  RefreshController _notificationRefreshController =
      RefreshController(initialRefresh: false);

  RefreshController get notificationRefreshController =>
      _notificationRefreshController;
  void load() async {
    try {
      customLoader();
      final response = await locator<NotificationRepository>()
          .getAllNotification(pageIndex: 0, pageSize: 10);
      setNotificationList = response;

      BotToast.closeAllLoading();

      _notificationRefreshController.refreshCompleted();

      notifyListeners();

      log(response.toString());
    } on IOException catch (e) {
      BotToast.closeAllLoading();
      CustomToasts.showMessage(
          message: tr('general_internet_error'),
          messageType: MessageType.errorMessage);
    } catch (e) {
      _notificationRefreshController.refreshCompleted();
      BotToast.closeAllLoading();
      CustomToasts.showMessage(
          message: e.toString(), messageType: MessageType.errorMessage);

      log(e.toString());
    }
  }

  void deleteCardRequest({required String id}) {
    runBusyFutureWithLoader(deleteCard(
      id: id,
    ));
  }

  void logoutRequest() {
    runBusyFutureWithLoader(logOut());
  }

  Future deleteCard({required String id}) async {
    try {
      var response =
          await locator<NotificationRepository>().deleteNotification(id: id);

      if (response.toString().isEmpty) {
        load();
      }
    } catch (e) {
      log(e.toString());
    }
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

  void showConfirmDeleteCard({required String id}) async {
    await locator<DialogService>()
        .showDialog(
            title: tr('confirm'),
            description: tr('notification_confirm_delete'),
            buttonTitle: tr('yes'),
            cancelTitle: tr('no'))
        .then((value) {
      if (value!.confirmed) {
        deleteCardRequest(id: id);
      }
    });
  }

  StreamSubscription<dynamic>? _streamSubscription;

  void listenToNewNotification() {
    _streamSubscription =
        NotificationService.stream.listen((notificationModel) {
      _notificationRefreshController.requestRefresh();

      notifyListeners();
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _notificationRefreshController.dispose();

    super.dispose();
  }
}
