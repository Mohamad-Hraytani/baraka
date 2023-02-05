import 'package:albarakakitchen/UI/shared/colors.dart';
import 'package:albarakakitchen/core/utils/general_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key, required this.onPressed}) : super(key: key);
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ElevatedButton(
      child: Container(
          width: double.infinity,
          height: getIsPhone() ? size.width / 9 : size.height / 14,
          child: Center(child: Text(tr('login_sign_in')))),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(
            fontSize: getIsPhone() ? size.width / 25 : size.height / 35,
            fontFamily: 'cairo'),
        primary: AppColors.mainRedColor,
        onPrimary: Colors.white,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
