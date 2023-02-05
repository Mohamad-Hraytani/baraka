
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../colors.dart';
import 'normal_text_field.dart';

class CustomTextFormField extends StatelessWidget {
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String placeHolder;
  final TextStyle placeHolderCustomStyle;
  final TextEditingController? textEditingController;
  final TextStyle textCustomStyle;

  //final FocusNode nextFocusNode;
  //final FocusNode? focusNode;
  final Function(String v)? onSubmit;
  final Function(String? v)? onSave;
  final Function(String v)? onChange;
  final String? Function(String? v)? validator;
  final bool showPassword;
  final Color borderColor;
  final Color fillColor;
  final bool centerPlaceHolder;
  final List<SuffixItem> suffixListItem;
  final String helperMessageText;
  final Color helperMessageColor;
  final bool readOnly;
  final List<TextInputFormatter> inputFormatterList;
  final int maxLength;
  final bool autoFocus;
  final int maxLines;
  final double endContentPadding;
  final double elevation;
  final bool underLineBorderMode;
  final double startContentPadding;
  final double topContentPadding;
  final double bottomContentPadding;
  final Widget prefixIcon;
  final BoxConstraints prefixConstraint;
  final Color shadowColor;
  final bool disableTextField;
  final Widget suffixWidget;
  final void Function()? onTap;

  CustomTextFormField(
      {Key? key,
      this.validator,
      this.shadowColor = AppColors.transparentColor,
      this.disableTextField = false,
      this.prefixIcon = const SizedBox(),
      this.prefixConstraint = const BoxConstraints(),
      this.topContentPadding = 0.0,
      this.bottomContentPadding = 0.0,
      this.underLineBorderMode = false,
      this.elevation = 0.0,
      //this.focusNode,
      this.endContentPadding = 0.0,
      this.readOnly = false,
      this.helperMessageText = '',
      this.helperMessageColor = AppColors.blueAccentColor,
      this.suffixListItem = const [],
      this.centerPlaceHolder = false,
      this.showPassword = false,
      this.borderColor = AppColors.transparentColor,
      this.fillColor = AppColors.transparentColor,
      this.onSubmit,
      this.onSave,
      this.startContentPadding = 0.0,
      this.placeHolderCustomStyle = const TextStyle(),
      this.textCustomStyle = const TextStyle(),
      this.textEditingController,
      this.textCapitalization = TextCapitalization.none,
      this.keyboardType = TextInputType.name,
      required this.placeHolder,
      this.textInputAction = TextInputAction.done,
      this.onChange,
      this.inputFormatterList = const [],
      this.maxLength = 50,
      this.maxLines = 1,
      this.autoFocus = false,
      this.suffixWidget = const SizedBox(),
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: disableTextField,
      child: Opacity(
        opacity: disableTextField ? 0.5 : 1,
        child:

            //  dropDownWithOnlyRead()
            //     ? DropDownTextField(
            //         elevation: elevation,
            //         borderColor: borderColor,
            //         placeHolder: placeHolder,
            //         placeHolderCustomStyle: placeHolderCustomStyle,
            //         suffixListItem: suffixListItem,
            //         centerPlaceHolder: centerPlaceHolder,
            //         helperMessageColor: helperMessageColor,
            //         textEditingController: textEditingController,
            //         helperMessageText: helperMessageText)
            //     :
            InkWell(
          onTap: onTap,
          child: AbsorbPointer(
            absorbing: readOnly,
            child: NormalTextField(
              onSave: onSave,
              evevation: elevation,
              autoFocus: autoFocus,
              borderColor: borderColor,
              centerPlaceHolder: centerPlaceHolder,
              disableTextField: disableTextField,
              fillColor: fillColor,
              // focusNode: focusNode,
              helperMessageColor: helperMessageColor,
              helperMessageText: helperMessageText,
              inputFormatterList: inputFormatterList,
              keyboardType: keyboardType,
              maxLength: maxLength,
              maxLines: maxLines,
              // nextFocusNode: nextFocusNode!,
              onChange: onChange,
              onSubmit: onSubmit,
              readOnly: readOnly,
              placeHolder: placeHolder,
              placeHolderCustomStyle: placeHolderCustomStyle,
              prefixConstraint: prefixConstraint,
              validator: validator,
              prefixIcon: prefixIcon,
              shadowColor: shadowColor,
              showPassword: showPassword,
              suffixListItem: suffixListItem,
              textCapitalization: textCapitalization,
              textCustomStyle: textCustomStyle,
              textEditingController: textEditingController,
              textInputAction: textInputAction,
              underLineBorderMode: underLineBorderMode,
              suffixWidget: suffixWidget,
            ),
          ),
        ),
      ),
    );
  }

  bool dropDownWithOnlyRead() =>
      readOnly && (suffixListItem.length) > 0 && (suffixListItem.length) < 4
          ? true
          : false;
}

class SuffixItem {
  final Color? color;
  final Function? onTab;
  final String? svgPath;
  final EdgeInsetsGeometry? padding;
  final double? sizeFactor;
  final String? text;
  final TextStyle? textStyle;

//  final DropDownAction? dropDownAction;

  const SuffixItem({
    this.text,
    //this.dropDownAction,
    this.textStyle,
    this.sizeFactor = 1.0,
    this.padding = EdgeInsetsDirectional.zero,
    this.color = AppColors.mainLightRedColor,
    this.svgPath,
    this.onTab,
  }) : assert(text == null || svgPath == null);
}

class SuffixIcons extends StatelessWidget {
  final List<SuffixItem> suffixListItem;
  final Color color;
  final String title;

  const SuffixIcons(
      {Key? key,
      required this.suffixListItem,
      required this.color,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        if (suffixListItem.isNotEmpty)
          for (var i = 0; i < suffixListItem.length; i++)
            Material(
              shape: CircleBorder(),
              color: AppColors.transparentColor,
              child: InkWell(
                customBorder: CircleBorder(),
                highlightColor: AppColors.grey100Color,
                splashColor: AppColors.grey100Color,
                onTap: () {
                  suffixListItem[i].onTab!();
                },
                child: suffixListItem[i].text != null
                    ? Text(
                        suffixListItem[i].text!,
                        style: suffixListItem[i].textStyle,
                      )
                    : Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 3, vertical: 6),
                        child: SvgPicture.asset(
                          suffixListItem[i].svgPath!,
                          alignment: Alignment.center,
                          width: size.width / 17,
                          height: size.width / 17,
                          fit: BoxFit.cover,
                          color: suffixListItem[i].color,
                        ),
                      ),
              ),
            ),
      ],
    );
  }
}
