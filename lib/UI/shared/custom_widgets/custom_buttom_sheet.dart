

import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

import '../colors.dart';

class BottomSheetIosWidget {
  final Color fillColor;
  final Color textColor;
  final Function onPressed;
  final bool isBold;
  final String title;
  final String? fontFamily;

  BottomSheetIosWidget(
      {this.fillColor = AppColors.greyIosBottomSheetBackgroundColor,
      required this.title,
      this.fontFamily,
      required this.textColor,
      required this.onPressed,
      this.isBold = false});
}

class IosBottomSheet {
  static show(
      {required BuildContext context,
      required List<BottomSheetIosWidget> bottomSheetWidgets}) {
    final size = MediaQuery.of(context).size;

    showModalBottomSheet(
        isScrollControlled: false,
        isDismissible: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
              padding: EdgeInsets.symmetric(horizontal: size.shortestSide / 32),
              child: ListView(
                padding: EdgeInsets.zero,
                reverse: true,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: size.longestSide / 15.5,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        top: size.longestSide / 88,
                        bottom: size.longestSide / 18,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius:
                            BorderRadius.circular(size.shortestSide / 28),
                      ),
                      child: Text(
                        tr('general_cancel'),
                        style: TextStyle(
                            fontSize: size.shortestSide / 30,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  for (var i = 0; i < bottomSheetWidgets.length; i++)
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        bottomSheetWidgets[i].onPressed();
                      },
                      child: Container(
                        height: size.longestSide / 15.5,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 1),
                        decoration: BoxDecoration(
                          color: AppColors.greyIosBottomSheetBackgroundColor,
                          borderRadius: BorderRadius.only(
                            topRight: i == bottomSheetWidgets.length - 1
                                ? Radius.circular(size.shortestSide / 28)
                                : Radius.zero,
                            topLeft: i == bottomSheetWidgets.length - 1
                                ? Radius.circular(size.shortestSide / 28)
                                : Radius.zero,
                            bottomLeft: i == 0
                                ? Radius.circular(size.shortestSide / 28)
                                : Radius.zero,
                            bottomRight: i == 0
                                ? Radius.circular(size.shortestSide / 28)
                                : Radius.zero,
                          ),
                        ),
                        child: Text(
                          bottomSheetWidgets[i].title,
                          style: TextStyle(
                              color: bottomSheetWidgets[i].textColor,
                              fontSize: size.shortestSide / 30,
                              fontFamily: bottomSheetWidgets[i].fontFamily,
                              fontWeight: bottomSheetWidgets[i].isBold
                                  ? FontWeight.bold
                                  : FontWeight.w400),
                        ),
                      ),
                    ),
                ],
              ));
        });
  }
}
