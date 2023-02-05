import 'dart:io';

import 'package:albarakakitchen/core/utils/general_utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../../core/services/ios_numeric_keyboard_done_button_service.dart';
import '../colors.dart';
import 'custom_text_field.dart';

class NormalTextField extends StatefulWidget {
  final double? evevation;
  final TextCapitalization? textCapitalization;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? placeHolder;
  final TextStyle? placeHolderCustomStyle;
  final TextEditingController? textEditingController;
  final TextStyle? textCustomStyle;
  final Widget suffixWidget;

  // final FocusNode? nextFocusNode;
  // final FocusNode? focusNode;
  final Function(String v)? onSubmit;
  final Function(String v)? onChange;
  final Function(String? v)? onSave;

  final String? Function(String? v)? validator;
  final bool? showPassword;
  final Color? borderColor;
  final Color? fillColor;
  final bool? centerPlaceHolder;
  final List<SuffixItem>? suffixListItem;
  final String? helperMessageText;
  final Color? helperMessageColor;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatterList;
  final int? maxLength;
  final bool? autoFocus;
  final int? maxLines;
  final bool? underLineBorderMode;
  final Widget? prefixIcon;
  final BoxConstraints? prefixConstraint;
  final Color? shadowColor;
  final bool? disableTextField;

  const NormalTextField(
      {Key? key,
      this.evevation,
      this.textCapitalization,
      this.keyboardType,
      this.textInputAction,
      this.placeHolder,
      this.placeHolderCustomStyle,
      this.textEditingController,
      this.textCustomStyle,
      // this.nextFocusNode,
      // this.focusNode,
      this.onSubmit,
      this.onChange,
      this.onSave,
      this.validator,
      this.showPassword,
      this.borderColor,
      this.fillColor,
      this.centerPlaceHolder,
      this.suffixListItem,
      this.helperMessageText,
      this.helperMessageColor,
      this.readOnly,
      this.inputFormatterList,
      this.maxLength,
      this.autoFocus,
      this.maxLines,
      this.underLineBorderMode,
      this.prefixIcon,
      this.prefixConstraint,
      this.shadowColor,
      this.disableTextField,
      this.suffixWidget = const SizedBox()})
      : super(key: key);

  @override
  _NormalTextFieldState createState() => _NormalTextFieldState();
}

class _NormalTextFieldState extends State<NormalTextField> {
  @override
  void didChangeDependencies() {
    if (Platform.isIOS) {
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        var keyboardVisibilityController = KeyboardVisibilityController();

        keyboardVisibilityController.onChange.listen(
          (bool visible) {
            if (!mounted) return;
            visible
                ? IosKeyboardDoneButtonService.showOverlay(context)
                : IosKeyboardDoneButtonService.removeOverlay();
          },
        );
      });
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    if (Platform.isIOS) IosKeyboardDoneButtonService.removeOverlay();
    super.dispose();
  }

  String _currentValidateMessage = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: _allClickableMode() ? () {} : null,
          child: IgnorePointer(
            ignoring: _allClickableMode(),
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: widget.suffixListItem != null &&
                          widget.suffixListItem!.isNotEmpty
                      ? 4
                      : 5,
                  horizontal:
                      !getIsPhone() ? size.height / 32 : size.width / 32),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: widget.underLineBorderMode!
                      ? null
                      : BorderRadius.circular(
                          !getIsPhone() ? size.height / 15 : size.width / 15),
                  border: widget.underLineBorderMode!
                      ? Border(
                          bottom:
                              BorderSide(color: widget.borderColor!, width: 1))
                      : Border.all(color: widget.borderColor!, width: 1)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  if (widget.prefixIcon != null) widget.prefixIcon!,
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextFormField(
                        onSaved: widget.onSave,
                        scrollPadding: const EdgeInsets.all(92),
                        validator: widget.validator,
                        onFieldSubmitted: widget.onSubmit,
                        readOnly: widget.readOnly!,
                        autofocus: widget.autoFocus!,
                        textAlign: widget.centerPlaceHolder!
                            ? TextAlign.center
                            : TextAlign.start,
                        cursorColor: AppColors.mainRedColor,
                        controller: widget.textEditingController,
                        textInputAction: widget.textInputAction!,
                        keyboardType: widget.keyboardType!,
                        textCapitalization: widget.textCapitalization ??
                            TextCapitalization.sentences,
                        obscureText: widget.keyboardType! ==
                                TextInputType.visiblePassword &&
                            !widget.showPassword!,
                        onChanged: widget.onChange,
                        inputFormatters: widget.inputFormatterList!,
                        maxLength: widget.maxLength!,
                        maxLines: widget.keyboardType! ==
                                TextInputType.visiblePassword
                            ? 1
                            : widget.maxLines!,
                        style: TextStyle(
                                fontSize: !getIsPhone()
                                    ? size.height / 35
                                    : size.width / 35,
                                fontWeight: FontWeight.w600)
                            .merge(widget.textCustomStyle!
                                .copyWith(inherit: true)),
                        decoration: InputDecoration(
                            counter: SizedBox(
                              width: 0,
                              height: 0,
                            ),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            isCollapsed: true,
                            errorBorder: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            disabledBorder: InputBorder.none,
                            errorStyle: TextStyle(height: 0, fontSize: 11),
                            hintText: widget.placeHolder!,
                            hintStyle: TextStyle(
                              color: AppColors.mainGreyColor,
                              fontSize: !getIsPhone()
                                  ? size.height / 35
                                  : size.width / 35,
                              fontWeight: FontWeight.w600,
                            ).merge(
                              widget.placeHolderCustomStyle!
                                  .copyWith(inherit: true),
                            ))),
                  ),
                  SizedBox(
                    width: 0,
                  ),
                  widget.suffixWidget,
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: !getIsPhone() ? size.height / 32 : size.width / 32),
          child: Text(
            ![null].contains(_currentValidateMessage) &&
                    _currentValidateMessage.isNotEmpty
                ? _currentValidateMessage
                : widget.helperMessageText!,
            maxLines: 1,
            style: TextStyle(
                fontSize: !getIsPhone() ? size.height / 32 : size.width / 32,
                height: 1.3,
                color: ![null].contains(_currentValidateMessage)
                    ? AppColors.redColor
                    : widget.helperMessageColor!),
          ),
        )
      ],
    );
  }

  bool _allClickableMode() =>
      widget.readOnly! &&
      widget.suffixListItem != null &&
      widget.suffixListItem!.length == 1;
}

class NewTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final Function(String?)? onSubmit;

  const NewTextField({Key? key, this.validator, this.onSubmit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onFieldSubmitted: onSubmit,
    );
  }
}
