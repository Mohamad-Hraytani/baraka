import 'dart:developer';

import 'package:albarakakitchen/UI/shared/custom_widgets/custom_toasts.dart';
import 'package:albarakakitchen/app/locator.dart';
import 'package:albarakakitchen/core/data/models/apis/order_model.dart';
import 'package:albarakakitchen/core/data/repository/orders_repository.dart';
import 'package:albarakakitchen/core/services/notification_service.dart';
import 'package:albarakakitchen/core/services/order_service.dart';
import 'package:albarakakitchen/core/utils/general_utils.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class InstallationDetailsViewModel extends ReactiveViewModel {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;
  List<String> installationImages = ['add'];
  final OrderService _orderService = locator<OrderService>();
  late OrderModel _order;
  void setOrder(OrderModel val) {
    _order = val;
  }

  OrderModel get orderFromModel => _order;

  void addImage(int type, List<String> imageList) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
    ].request();
    if (statuses.containsValue(PermissionStatus.denied) ||
        statuses.containsValue(PermissionStatus.permanentlyDenied)) {
      log('no permission');
    } else {
      final result = await ImagePicker().pickImage(
        imageQuality: 70,
        maxWidth: 1440,
        source: type == 1 ? ImageSource.camera : ImageSource.gallery,
      );
      if (result != null) {
        log(result.path);
        imageList.add(result.path);
        notifyListeners();

        print(result.path);
      } else {
        // User canceled the picker
      }
    }
  }

  void imagesOnCancelClicked(List<String> newImages) {
    installationImages = newImages;
    notifyListeners();
  }

  void installingVisit(OrderModel order) async {
    try {
      customLoader();
      final response = await locator<OrdersRepository>().installingVisit(
        orderId: order.id!,
      );
      _orderService.installationVisit(order);
      _order.actions!.setOrdersStartInstaillingProcess = false;
      _order.actions!.setOrdersReportInstallationIssue = true;
      _order.actions!.setOrdersCompleteInstallingProcess = true;
      notifyListeners();

      BotToast.closeAllLoading();

      log(response.toString());
    } catch (e) {
      BotToast.closeAllLoading();
      CustomToasts.showMessage(
          message: e.toString(), messageType: MessageType.errorMessage);

      log(e.toString());
    }
  }

  submit(String orderId) async {
    if (installationImages.length<=1) {
      CustomToasts.showMessage(
          message: tr('order_enter_installation_image'),
          messageType: MessageType.errorMessage);
      return;
    }

    try {
      customLoader();
      final response = await locator<OrdersRepository>()
          .installingSuccessfully(orderId: orderId, images: installationImages);

      BotToast.closeAllLoading();
      locator<NavigationService>().back(result: true);
      NotificationService.streamController.add('installation_complete');

      log(response.toString());
    } catch (e) {
      BotToast.closeAllLoading();
      CustomToasts.showMessage(
          message: e.toString(), messageType: MessageType.errorMessage);

      log(e.toString());
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_orderService];
}
