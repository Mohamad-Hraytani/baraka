import 'package:albarakakitchen/UI/shared/colors.dart';
import 'package:albarakakitchen/UI/shared/custom_widgets/custom_image_picker.dart';
import 'package:albarakakitchen/UI/shared/custom_widgets/custom_text.dart';
import 'package:albarakakitchen/UI/shared/custom_widgets/custom_text_field.dart';
import 'package:albarakakitchen/UI/shared/shared_widgets/custom_app_bar.dart';
import 'package:albarakakitchen/UI/shared/utils.dart';
import 'package:albarakakitchen/UI/views/installation/report_problem/report_problem_view_model.dart';
import 'package:albarakakitchen/core/data/models/apis/order_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ReportProblemView extends StatelessWidget {
  final OrderModel order;
  const ReportProblemView({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder<ReportProblemViewModel>.reactive(
      viewModelBuilder: () => ReportProblemViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: CustomAppBar(
          backgroundColor: AppColors.mainDarkRedColor,
          startWidget: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_outlined,
                  color: AppColors.whiteColor,
                  size: 30,
                ),
                SizedBox(
                  width: size.height / 15,
                ),
              ],
            ),
          ),
          onStartTap: () {
            navigationService.back();
          },
          endWidget: InkWell(
            onTap: () {
              model.submit(order.id!);
            },
            child: Row(
              children: [
                Icon(
                  Icons.send,
                  color: AppColors.whiteColor,
                  size: 25,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  tr(
                    "general_send",
                  ),
                  style: TextStyle(
                      color: AppColors.whiteColor, fontSize: size.height / 30),
                ),
                SizedBox(
                  width: size.height / 15,
                )
              ],
            ),
          ),
          onEndTap: () {},
          title: tr('report_problem'),
        ),
        body: SingleChildScrollView(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.height / 20,
            ),
            Expanded(
              flex: 1,
              child: Form(
                key: model.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(content: tr('order_description')),
                    SizedBox(
                      height: size.height / 30,
                    ),
                    CustomTextFormField(
                      borderColor: AppColors.mainDarkRedColor,
                      onSave: model.issueValidatorOnSave,
                      validator: model.issueValidator,
                      placeHolder: '',
                      maxLength: 1000,
                      maxLines: 12,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.height / 18),
              width: 1,
              color: AppColors.mainDarkRedColor,
              height: size.height,
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  CustomText(content: tr('order_problem')),
                  CustomImagePicker(
                    images: model.images,
                    addNewImage: model.addImage,
                    onCancelClicked: model.imagesOnCancelClicked,
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
