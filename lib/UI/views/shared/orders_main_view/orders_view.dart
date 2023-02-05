import 'dart:convert';
import 'dart:developer';

import 'package:albarakakitchen/UI/shared/colors.dart';
import 'package:albarakakitchen/UI/shared/custom_widgets/app_drawer.dart';
import 'package:albarakakitchen/UI/shared/shared_widgets/custom_app_bar.dart';
import 'package:albarakakitchen/UI/shared/utils.dart';

import 'package:albarakakitchen/UI/views/shared/orders_main_view/orders_widgets/new_order_list_item.dart';
import 'package:albarakakitchen/app/locator.dart';
import 'package:albarakakitchen/app/router.router.dart';
import 'package:albarakakitchen/core/data/models/apis/maintenance_request.dart';
import 'package:albarakakitchen/core/data/models/apis/order_model.dart';
import 'package:albarakakitchen/core/data/repository/shared_prefrence_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'orders_view_model.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  @override
  void initState() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      if (message != null) {
        final data = message.data;

        if (data["notification_type"] == "OrderAssignedToMeasuringTechnician") {
          navigationService.navigateTo(Routes.addMeasurementInfoView,
              arguments: AddMeasurementInfoViewArguments(
                  id: OrderModel.fromJson(jsonDecode(data['order'])).id!));
        } else if (data["notification_type"] ==
            "MaintenanceRequestToTechnician") {
          navigationService.navigateTo(Routes.requestDetailsView,
              arguments: RequestDetailsViewArguments(
                  request: MaintenanceRequest.fromJson(
                      jsonDecode(data['request']))));
        } else {
          navigationService.navigateTo(Routes.installationDetailsView,
              arguments: InstallationDetailsViewArguments(
                  order: OrderModel.fromJson(jsonDecode(data['order']))));
        }
      }
    });
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  SharedPreferencesRepository _sharedPreferencesRepository =
      locator<SharedPreferencesRepository>();

  @override
  Widget build(BuildContext context) {
    bool _arLocal = EasyLocalization.of(context)?.locale.languageCode == "ar";
    bool _enLocal = EasyLocalization.of(context)?.locale.languageCode == "en";
    final size = MediaQuery.of(context).size;
    log(size.longestSide.toString());
    return ViewModelBuilder<OrdersViewModel>.reactive(
      viewModelBuilder: () => OrdersViewModel(),
      builder: (context, model, _) => Scaffold(
        backgroundColor: AppColors.mainLightGreyColor,
        key: _scaffoldKey,
        drawer: AppDrawer(
          fromOrder: true,
          enLocal: _enLocal,
          arLocal: _arLocal,
          logOut: model.logoutRequest,
          reloadOrder: model.load,
        ),
        appBar: CustomAppBar(
          backgroundColor: AppColors.mainDarkRedColor,
          startWidget: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Icon(
                  Icons.menu,
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
            _scaffoldKey.currentState!.isDrawerOpen
                ? Navigator.of(context).pop()
                : _scaffoldKey.currentState!.openDrawer();
          },
          endWidget: Row(
            children: [
              InkWell(
                onTap: () {
                  locator<NavigationService>()
                      .navigateTo(Routes.notificationsView);
                },
                child: Icon(
                  Icons.notifications,
                  color: AppColors.whiteColor,
                  size: 30,
                ),
              ),
              SizedBox(
                width: size.height / 30,
              ),
              InkWell(
                onTap: () {
                  navigationService.navigateTo(Routes.profileView);
                },
                child: Icon(
                  Icons.person,
                  color: AppColors.whiteColor,
                  size: 30,
                ),
              ),
              SizedBox(
                width: size.height / 40,
              ),
            ],
          ),
          onEndTap: () {},
          title: tr('order_my_order'),
        ),
        body: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.all(20),
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            header: WaterDropHeader(),
            controller: model.ordersListRefreshController,
            onRefresh: model.load,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.1,
                    // mainAxisExtent: 0.4,

                    crossAxisSpacing: size.height / 35),
                itemCount: model.ordersList?.length ?? 0,
                itemBuilder: (BuildContext ctx, index) {
                  return model.ordersList == null
                      ? Container()
                      : NewOrderListItem(
                          order: model.ordersList![index],
                          installationVisit: () async {
                            model.installationVisit(model.ordersList![index]);
                          },
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
