import '../../../UI/shared/colors.dart';
import '../../../UI/shared/custom_widgets/custom_buttom_sheet.dart';
import 'package:flutter/cupertino.dart';

class ChangeLocalService {
  static showAndChangeLocals(BuildContext context,
          {void Function()? enTap,
          void Function()? arTap,
         }) =>
      IosBottomSheet.show(context: context, bottomSheetWidgets: [
        BottomSheetIosWidget(
            title: "English",
            fontFamily: "Bukra",
            textColor: AppColors.blueColor,
            onPressed: enTap ?? () {}),
        BottomSheetIosWidget(
            title: "العربية",
            fontFamily: "Bukra",
            textColor: AppColors.blueColor,
            onPressed: arTap ?? () {}),
       
      ]);
}
