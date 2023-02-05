import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../UI/shared/colors.dart';
import '../../UI/shared/custom_widgets/custom_toasts.dart';
import '../../app/locator.dart';
import '../data/repository/shared_prefrence_repository.dart';

void customLoader() => BotToast.showCustomLoading(
    toastBuilder: (cancelFunc) => Container(
          height: 75,
          width: 75,
          alignment: Alignment.center,
          child: SpinKitDualRing(
            color: AppColors.mainLightGreyColor,
          ),
          decoration: BoxDecoration(
              color: AppColors.mainDarkRedColor.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10)),
        ),
    crossPage: true,
    align: Alignment.center);

void runBusyFutureWithLoader(Future<dynamic> busyFuture) async {
  try {
    customLoader();
    await busyFuture;
  } catch (e) {
    log(e.toString(), name: "In loading layer log :");
  } finally {
    BotToast.closeAllLoading();
  }
}

Future<dynamic> runBusyFutureWithLoaderAsFuture(
    Future<dynamic> busyFuture) async {
  try {
    customLoader();
    var _response = await busyFuture;
    return _response;
  } catch (e) {
    log(e.toString(), name: "In loading layer log :");
  } finally {
    BotToast.closeAllLoading();
  }
}

void showApiErrors(
    {required dynamic errors,
    String logErrorName = "LOG ERROR :",
    MessageType messageType = MessageType.errorMessage}) {
  String _error = "Unknown error";
  if (errors != null) {
    if (errors is List) {
      if (errors.isNotEmpty) {
        _error = errors.join(", ");
      }
    }
    if (errors is Map) {
      if (errors.values.isNotEmpty) {
        _error = errors.values.join(", ");
      }
    }
    if (errors is String) {
      if (errors.isNotEmpty) {
        _error = errors;
      }
    }
  }
  log(_error, name: logErrorName);
  CustomToasts.showMessage(
      message: _error
          .replaceAll("[", "")
          .replaceAll("]", "")
          .replaceAll("{", "")
          .replaceAll("}", ""),
      messageType: messageType,
      duration: 3);
}

String deleteBrackets(String error) => error
    .replaceAll("[", "")
    .replaceAll("]", "")
    .replaceAll(")", "")
    .replaceAll("(", "")
    .replaceAll("{", "")
    .replaceAll("}", "");

String getErrorFromDynamicError(dynamic error) {
  String _error = "";
  if (error is String) {
    _error = deleteBrackets(error);
  }
  if (error is List) {
    _error = deleteBrackets(error.join(", "));
  }
  if (error is Map) {
    _error = deleteBrackets(error.values.join(", "));
  }
  return _error;
}

///Navigation
NavigationService get navigation => locator<NavigationService>();

///Storage
SharedPreferencesRepository get storage =>
    locator<SharedPreferencesRepository>();

///
const Map<String, String> unKnownError = {"errors": "Unknown error"};

///TextInputFormatters
TextInputFormatter get doubleTextFormatter => FilteringTextInputFormatter.allow(
    new RegExp('^(?:-?(?:[0-9]+))?(?:\.[0-9]*)?(?:[eE][\+\-]?(?:[0-9]+))?'));

int? extractNumberFromString(String value) {
  return int.tryParse(value.replaceAll(new RegExp(r'[^0-9]'), ''));
}

DateFormat timeFormat = DateFormat('kk:mm', 'en');

SizedBox verSpace(Size size, {required double space}) {
  return SizedBox(
    height: size.height / (space),
  );
}

SizedBox horSpace(Size size, {required double space}) {
  return SizedBox(
    height: size.width / (space),
  );
}

bool getIsPhone() {
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
  return data.size.shortestSide < 500 ? true : false;
}
