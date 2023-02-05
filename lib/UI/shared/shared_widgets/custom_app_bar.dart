import 'package:albarakakitchen/core/utils/general_utils.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class CustomAppBar extends PreferredSize {
  final Color backgroundColor;
  final Widget? startWidget;
  final VoidCallback? onStartTap;
  final Widget? endWidget;
  final VoidCallback? onEndTap;
  final String? title;
  CustomAppBar(
      {this.backgroundColor = AppColors.mainLightRedColor,
      this.startWidget,
      this.onStartTap,
      this.endWidget = const SizedBox(
        width: 75,
      ),
      this.onEndTap,
      this.title})
      : super(child: SizedBox(), preferredSize: Size.fromHeight(75));

  @override
  Size get preferredSize => Size.fromHeight(getIsPhone() ? 75 : 90);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(
          height: 25,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Container(
              padding: EdgeInsetsDirectional.only(
                start: 25,
                end: 10,
              ),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).focusColor.withOpacity(0.1),
                      blurRadius: 15,
                      offset: Offset(0, 5)),
                ],
              ),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        onStartTap!();
                      },
                      child: startWidget!),
                  const Spacer(),
                  Text(
                    title!,
                    style: TextStyle(
                        color: AppColors.whiteColor,
                        letterSpacing: 1.3,
                        fontWeight: FontWeight.w400,
                        fontSize:
                            getIsPhone() ? size.width / 23 : size.height / 23),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      onEndTap!();
                    },
                    child: endWidget!,
                  )
                ],
              )),
        ),
      ],
    );
  }
}
