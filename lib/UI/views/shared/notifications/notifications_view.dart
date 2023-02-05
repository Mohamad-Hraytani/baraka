import 'package:albarakakitchen/UI/shared/colors.dart';
import 'package:albarakakitchen/UI/shared/custom_widgets/app_drawer.dart';
import 'package:albarakakitchen/UI/shared/shared_widgets/custom_app_bar.dart';
import 'package:albarakakitchen/UI/shared/utils.dart';
import 'package:albarakakitchen/UI/views/shared/notifications/componants/new_notification_list_item.dart';
import 'package:albarakakitchen/UI/views/shared/notifications/notifications_view_model.dart';
import 'package:albarakakitchen/core/utils/general_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool _arLocal = EasyLocalization.of(context)?.locale.languageCode == "ar";
    bool _enLocal = EasyLocalization.of(context)?.locale.languageCode == "en";
    return ViewModelBuilder<NotificationsViewModel>.reactive(
      viewModelBuilder: () => NotificationsViewModel(),
      builder: (context, model, _) => Scaffold(
        key: _scaffoldKey,
        drawer: getIsPhone() || isNotificationsRole
            ? AppDrawer(
                fromOrder: false,
                enLocal: _enLocal,
                arLocal: _arLocal,
                logOut: model.logoutRequest,
                reloadOrder: model.load,
              )
            : SizedBox(),
        appBar: CustomAppBar(
          backgroundColor: AppColors.mainDarkRedColor,
          startWidget: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                if (!getIsPhone() && !isNotificationsRole)
                  Icon(
                    Icons.arrow_back_outlined,
                    color: AppColors.whiteColor,
                    size: 30,
                  ),
                if (getIsPhone() || isNotificationsRole)
                  Icon(
                    Icons.menu,
                    color: AppColors.whiteColor,
                    size: 25,
                  ),
                SizedBox(
                  width: size.height / 15,
                ),
              ],
            ),
          ),
          onStartTap: () {
            if (!getIsPhone() && !isNotificationsRole) {
              navigationService.back();
            } else {
              _scaffoldKey.currentState!.isDrawerOpen
                  ? Navigator.of(context).pop()
                  : _scaffoldKey.currentState!.openDrawer();
            }
          },
          onEndTap: () {},
          title: tr('notifications_notifications'),
        ),
        body: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.all(20),
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            header: WaterDropHeader(),
            controller: model.notificationRefreshController,
            onRefresh: model.load,
            child: getIsPhone()
                ? ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemCount: model.notifictionList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return NewNotificationListItem(
                        onDeleteClick: () {
                          model.showConfirmDeleteCard(
                              id: model.notifictionList[index].id!);
                        },
                        notification: model.notifictionList[index],
                      );
                    },
                  )
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3.5,
                        // mainAxisExtent: 0.4,

                        crossAxisSpacing: size.height / 35),
                    itemCount: model.notifictionList.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return NewNotificationListItem(
                        onDeleteClick: () {
                          model.showConfirmDeleteCard(
                              id: model.notifictionList[index].id!);
                        },
                        notification: model.notifictionList[index],
                      );
                    }),
          ),
        ),
      ),
      onModelReady: (model) {
        model.load();
        model.listenToNewNotification();
      },
    );
  }
}
