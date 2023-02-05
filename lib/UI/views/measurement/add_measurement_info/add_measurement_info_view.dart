import 'dart:developer';

import 'package:albarakakitchen/UI/shared/colors.dart';
import 'package:albarakakitchen/UI/shared/custom_widgets/custom_image_picker.dart';
import 'package:albarakakitchen/UI/shared/custom_widgets/custom_text.dart';
import 'package:albarakakitchen/UI/shared/custom_widgets/custom_text_field.dart';
import 'package:albarakakitchen/UI/shared/shared_widgets/custom_app_bar.dart';
import 'package:albarakakitchen/UI/shared/utils.dart';
import 'package:albarakakitchen/UI/views/measurement/add_measurement_info/add_measurement_info_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AddMeasurementInfoView extends StatelessWidget {
  const AddMeasurementInfoView({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    log(size.height.toString());
    return ViewModelBuilder<AddMeasurementInfoViewModel>.reactive(
        viewModelBuilder: () => AddMeasurementInfoViewModel(),
        builder: (context, model, _) => Scaffold(
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
                    model.submit(id);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.save,
                        color: AppColors.whiteColor,
                        size: 25,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        tr(
                          "general_save",
                        ),
                        style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: size.height / 30),
                      ),
                      SizedBox(
                        width: size.height / 15,
                      )
                    ],
                  ),
                ),
                onEndTap: () {},
                title: tr('order_add_order_info'),
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
                          CustomText(content: tr('order_kitchen_hight')),
                          SizedBox(
                            height: size.height / 30,
                          ),
                          CustomTextFormField(
                            placeHolder: '0',
                            keyboardType: TextInputType.number,
                            onSave: model.actualKitchenHeightOnSave,
                            validator: model.actualKitchenHeightValidator,
                            borderColor: AppColors.mainDarkRedColor,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  placeHolder: tr('wallA'),
                                  placeHolderCustomStyle:
                                      TextStyle(color: AppColors.greyColor),
                                  keyboardType: TextInputType.number,
                                  onSave: model.wallAOnSave,
                                  borderColor: AppColors.mainDarkRedColor,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: CustomTextFormField(
                                  placeHolder: tr('wallB'),
                                  placeHolderCustomStyle:
                                      TextStyle(color: AppColors.greyColor),
                                  keyboardType: TextInputType.number,
                                  onSave: model.wallBOnSave,
                                  borderColor: AppColors.mainDarkRedColor,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  placeHolder: tr('wallC'),
                                  placeHolderCustomStyle:
                                      TextStyle(color: AppColors.greyColor),
                                  keyboardType: TextInputType.number,
                                  onSave: model.wallCOnSave,
                                  borderColor: AppColors.mainDarkRedColor,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: CustomTextFormField(
                                  placeHolder: tr('wallD'),
                                  placeHolderCustomStyle:
                                      TextStyle(color: AppColors.greyColor),
                                  keyboardType: TextInputType.number,
                                  onSave: model.wallDOnSave,
                                  borderColor: AppColors.mainDarkRedColor,
                                ),
                              )
                            ],
                          ),
                          CustomText(content: tr('washtubCenter')),
                          SizedBox(
                            height: size.height / 30,
                          ),
                          CustomTextFormField(
                            placeHolder: '0',
                            keyboardType: TextInputType.number,
                            onSave: model.washtubCenterOnSave,
                            borderColor: AppColors.mainDarkRedColor,
                          ),
                          CustomText(content: tr('order_notes')),
                          SizedBox(
                            height: size.height / 30,
                          ),
                          CustomTextFormField(
                            borderColor: AppColors.mainDarkRedColor,
                            onSave: model.visitNotesValidatorOnSave,
                            placeHolder: '',
                            maxLength: 1000,
                            maxLines: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: size.height / 18),
                    width: 1,
                    color: AppColors.mainDarkRedColor,
                    height: size.height * 1.2,
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        CustomText(content: tr('order_kitchecn_size_images')),
                        const SizedBox(height: 10),
                        CustomImagePicker(
                          images: model.measurmentImages,
                          addNewImage: model.addMedia,
                          onCancelClicked:
                              model.measurmentImagesOnCancelClicked,
                        ),
                        const SizedBox(height: 10),
                        CustomText(content: tr('order_kitchecn_old_images')),
                        const SizedBox(height: 10),
                        CustomImagePicker(
                          images: model.kitchenBeforeImages,
                          addNewImage: model.addMedia,
                          onCancelClicked:
                              model.kitchenBeforeImagesOnCancelClicked,
                        ),
                        CustomText(content: tr('order_kitchecn_video')),
                        const SizedBox(height: 10),
                        CustomImagePicker(
                          images: model.kitchenVideo,
                          addNewImage: model.addMedia,
                          onCancelClicked: model.kitchenVideoOnCancelClicked,
                        ),
                      ],
                    ),
                  )
                ],
              )),
            ));
  }
}
