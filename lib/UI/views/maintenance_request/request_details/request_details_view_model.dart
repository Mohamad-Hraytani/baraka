import 'dart:developer';

import 'package:albarakakitchen/UI/shared/custom_widgets/custom_toasts.dart';
import 'package:albarakakitchen/UI/shared/utils.dart';
import 'package:albarakakitchen/app/locator.dart';
import 'package:albarakakitchen/core/data/models/apis/maintenance_request.dart';
import 'package:albarakakitchen/core/services/notification_service.dart';
import 'package:albarakakitchen/core/utils/general_utils.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:albarakakitchen/core/data/repository/orders_repository.dart';

class RequestDetailsViewModel extends BaseViewModel {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  List<String> beforeImages = ['add'];
  List<String> afterImages = ['add'];
  String issueNotes = '';

  MaintenanceRequest _request = MaintenanceRequest();
  MaintenanceRequest get request => _request;
  set setRequestValue(MaintenanceRequest value) {
    _request = value;
  }

  bool _showBefore = false;
  bool get showBefore => _showBefore;
  set setShowBeforeValue(bool value) {
    _showBefore = value;
    notifyListeners();
  }

  bool _showAfter = false;
  bool get showAfter => _showAfter;
  set setShowAfterValue(bool value) {
    _showAfter = value;
    notifyListeners();
  }

  bool _showReport = false;
  bool get showReport => _showReport;
  set setShowReportValue(bool value) {
    _showReport = value;
    notifyListeners();
  }

  bool _showReportField = false;
  bool get showReportField => _showReportField;
  set setShowReportFieldValue(bool value) {
    _showReportField = value;
    notifyListeners();
  }

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
        //imageList.insert(imageList.length - 1, result.path);
        notifyListeners();

        print(result.path);
      } else {
        // User canceled the picker
      }
    }
  }

  void beforeImagesOnCancelClicked(List<String> newImages) {
    beforeImages = newImages;
    notifyListeners();
  }

  void afterImagesOnCancelClicked(List<String> newImages) {
    afterImages = newImages;
    notifyListeners();
  }

  String? issueValidator(String? val) {
    if (val != null && val.isNotEmpty) return null;
    return tr('order_issue_description');
  }

  issueValidatorOnSave(String? val) {
    if (val != null && val.isNotEmpty) issueNotes = val;
  }

  submitBeforeProcess(String requestId) async {
    if (beforeImages.length <= 1) {
      CustomToasts.showMessage(
          message: tr('order_enter_installation_image'),
          messageType: MessageType.errorMessage);
      return;
    }

    try {
      customLoader();
      final response = await locator<OrdersRepository>()
          .insertBeforeProcessImages(
              requestId: requestId, images: beforeImages);

      BotToast.closeAllLoading();
      setShowAfterValue = true;
      setShowBeforeValue = false;
      setShowReportValue = true;
      //navigationService.back(result: true);
      NotificationService.streamController.add('installation_complete');

      log(response.toString());
    } catch (e) {
      BotToast.closeAllLoading();
      CustomToasts.showMessage(
          message: e.toString(), messageType: MessageType.errorMessage);

      log(e.toString());
    }
  }

  submitAfterProcess(String requestId) async {
    if (afterImages.length <= 1) {
      CustomToasts.showMessage(
          message: tr('order_enter_installation_image'),
          messageType: MessageType.errorMessage);
      return;
    }

    try {
      customLoader();
      final response = await locator<OrdersRepository>()
          .completeRequestProcess(requestId: requestId, images: afterImages);

      BotToast.closeAllLoading();
      setShowAfterValue = true;
      setShowBeforeValue = false;
      setShowReportValue = true;
      navigationService.back(result: true);
      NotificationService.streamController.add('installation_complete');

      log(response.toString());
    } catch (e) {
      BotToast.closeAllLoading();
      CustomToasts.showMessage(
          message: e.toString(), messageType: MessageType.errorMessage);

      log(e.toString());
    }
  }

  submitReportProblem(String requestId) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        customLoader();
        final response =
            await locator<OrdersRepository>().requestInstallingWithIssue(
          requestId: requestId,
          requestIssueDetails: issueNotes,
        );

        BotToast.closeAllLoading();
        navigationService.back();
        NotificationService.streamController.add('report_order');

        log(response.toString());
      } catch (e) {
        BotToast.closeAllLoading();
        CustomToasts.showMessage(
            message: e.toString(), messageType: MessageType.errorMessage);

        log(e.toString());
      }
    }
  }
}
