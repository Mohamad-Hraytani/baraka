import 'dart:developer';

import 'package:albarakakitchen/UI/shared/custom_widgets/custom_toasts.dart';
import 'package:albarakakitchen/app/locator.dart';
import 'package:albarakakitchen/app/router.router.dart';
import 'package:albarakakitchen/core/data/repository/account_repository.dart';
import 'package:albarakakitchen/core/data/repository/auth_repository.dart';
import 'package:albarakakitchen/core/data/repository/notification_repository.dart';
import 'package:albarakakitchen/core/data/repository/shared_prefrence_repository.dart';
import 'package:albarakakitchen/core/services/notification_service.dart';
import 'package:albarakakitchen/core/utils/general_utils.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LogInViewModel extends BaseViewModel {
  late String password = '';
  late String userName = '';
  bool showPassword = false;
  final _formKey = GlobalKey<FormState>();
  String? fcm = locator<NotificationService>().token;
  GlobalKey<FormState> get formKey => _formKey;
  void login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        customLoader();
        final response = await locator<AuthenticationRepository>()
            .login(username: userName.trim(), password: password);

        if (response.claims!.contains('Technician') ||
            response.claims!.contains('InstallingTechnician')) {
          if (!getIsPhone()) {
            locator<SharedPreferencesRepository>().saveLoginInfo(response);
            locator<SharedPreferencesRepository>()
                .setLoggedIn(isLoggedIn: true);
            if (fcm != null && fcm!.isNotEmpty) {
              locator<NotificationRepository>()
                  .updateDeviceToken(fcmToke: fcm!);
            } else {
              fcm = await locator<NotificationService>().requistFcmToken();
              locator<NotificationRepository>()
                  .updateDeviceToken(fcmToke: fcm!);
            }

            BotToast.closeAllLoading();

            locator<NavigationService>().replaceWith(Routes.ordersView);
          } else {
            /*  locator<SharedPreferencesRepository>().saveLoginInfo(response);
            locator<SharedPreferencesRepository>()
                .setLoggedIn(isLoggedIn: true);
            if (fcm != null && fcm!.isNotEmpty) {
              locator<NotificationRepository>()
                  .updateDeviceToken(fcmToke: fcm!);
            } else {
              fcm = await locator<NotificationService>().requistFcmToken();
              locator<NotificationRepository>()
                  .updateDeviceToken(fcmToke: fcm!);
            }

            BotToast.closeAllLoading();

            locator<NavigationService>().replaceWith(Routes.ordersView); */
            BotToast.closeAllLoading();
            CustomToasts.showMessage(
                message: tr('please_use_tablet_device'),
                messageType: MessageType.errorMessage);
          }
        } else if (!response.claims!.contains('Technician') ||
            !response.claims!.contains('InstallingTechnician')) {
          locator<SharedPreferencesRepository>().saveLoginInfo(response);
          locator<SharedPreferencesRepository>().setLoggedIn(isLoggedIn: true);
          if (fcm != null && fcm!.isNotEmpty) {
            locator<NotificationRepository>().updateDeviceToken(fcmToke: fcm!);
          } else {
            fcm = await locator<NotificationService>().requistFcmToken();
            locator<NotificationRepository>().updateDeviceToken(fcmToke: fcm!);
          }

          BotToast.closeAllLoading();

          locator<NavigationService>().replaceWith(Routes.notificationsView);
        } else {
          BotToast.closeAllLoading();
          CustomToasts.showMessage(
              message: tr('login_dont_have_permission'),
              messageType: MessageType.errorMessage);
        }
        log(response.toString());
      } catch (e) {
        BotToast.closeAllLoading();
        CustomToasts.showMessage(
            message: e.toString(), messageType: MessageType.errorMessage);

        log(e.toString());
      }
    }
  }

  void toggleShowPassword() {
    showPassword = !showPassword;
    notifyListeners();
  }

  String? passwordValidator(String? val) {
    if (val != null && val.isNotEmpty) return null;
    return tr('login_please_password');
  }

  String? userNameValidator(String? val) {
    if (val != null && val.isNotEmpty) return null;
    return tr('login_please_username');
  }

  passwordOnSave(String? val) {
    if (val != null && val.isNotEmpty) password = val;
  }

  userNameOnSave(String? val) {
    if (val != null && val.isNotEmpty) userName = val;
  }

  Future<bool> changeLanguage({required bool isEnglish}) async {
    try {
      customLoader();
      await locator<AccountRepository>()
          .changeAccountLanguage(isEnglash: isEnglish);
      BotToast.closeAllLoading();
      return true;
    } catch (e) {
      BotToast.closeAllLoading();
      CustomToasts.showMessage(
          message: e.toString(), messageType: MessageType.errorMessage);

      log(e.toString());
      return false;
    }
  }
}
