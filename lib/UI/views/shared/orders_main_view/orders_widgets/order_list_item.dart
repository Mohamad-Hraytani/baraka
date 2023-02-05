import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:albarakakitchen/UI/shared/colors.dart';
import 'package:albarakakitchen/app/locator.dart';
import 'package:albarakakitchen/app/router.router.dart';
import 'package:albarakakitchen/core/data/models/apis/order_model.dart';
import 'package:stacked_services/stacked_services.dart';

class OrderListItem extends StatelessWidget {
  const OrderListItem(
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
        padding: EdgeInsets.all(10),
        // height: 100,
        decoration: BoxDecoration(
          color: Color(0xFFF9F9FB),
          border: Border.all(
            color: AppColors.mainLightRedColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(flex: 0, child: Text(order.orderCode!)),
            SizedBox(width: 5),
            Container(
              // height: 100,
              width: 1,
              color: Colors.grey.withOpacity(0.5),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      '${order.client?.firstName} ${order.client?.sureName}',
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        tr("order_visit_date"),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${order.visitDate}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        tr("order_visit_time"),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${order.visitTime}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
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
                              color: Colors.grey,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              // width: 400,
                              child: Text(
                                '${order.client?.phoneNumber}',
                                overflow: TextOverflow.ellipsis,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 13),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 5),
                      Row(
                        children: [
                          Visibility(
                            visible: order.city != null,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.cabin,
                                  color: Colors.grey,
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
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ],
                  ),
                  Visibility(
                    visible: order.neighborhood != null,
                    child: Row(
                      children: [
                        Icon(
                          Icons.pedal_bike_outlined,
                          color: Colors.grey,
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
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
                visible:
                    order.actions?.getOrdersStartInstaillingProcess ?? false,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.red3Color,
                    ),
                    onPressed: installationVisit,
                    child: Text(tr('start_installation')))),
            Visibility(
              visible: order.actions?.getOrdersStartInstaillingProcess ?? false,
              child: SizedBox(
                width: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
