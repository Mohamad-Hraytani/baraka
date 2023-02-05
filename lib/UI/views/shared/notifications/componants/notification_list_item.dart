import 'package:albarakakitchen/UI/shared/custom_widgets/custom_toasts.dart';
import 'package:albarakakitchen/app/locator.dart';
import 'package:albarakakitchen/app/router.router.dart';
import 'package:albarakakitchen/core/data/models/apis/notification_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class NotificationListItem extends StatelessWidget {
  const NotificationListItem({
    Key? key,
    required this.notification,
  }) : super(key: key);
  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (notification.order!.actions!.getOrdersUpdateOrderMeasurement) {
          locator<NavigationService>().navigateTo(Routes.addMeasurementInfoView,
              arguments:
                  AddMeasurementInfoViewArguments(id: notification.order!.id!));
          return;
        }
        if (notification.order!.actions!.getOrdersCompleteInstallingProcess ||
            notification.order!.actions!.getOrdersStartInstaillingProcess) {
          locator<NavigationService>().navigateTo(
              Routes.installationDetailsView,
              arguments:
                  InstallationDetailsViewArguments(order: notification.order!));
          return;
        }
        CustomToasts.showMessage(
            message: tr('notifications_cant_update'),
            messageType: MessageType.errorMessage);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.all(10),
        // height: 100,
        decoration: BoxDecoration(
          color: Color(0xFFF9F9FB),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tr("notifications_date"),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    '${notification.date}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    tr("notifications_time"),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${notification.time}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              height: 100,
              width: 1,
              color: Colors.grey.withOpacity(0.5),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Text(
                      notification.title ?? '',
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                      child: Wrap(
                    children: [Text(notification.message ?? '')],
                  )),
                  // SizedBox(height: 4),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
