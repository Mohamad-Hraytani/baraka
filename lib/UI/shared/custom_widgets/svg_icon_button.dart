import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../colors.dart';

class SvgIconButton extends StatelessWidget {
  final String svgPath;
  final Function? onPressed;
  final Function? onLongPressed;
  final double? width;

  final Color? backgroundCircleColor;
  final double? backgroundCircleWidth;
  final Color? color;
  const SvgIconButton(
      {Key? key,
      required this.svgPath,
      this.backgroundCircleColor,
      this.onPressed,
      this.backgroundCircleWidth,
      this.width,
      this.color,
      this.onLongPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onLongPress: () {
          onLongPressed?.call();
        },
        onTap: () {
          onPressed?.call();
        },
        highlightColor: AppColors.greyColor,
        splashColor: AppColors.blackColor,
        customBorder: const CircleBorder(),
        child: backgroundCircleColor != null
            ? Opacity(
                opacity: 0.9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(size.shortestSide / 12),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: CircleAvatar(
                      backgroundColor: backgroundCircleColor,
                      radius: backgroundCircleWidth ??
                          width ??
                          size.shortestSide / 30,
                      child: SvgPicture.asset(
                        svgPath,
                        color: color,
                        fit: BoxFit.fill,
                        height: width ?? size.shortestSide / 30,
                        width: width ?? size.shortestSide / 30,
                      ),
                    ),
                  ),
                ),
              )
            : Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    svgPath,
                    color: color,
                    fit: BoxFit.fill,
                    height: width ?? size.shortestSide / 30,
                    width: width ?? size.shortestSide / 30,
                  ),
                  Container(
                    height:
                        width != null ? width! * 1.5 : size.shortestSide / 30,
                    width:
                        width != null ? width! * 1.5 : size.shortestSide / 30,
                  ),
                ],
              ),
      ),
    );
  }
}

class SvgNetworkWidget extends StatelessWidget {
  final String svgPath;
  final double width;
  const SvgNetworkWidget({
    Key? key,
    required this.svgPath,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.network(
      svgPath,
      fit: BoxFit.fill,
      placeholderBuilder: (context) =>
          const Center(child: CircularProgressIndicator()),
      alignment: Alignment.center,
      width: width,
      height: width,
    );
  }
}
