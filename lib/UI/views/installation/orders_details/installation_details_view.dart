import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:albarakakitchen/UI/shared/colors.dart';
import 'package:albarakakitchen/UI/shared/shared_widgets/custom_app_bar.dart';
import 'package:albarakakitchen/UI/shared/utils.dart';
import 'package:albarakakitchen/UI/views/installation/orders_details/installation_details_view_model.dart';
import 'package:albarakakitchen/UI/shared/custom_widgets/custom_image_picker.dart';
import 'package:albarakakitchen/UI/shared/custom_widgets/custom_text.dart';
import 'package:albarakakitchen/app/locator.dart';
import 'package:albarakakitchen/app/router.router.dart';
import 'package:albarakakitchen/core/data/models/apis/order_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class InstallationDetailsView extends StatelessWidget {
  final OrderModel order;
  const InstallationDetailsView({Key? key, required this.order})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder<InstallationDetailsViewModel>.reactive(
      viewModelBuilder: () => InstallationDetailsViewModel(),
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
          endWidget: Visibility(
            visible: model
                .orderFromModel.actions!.getOrdersCompleteInstallingProcess,
            child: InkWell(
              onTap: () {
                model.submit(model.orderFromModel.id!);
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
          ),
          onEndTap: () {},
          title: tr('order_add_installation_info'),
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
                      height: size.height / 15,
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
                          child: Text(
                        '#' + order.orderCode.toString(),
                        style: TextStyle(
                            fontSize: size.height / 30,
                            color: AppColors.mainRedColor),
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
                            "${model.orderFromModel.client!.firstName} ${model.orderFromModel.client!.sureName}",
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
                        content: "${model.orderFromModel.client!.phoneNumber}",
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
                        content:
                            "${model.orderFromModel.city} ${model.orderFromModel.neighborhood}",
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height / 3.2,
                  ),
                  Visibility(
                      visible: model.orderFromModel.actions
                              ?.getOrdersReportInstallationIssue ??
                          false,
                      child: InkWell(
                        onTap: () {
                          locator<NavigationService>().navigateTo(
                              Routes.reportProblemView,
                              arguments: ReportProblemViewArguments(
                                  order: model.orderFromModel));
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
                  Visibility(
                    visible: model.orderFromModel.actions
                            ?.getOrdersStartInstaillingProcess ??
                        false,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, top: 5, bottom: 5),
                      child: ElevatedButton(
                        child: Container(
                            width: double.infinity,
                            height: 50,
                            child:
                                Center(child: Text(tr("start_installation")))),
                        onPressed: () {
                          model.installingVisit(model.orderFromModel);
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
                  ),
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
                    visible: model.orderFromModel.actions!
                        .getOrdersCompleteInstallingProcess,
                    child: Column(
                      children: [
                        CustomText(content: tr('order_images')),
                        const SizedBox(height: 10),
                        CustomImagePicker(
                          images: model.installationImages,
                          addNewImage: model.addImage,
                          onCancelClicked: model.imagesOnCancelClicked,
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
        model.setOrder(order);
      },
    );
  }
}
