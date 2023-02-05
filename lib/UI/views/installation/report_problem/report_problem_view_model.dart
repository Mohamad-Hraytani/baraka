import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:albarakakitchen/UI/shared/custom_widgets/custom_toasts.dart';
import 'package:albarakakitchen/app/locator.dart';
import 'package:albarakakitchen/core/data/repository/orders_repository.dart';
import 'package:albarakakitchen/core/services/notification_service.dart';
import 'package:albarakakitchen/core/utils/general_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ReportProblemViewModel extends BaseViewModel {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;
  String issueNotes = '';
  List<String> images = ['add'];
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
    images = newImages;
    notifyListeners();
  }

  String? issueValidator(String? val) {
    if (val != null && val.isNotEmpty) return null;
    return tr('order_issue_description');
  }

  issueValidatorOnSave(String? val) {
    if (val != null && val.isNotEmpty) issueNotes = val;
  }

  submit(String orderId) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (images.length <= 1) {
        CustomToasts.showMessage(
            message: tr('order_issue_image'),
            messageType: MessageType.errorMessage);
        return;
      }
      try {
        customLoader();
        final response = await locator<OrdersRepository>().installingWithIssue(
          orderId: orderId,
          kitchenIssueImages: images,
          installingIssueDetails: issueNotes,
        );

        BotToast.closeAllLoading();
        locator<NavigationService>().popRepeated(2);
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
