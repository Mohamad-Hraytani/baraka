import 'dart:developer';

import 'package:albarakakitchen/UI/shared/custom_widgets/custom_toasts.dart';
import 'package:albarakakitchen/UI/shared/utils.dart';
import 'package:albarakakitchen/app/locator.dart';
import 'package:albarakakitchen/core/data/models/apis/account_model.dart';
import 'package:albarakakitchen/core/data/repository/account_repository.dart';
import 'package:albarakakitchen/core/utils/general_utils.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProfileViewModel extends BaseViewModel {
  AccountModel? _profileInfo;
  AccountModel get profileInfo => _profileInfo!;
  set setProfileInfo(AccountModel value) {
    _profileInfo = value;
  }

  TextEditingController _currentController = TextEditingController();
  TextEditingController get currentController => _currentController;

  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController get newPasswordController => _newPasswordController;

  TextEditingController _confirmController = TextEditingController();
  TextEditingController get confirmController => _confirmController;

  String confirmPassword = '';

  void loadProfile() async {
    try {
      setBusy(true);
      customLoader();
      final response = await locator<AccountRepository>().profile();
      setProfileInfo = response;
      setBusy(false);
      BotToast.closeAllLoading();

      log(response.toString());
    } catch (e) {
      BotToast.closeAllLoading();
      CustomToasts.showMessage(
          message: e.toString(), messageType: MessageType.errorMessage);

      log(e.toString());

      return null;
    }
  }

  void changePassword() async {
    try {
      customLoader();
      final response = await locator<AccountRepository>().changeAccountPassword(
          currenPassword: currentController.text,
          newPassword: newPasswordController.text,
          newPasswordConfirmation: confirmController.text);

      BotToast.closeAllLoading();
      navigationService.back();

      CustomToasts.showMessage(
          message: tr('password_changed_successfully'),
          messageType: MessageType.successMessage);

      log(response.toString());
    } catch (e) {
      BotToast.closeAllLoading();
      CustomToasts.showMessage(
          message: e.toString(), messageType: MessageType.errorMessage);

      log(e.toString());
    }
  }
}
