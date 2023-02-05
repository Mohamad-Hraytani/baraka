import 'package:albarakakitchen/UI/shared/colors.dart';
import 'package:albarakakitchen/app/locator.dart';
import 'package:albarakakitchen/app/router.router.dart';
import 'package:albarakakitchen/core/data/models/apis/order_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

class NewOrderListItem extends StatelessWidget {
  const NewOrderListItem(
      {Key? key, required this.order, required this.installationVisit})
      : super(key: key);
  final OrderModel order;
  final Function() installationVisit;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        order.actions?.getOrdersUpdateOrderMeasurement ?? false
            ? locator<NavigationService>().navigateTo(
                Routes.addMeasurementInfoView,
                arguments: AddMeasurementInfoViewArguments(id: order.id!))
            : locator<NavigationService>().navigateTo(
                Routes.installationDetailsView,
                arguments: InstallationDetailsViewArguments(order: order));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: size.height / 35),
        padding: EdgeInsets.all(size.height / 35),
        // height: 100,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          border: Border.all(
            color: AppColors.mainLightRedColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        child: Text(
                          '${order.client?.firstName} ${order.client?.sureName}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: AppColors.mainBlackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: size.height / 4.2,
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Center(
                            child: Text(
                          '#' + order.orderCode.toString(),
                          style: TextStyle(
                              fontSize: size.height / 30,
                              color: AppColors.mainRedColor),
                        )),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '${order.visitDate}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.mainGreyColor),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '/',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.mainLightRedColor),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${order.visitTime}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.mainGreyColor),
                      ),
                      Spacer(),
                      Container(
                          width: size.height / 4.2,
                          height: size.height / 15,
                          child: Center(
                            child: Text(
                              '${order.localizedVisitPeriod}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.mainGreyColor),
                            ),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Visibility(
                        visible: order.client?.phoneNumber != null,
                        child: Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: AppColors.mainLightRedColor,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () async {
                                await launch("tel://" +
                                    (order.client?.phoneNumber).toString());
                              },
                              child: Container(
                                // width: 400,
                                child: Text(
                                  '${order.client?.phoneNumber}',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: AppColors.mainGreyColor,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                  Visibility(
                    visible: order.neighborhood != null,
                    child: Row(
                      children: [
                        Visibility(
                          visible: order.city != null,
                          child: Row(
                            children: [
                              Icon(
                                Icons.cabin,
                                color: AppColors.mainLightRedColor,
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                // width: 400,
                                child: Text(
                                  '${order.city}',
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      TextStyle(color: AppColors.mainGreyColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.height / 25,
                        ),
                        Icon(
                          Icons.pedal_bike_outlined,
                          color: AppColors.mainLightRedColor,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          // width: 400,
                          child: Text(
                            '${order.neighborhood}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: AppColors.mainGreyColor),
                          ),
                        ),
                        SizedBox(width: 10),
                        Spacer(),
                        Visibility(
                          visible:
                              order.actions?.getOrdersStartInstaillingProcess ??
                                  false,
                          child: InkWell(
                            onTap: installationVisit,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              width: size.height / 4.2,
                              height: size.height / 15,
                              decoration: BoxDecoration(
                                  color: AppColors.mainDarkRedColor,
                                  border: Border.all(
                                      color: AppColors.mainLightRedColor,
                                      width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Center(
                                  child: Row(
                                children: [
                                  Icon(
                                    Icons.play_circle_sharp,
                                    color: AppColors.whiteColor,
                                    size: 20,
                                  ),
                                  Spacer(),
                                  Text(
                                    tr('start_installation'),
                                    style: TextStyle(
                                        fontSize: size.height / 35,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.whiteColor),
                                  ),
                                ],
                              )),
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
      ),
    );
  }
}
