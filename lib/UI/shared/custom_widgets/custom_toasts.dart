import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/utils/string_utils.dart';
import '../colors.dart';

enum MessageType { successMessage, errorMessage, alertMessage, infoMessage }

class CustomToasts {
  static const double _iconSize = 35;

  static const double _width = 300;

  static showMessage(
      {required String message,
      required MessageType messageType,
      int duration = 3}) {
    switch (messageType) {
      case MessageType.successMessage:
        BotToast.showCustomText(
          duration: Duration(seconds: duration),
          onlyOne: true,
          toastBuilder: (f) => Container(
            margin: EdgeInsets.symmetric(horizontal: 22),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      border:
                          Border.all(color: AppColors.greenColor, width: 5)),
                  child: Icon(
                    Icons.check,
                    color: AppColors.greenColor,
                    size: _iconSize,
                  ),
                ),
                SizedBox(
                  width: _width,
                  child: Center(
                    child: Text(
                      message.inCaps,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.5,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.greenColor, width: 1),
              boxShadow: [
                BoxShadow(
                  color: AppColors.greenColor.withOpacity(0.3),
                  offset: Offset(0, 7),
                  blurRadius: 21,
                )
              ],
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
        break;
      case MessageType.errorMessage:
        BotToast.showCustomText(
          duration: Duration(seconds: duration),
          onlyOne: true,
          toastBuilder: (f) => Container(
            margin: EdgeInsets.symmetric(horizontal: 22),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  // decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.all(Radius.circular(50)),
                  //     border: Border.all(color: AppColors.redColor, width: 5)),
                  child: Icon(Icons.error_outline_outlined,
                      color: AppColors.redColor, size: _iconSize),
                ),
                SizedBox(
                  width: _width,
                  child: Center(
                    child: Text(
                      message.inCaps,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.5,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.redColor, width: 1),
              boxShadow: [
                BoxShadow(
                  color: AppColors.redColor.withOpacity(0.3),
                  offset: Offset(0, 7),
                  blurRadius: 21,
                )
              ],
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
        break;
      case MessageType.alertMessage:
        BotToast.showCustomText(
          duration: Duration(seconds: duration),
          onlyOne: true,
          toastBuilder: (f) => Container(
            margin: EdgeInsets.symmetric(horizontal: 22),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  // decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.all(Radius.circular(50)),
                  //     border: Border.all(color: AppColors.redColor, width: 5)),
                  child: Icon(Icons.warning_rounded,
                      color: AppColors.orangeColor, size: _iconSize + 10),
                ),
                SizedBox(
                  width: _width,
                  child: Center(
                    child: Text(
                      message.inCaps,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.5,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.orangeColor, width: 1),
              boxShadow: [
                BoxShadow(
                  color: AppColors.orangeColor.withOpacity(0.3),
                  offset: Offset(0, 7),
                  blurRadius: 21,
                )
              ],
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
        break;
      case MessageType.infoMessage:
        BotToast.showCustomText(
          duration: Duration(seconds: duration),
          onlyOne: true,
          toastBuilder: (f) => Container(
            margin: EdgeInsets.symmetric(horizontal: 22),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.info_rounded,
                    color: AppColors.blueColor, size: _iconSize + 10),
                SizedBox(
                  height: 4,
                ),
                SizedBox(
                  width: _width,
                  child: Center(
                    child: Text(
                      message.inCaps,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.5,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.blueColor.withOpacity(0.5),
                  offset: Offset(0, 7),
                  blurRadius: 21,
                )
              ],
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
        break;

      default:
        BotToast.showCustomText(
          onlyOne: true,
          toastBuilder: (f) => Container(
            margin: EdgeInsets.symmetric(horizontal: 22),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/svgs/info.svg',
                  width: 38,
                ),
                SizedBox(
                  width: 300,
                  child: Center(
                    child: Text(
                      message.inCaps,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.5,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.greyColor.withOpacity(0.3),
                  offset: Offset(0, 7),
                  blurRadius: 21,
                )
              ],
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
    }
  }
}
