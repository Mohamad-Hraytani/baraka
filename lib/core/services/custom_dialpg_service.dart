import 'dart:developer';

import 'package:albarakakitchen/UI/shared/colors.dart';
import 'package:albarakakitchen/UI/shared/custom_widgets/custom_text.dart';
import 'package:albarakakitchen/UI/shared/custom_widgets/custom_text_field.dart';
import 'package:albarakakitchen/UI/shared/custom_widgets/custom_toasts.dart';
import 'package:albarakakitchen/app/locator.dart';
import 'package:albarakakitchen/core/data/models/apis/account_model.dart';
import 'package:albarakakitchen/core/data/repository/account_repository.dart';
import 'package:albarakakitchen/core/utils/general_utils.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

enum DialogType {
  profileDialog,
  changePassword,
}
void setUpServiceDialog() {
  final _dialogService = locator<DialogService>();
  final builders = {
    DialogType.profileDialog: (context, sheetRequest, completer) =>
        _ProfilDialog(request: sheetRequest, completer: completer),
    DialogType.changePassword: (context, sheetRequest, completer) =>
        _PasswordChangeDialog(request: sheetRequest, completer: completer),
  };
  _dialogService.registerCustomDialogBuilders(builders);
}

class _ProfilDialog extends StatefulWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const _ProfilDialog(
      {Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  __ProfilDialogState createState() => __ProfilDialogState();
}

class __ProfilDialogState extends State<_ProfilDialog> {
  AccountModel? userProfile;
  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Container(
        width: size.width * 0.5,
        height: size.height >= 700 ? size.height * 0.3 : size.height * 0.5,
        // constraints: BoxConstraints(
        //     maxHeight: size.height * 0.5,
        //     // minHeight: size.height * 0.4,
        //     maxWidth: size.width * 0.5,
        //     minWidth: size.width * 0.4),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              userProfile != null
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              tr('user_info'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        ProfileText(
                            lableKey: tr('name'),
                            content: userProfile!.displayName!),
                        ProfileText(
                            lableKey: tr('Email'),
                            content: userProfile!.email!),
                        ProfileText(
                            lableKey: tr('Phone'),
                            content: userProfile!.phoneNumber!),
                        ProfileText(
                            lableKey: tr('Role'), content: userProfile!.role!),
                      ],
                    )
                  : Container(),
              userProfile != null
                  ? Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () {
                            widget.completer(DialogResponse(confirmed: true));
                          },
                          child: Text(
                            tr('close'),
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.red3Color,
                            onPrimary: Colors.white,
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ))
                      ],
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  void loadProfile() async {
    try {
      customLoader();
      final response = await locator<AccountRepository>().profile();
      BotToast.closeAllLoading();

      log(response.toString());
      setState(() {
        userProfile = response;
      });
    } catch (e) {
      BotToast.closeAllLoading();
      CustomToasts.showMessage(
          message: e.toString(), messageType: MessageType.errorMessage);

      log(e.toString());
      widget.completer(DialogResponse(confirmed: false));
      return null;
    }
  }
}

class _PasswordChangeDialog extends StatefulWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const _PasswordChangeDialog(
      {Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  State<_PasswordChangeDialog> createState() => _PasswordChangeDialogState();
}

class _PasswordChangeDialogState extends State<_PasswordChangeDialog> {
  final _formKey = GlobalKey<FormState>();
  String currentPassword = '';
  String newPassword = '';
  String confirmPassword = '';
  bool showCurrentPassword = true;
  bool showNewPassword = true;
  bool showConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Container(
          width: size.width * 0.6,
          height: size.height >= 700 ? size.height * 0.5 : size.height * 0.9,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 5),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          content: tr('change_passwor'),
                          fontSize: 12,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                      content: tr('current_passwor'),
                      fontSize: 12,
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 40,
                      child: CustomTextFormField(
                        placeHolderCustomStyle:
                            TextStyle(color: Colors.grey, fontSize: 12),
                        showPassword: showCurrentPassword,
                        suffixWidget: IconButton(
                            onPressed: () {
                              setState(() {
                                showCurrentPassword = !showCurrentPassword;
                              });
                            },
                            icon: Icon(
                              showCurrentPassword == true
                                  ? Icons.visibility
                                  : Icons.visibility_off_outlined,
                              color: Colors.grey,
                            )),
                        placeHolder: tr('current_passwor'),
                        onSubmit: (String? val) {
                          if (val != null && val.isNotEmpty)
                            currentPassword = val;
                        },
                        validator: (String? val) {
                          if (val != null && val.isNotEmpty) return null;
                          return tr('field_validator');
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                    CustomText(
                      content: tr('new_passwor'),
                      fontSize: 12,
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 40,
                      child: CustomTextFormField(
                        placeHolderCustomStyle:
                            TextStyle(color: Colors.grey, fontSize: 12),
                        showPassword: showNewPassword,
                        suffixWidget: IconButton(
                            onPressed: () {
                              setState(() {
                                showNewPassword = !showNewPassword;
                              });
                            },
                            icon: Icon(
                              showNewPassword == true
                                  ? Icons.visibility
                                  : Icons.visibility_off_outlined,
                              color: Colors.grey,
                            )),
                        placeHolder: tr('new_passwor'),
                        onSubmit: (String? val) {
                          if (val != null && val.isNotEmpty) newPassword = val;
                        },
                        validator: (String? val) {
                          if (val != null && val.isNotEmpty) return null;
                          return tr('field_validator');
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                    CustomText(
                      content: tr('confirm_passwor'),
                      fontSize: 12,
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 40,
                      child: CustomTextFormField(
                        placeHolderCustomStyle:
                            TextStyle(color: Colors.grey, fontSize: 12),
                        showPassword: showConfirmPassword,
                        suffixWidget: IconButton(
                            onPressed: () {
                              setState(() {
                                showConfirmPassword = !showConfirmPassword;
                              });
                            },
                            icon: Icon(
                              showConfirmPassword == true
                                  ? Icons.visibility
                                  : Icons.visibility_off_outlined,
                              color: Colors.grey,
                            )),
                        placeHolder: tr('confirm_passwor'),
                        onSubmit: (String? val) {
                          if (val != null && val.isNotEmpty)
                            confirmPassword = val;
                        },
                        validator: (String? val) {
                          if (val != null && val.isNotEmpty) return null;
                          return tr('field_validator');
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 50, right: 50, top: 20, bottom: 20),
                      child: ElevatedButton(
                        child: Container(
                            width: double.infinity,
                            height: 30,
                            child: Center(child: Text(tr("general_save")))),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            try {
                              customLoader();
                              final response =
                                  await locator<AccountRepository>()
                                      .changeAccountPassword(
                                          currenPassword: currentPassword,
                                          newPassword: newPassword,
                                          newPasswordConfirmation:
                                              confirmPassword);

                              BotToast.closeAllLoading();
                              widget.completer(DialogResponse(confirmed: true));

                              log(response.toString());
                            } catch (e) {
                              BotToast.closeAllLoading();
                              CustomToasts.showMessage(
                                  message: e.toString(),
                                  messageType: MessageType.errorMessage);

                              log(e.toString());
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.red3Color,
                          onPrimary: Colors.white,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class ProfileText extends StatelessWidget {
  const ProfileText({
    Key? key,
    required this.content,
    required this.lableKey,
  }) : super(key: key);

  final String content;
  final String lableKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr(lableKey),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        SizedBox(width: 8),
        Container(
          width: MediaQuery.of(context).size.width * 0.2,
          child: Text(
            content,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        )
      ],
    );
  }
}
