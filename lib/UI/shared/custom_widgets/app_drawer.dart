import 'dart:developer';

import 'package:albarakakitchen/UI/shared/colors.dart';
import 'package:albarakakitchen/UI/shared/custom_widgets/custom_toasts.dart';
import 'package:albarakakitchen/UI/shared/utils.dart';
import 'package:albarakakitchen/app/locator.dart';
import 'package:albarakakitchen/app/router.router.dart';
import 'package:albarakakitchen/core/data/repository/account_repository.dart';
import 'package:albarakakitchen/core/data/repository/shared_prefrence_repository.dart';
import 'package:albarakakitchen/core/services/localization_service/chagne_local.dart';
import 'package:albarakakitchen/core/utils/general_utils.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
    required bool enLocal,
    required bool arLocal,
    required this.logOut,
    required this.reloadOrder,
    required bool fromOrder,
  })  : _enLocal = enLocal,
        _fromOrder = fromOrder,
        _arLocal = arLocal,
        super(key: key);

  final bool _enLocal;
  final bool _arLocal;
  final bool _fromOrder;
  final Function() logOut;
  final Function() reloadOrder;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 20),
          Container(
            // margin: const EdgeInsets.only(top: 20),
            width: double.infinity,
            height: MediaQuery.of(context).size.shortestSide * 0.3,
            child: Image.asset(
              'assets/pngs/trans_logo.png',
              // fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: size.height / 25,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getIsPhone() ? size.width / 20 : size.height / 20),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    ChangeLocalService.showAndChangeLocals(
                      context,
                      enTap: () async {
                        if (!_enLocal) {
                          storage.saveAppLanguage(langCode: 'en');
                          final respose = await changeLanguage(isEnglish: true);
                          if (respose) {
                            storage.saveAppLanguage(langCode: 'en');
                            EasyLocalization.of(context)
                                ?.setLocale(Locale('en', 'US'));
                          } else {
                            CustomToasts.showMessage(
                                message: tr('faild_to_change_language'),
                                messageType: MessageType.errorMessage);
                          }
                        }
                      },
                      arTap: () async {
                        if (!_arLocal) {
                          storage.saveAppLanguage(langCode: 'ar');
                          final respose =
                              await changeLanguage(isEnglish: false);
                          if (respose) {
                            storage.saveAppLanguage(langCode: 'ar');
                            EasyLocalization.of(context)
                                ?.setLocale(Locale('ar', 'SA'));
                          } else {
                            CustomToasts.showMessage(
                                message: tr('faild_to_change_language'),
                                messageType: MessageType.errorMessage);
                          }

                          // navigationService.clearStackAndShow(Routes.splashScreenView);
                        }
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.language,
                        color: AppColors.mainDarkRedColor,
                        size: getIsPhone() ? 20 : 25,
                      ),
                      SizedBox(
                        width: size.height / 35,
                      ),
                      Text(
                        tr(
                          'general_language',
                        ),
                        style: TextStyle(
                            fontSize: getIsPhone()
                                ? size.width / 23
                                : size.height / 30,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                if (!getIsPhone() &&
                    storage
                        .getLoginInfo()
                        .claims!
                        .contains('InstallingTechnician'))
                  SizedBox(
                    height: size.height / 25,
                  ),
                if (!getIsPhone() &&
                    storage
                        .getLoginInfo()
                        .claims!
                        .contains('InstallingTechnician'))
                  InkWell(
                    onTap: () async {
                      navigationService.back();

                      navigationService.replaceWith(_fromOrder
                          ? Routes.maintenanceRequestView
                          : Routes.ordersView);
                    },
                    child: Row(
                      children: [
                        Icon(
                          _fromOrder ? Icons.settings : Icons.library_books,
                          color: AppColors.mainDarkRedColor,
                          size: getIsPhone() ? 20 : 25,
                        ),
                        SizedBox(
                          width: size.height / 40,
                        ),
                        Text(
                          _fromOrder
                              ? tr('maintenance_request')
                              : tr('order_my_order'),
                          style: TextStyle(
                              fontSize: getIsPhone()
                                  ? size.width / 23
                                  : size.height / 35,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                SizedBox(
                  height: size.height / 25,
                ),
                InkWell(
                  onTap: () async {
                    navigationService.back();
                    navigationService.navigateTo(Routes.profileView);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.lock,
                        color: AppColors.mainDarkRedColor,
                        size: getIsPhone() ? 20 : 25,
                      ),
                      SizedBox(
                        width: size.height / 40,
                      ),
                      Text(
                        tr('change_passwor'),
                        style: TextStyle(
                            fontSize: getIsPhone()
                                ? size.width / 23
                                : size.height / 35,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height / 25,
                ),
                InkWell(
                  onTap: logOut,
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: AppColors.mainDarkRedColor,
                        size: getIsPhone() ? 20 : 25,
                      ),
                      SizedBox(
                        width: size.height / 30,
                      ),
                      Text(
                        tr('general_logout'),
                        style: TextStyle(
                            fontSize: getIsPhone()
                                ? size.width / 23
                                : size.height / 35,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: !getIsPhone() &&
                          storage
                              .getLoginInfo()
                              .claims!
                              .contains('InstallingTechnician')
                      ? size.height / 5
                      : size.height / 3.5,
                ),
                Text(getEnvironment() + "   V" + locator<PackageInfo>().version)
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<bool> changeLanguage({required bool isEnglish}) async {
    try {
      customLoader();
      await locator<AccountRepository>()
          .changeAccountLanguage(isEnglash: isEnglish);
      reloadOrder();
      navigationService.back();
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
