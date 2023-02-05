import 'package:albarakakitchen/UI/shared/colors.dart';
import 'package:albarakakitchen/UI/shared/custom_widgets/custom_toasts.dart';
import 'package:albarakakitchen/UI/shared/utils.dart';
import 'package:albarakakitchen/app/locator.dart';
import 'package:albarakakitchen/app/router.router.dart';
import 'package:albarakakitchen/core/data/models/apis/notification_model.dart';
import 'package:albarakakitchen/core/utils/general_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class NewNotificationListItem extends StatelessWidget {
  const NewNotificationListItem({
    Key? key,
    required this.notification,
    required this.onDeleteClick,
  }) : super(key: key);
  final NotificationModel notification;
  final Function onDeleteClick;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        if (!getIsPhone()) {
          if (notification.order != null) {
            if (notification.order!.actions!.getOrdersUpdateOrderMeasurement) {
              locator<NavigationService>().navigateTo(
                  Routes.addMeasurementInfoView,
                  arguments: AddMeasurementInfoViewArguments(
                      id: notification.order!.id!));
              return;
            }
            if (notification
                    .order!.actions!.getOrdersCompleteInstallingProcess ||
                notification.order!.actions!.getOrdersStartInstaillingProcess) {
              locator<NavigationService>().navigateTo(
                  Routes.installationDetailsView,
                  arguments: InstallationDetailsViewArguments(
                      order: notification.order!));
              return;
            }
          } else if (notification.request != null &&
              (notification
                      .request!.actions!.getRequestInsertBeforeProcessImages ||
                  notification
                      .request!.actions!.getRequestInsertAfterProcessImages ||
                  notification
                      .request!.actions!.getRequestReportInstallationIssue)) {
            navigationService.navigateTo(Routes.requestDetailsView,
                arguments: RequestDetailsViewArguments(
                    request: notification.request!));

            return;
          }

          CustomToasts.showMessage(
              message: tr('notifications_cant_update'),
              messageType: MessageType.errorMessage);
        }
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 15),
            padding: EdgeInsets.symmetric(horizontal: size.height / 35),
            // height: 100,
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(5),
                border:
                    Border.all(width: 1, color: AppColors.mainLightRedColor)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Text(
                    notification.title ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                    child: Wrap(
                  children: [Text(notification.message ?? '')],
                )),
                SizedBox(height: 5),

                Row(
                  children: [
                    Text(
                      '${notification.date}',
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
                      '${notification.time}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.mainGreyColor),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(bottom: size.width / 30),
                      child: InkWell(
                        onTap: () {
                          onDeleteClick();
                        },
                        child: Icon(
                          Icons.delete,
                          color: AppColors.mainRedColor,
                        ),
                      ),
                    )
                  ],
                ),
                // SizedBox(height: 4),
              ],
            ),
          ),
          if (!notification.isRead!)
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: _Triangle(
                color: AppColors.mainDarkRedColor,
              ),
            ),
        ],
      ),
    );
  }
}

class _Triangle extends StatelessWidget {
  const _Triangle({
    Key? key,
    this.color,
  }) : super(key: key);
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool _arLocal = EasyLocalization.of(context)?.locale.languageCode == "ar";

    return CustomPaint(
        painter: _ShapesPainter(color: color!, isAr: _arLocal),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            height: 50,
            width: 50,
            child: Center(
                child: Padding(
                    padding: EdgeInsetsDirectional.only(
                        start:
                            getIsPhone() ? size.width / 15 : size.height / 25,
                        bottom:
                            getIsPhone() ? size.width / 25 : size.height / 25),
                    child: Icon(
                      Icons.circle_notifications_sharp,
                      //  Icons.notifications_active,
                      color: AppColors.whiteColor,
                      size: 20,
                    )))));
  }
}

class _ShapesPainter extends CustomPainter {
  final Color color;
  final bool isAr;
  _ShapesPainter({this.color = AppColors.mainDarkRedColor, this.isAr = true});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = color;
    var path = Path();
    if (isAr) {
      path.lineTo(0, size.width);
      path.lineTo(size.width, 0);
    } else {
      path.lineTo(size.width, 0);
      path.lineTo(size.height, size.width);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
