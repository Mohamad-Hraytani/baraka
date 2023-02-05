import 'package:albarakakitchen/UI/shared/colors.dart';
import 'package:albarakakitchen/UI/shared/custom_widgets/custom_image_picker.dart';
import 'package:albarakakitchen/UI/shared/custom_widgets/custom_text.dart';
import 'package:albarakakitchen/UI/shared/custom_widgets/custom_text_field.dart';
import 'package:albarakakitchen/UI/shared/shared_widgets/custom_app_bar.dart';
import 'package:albarakakitchen/UI/shared/utils.dart';
import 'package:albarakakitchen/UI/views/maintenance_request/request_details/request_details_view_model.dart';
import 'package:albarakakitchen/core/data/models/apis/maintenance_request.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RequestDetailsView extends StatefulWidget {
  final MaintenanceRequest request;
  RequestDetailsView({Key? key, required this.request}) : super(key: key);

  @override
  State<RequestDetailsView> createState() => _RequestDetailsViewState();
}

class _RequestDetailsViewState extends State<RequestDetailsView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder<RequestDetailsViewModel>.reactive(
      viewModelBuilder: () => RequestDetailsViewModel(),
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
            navigationService.back(result: false);
          },
          endWidget: SizedBox(
            width: size.height / 6,
          ),
          onEndTap: () {},
          title: tr('request_add_maintenance_info'),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  Center(
                    child: Container(
                      width: size.height / 2,
                      //height: size.height / 15,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              //  spreadRadius: 3,
                              blurRadius: 6,
                              //offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                          child: Column(
                        children: [
                          Text(
                            tr('contract_info'),
                            style: TextStyle(
                                fontSize: size.height / 40,
                                color: AppColors.blackColor),
                          ),
                          Text(
                            widget.request.contractNumber.toString(),
                            style: TextStyle(
                                fontSize: size.height / 50,
                                color: AppColors.mainRedColor),
                          ),
                          Text(
                            widget.request.contractDate.toString(),
                            style: TextStyle(
                                fontSize: size.height / 50,
                                color: AppColors.mainRedColor),
                          ),
                        ],
                      )),
                    ),
                  ),
                  SizedBox(height: size.height / 20),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: AppColors.mainLightRedColor,
                        size: 35,
                      ),
                      SizedBox(
                        width: size.height / 50,
                      ),
                      CustomText(
                        content:
                            "${widget.request.client!.firstName} ${widget.request.client!.sureName}",
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: AppColors.mainLightRedColor,
                        size: 35,
                      ),
                      SizedBox(
                        width: size.height / 50,
                      ),
                      CustomText(
                        content: "${widget.request.client!.phoneNumber}",
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppColors.mainLightRedColor,
                        size: 35,
                      ),
                      SizedBox(
                        width: size.height / 50,
                      ),
                      CustomText(
                        content: "${widget.request.address} ",
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height / 3.2,
                  ),
                  Visibility(
                      visible: model.showReport && !model.showReportField,
                      child: InkWell(
                        onTap: () {
                          model.setShowReportFieldValue = true;
                        },
                        child: Center(
                            child: Text(
                          tr("report_problem"),
                          style: TextStyle(
                              color: AppColors.mainDarkRedColor,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              fontSize: size.height / 30),
                        )),
                      )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.height / 18),
              width: 1,
              color: AppColors.mainDarkRedColor,
              height: size.height / 1.3,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    visible: model.showBefore,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            CustomText(content: tr('image_befor_maintenance')),
                          ],
                        ),
                        const SizedBox(height: 10),
                        CustomImagePicker(
                          images: model.beforeImages,
                          addNewImage: model.addImage,
                          onCancelClicked: model.beforeImagesOnCancelClicked,
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.only(end: size.height / 10),
                          child: ElevatedButton(
                            child: Container(
                                width: size.height / 5,
                                height: 50,
                                child: Center(child: Text(tr("general_save")))),
                            onPressed: () {
                              model.submitBeforeProcess(model.request.id!);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.mainDarkRedColor,
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
                  Visibility(
                    visible: model.showAfter && !model.showReportField,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomText(content: tr('image_after_maintenance')),
                        const SizedBox(height: 10),
                        CustomImagePicker(
                          images: model.afterImages,
                          addNewImage: model.addImage,
                          onCancelClicked: model.afterImagesOnCancelClicked,
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.only(end: size.height / 10),
                          child: ElevatedButton(
                            child: Container(
                                width: size.height / 5,
                                height: 50,
                                child: Center(child: Text(tr("general_save")))),
                            onPressed: () {
                              model.submitAfterProcess(model.request.id!);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.mainDarkRedColor,
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
                  Visibility(
                    visible: model.showReport && model.showReportField,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Form(
                          key: model.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomText(content: tr('order_description')),
                              SizedBox(
                                height: size.height / 30,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.only(
                                    end: size.height / 18),
                                child: CustomTextFormField(
                                  borderColor: AppColors.mainDarkRedColor,
                                  onSave: model.issueValidatorOnSave,
                                  validator: model.issueValidator,
                                  placeHolder: '',
                                  maxLength: 1000,
                                  maxLines: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.height / 6,
                          ),
                          child: Row(
                            children: [
                              ElevatedButton(
                                child: Container(
                                    width: size.height / 5,
                                    height: 50,
                                    child: Center(
                                        child: Text(tr("general_save")))),
                                onPressed: () {
                                  model.submitReportProblem(widget.request.id!);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: AppColors.mainDarkRedColor,
                                  onPrimary: Colors.white,
                                  shadowColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: size.height / 10,
                              ),
                              ElevatedButton(
                                child: Container(
                                    width: size.height / 5,
                                    height: 50,
                                    child: Center(
                                        child: Text(tr("general_cancel")))),
                                onPressed: () {
                                  model.setShowReportFieldValue = false;
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: AppColors.mainDarkRedColor,
                                  onPrimary: Colors.white,
                                  shadowColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        )),
      ),
      onModelReady: (model) {
        model.setRequestValue = widget.request;
        model.setShowBeforeValue =
            widget.request.actions?.getRequestInsertBeforeProcessImages ??
                false;

        model.setShowReportValue =
            widget.request.actions?.getRequestReportInstallationIssue ?? false;

        model.setShowAfterValue =
            widget.request.actions?.getRequestInsertAfterProcessImages ?? false;

        model.setShowReportFieldValue = false;
      },
    );
  }
}
