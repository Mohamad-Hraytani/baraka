import 'package:albarakakitchen/UI/shared/colors.dart';
import 'package:albarakakitchen/UI/shared/custom_widgets/app_drawer.dart';
import 'package:albarakakitchen/UI/shared/shared_widgets/custom_app_bar.dart';
import 'package:albarakakitchen/UI/shared/utils.dart';
import 'package:albarakakitchen/UI/views/maintenance_request/maintenance_request_view_model.dart';
import 'package:albarakakitchen/UI/views/maintenance_request/maintenance_request_widgets/request_list_item.dart';
import 'package:albarakakitchen/app/router.router.dart';
import 'package:albarakakitchen/core/utils/general_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';

class MaintenanceRequestView extends StatefulWidget {
  MaintenanceRequestView({Key? key}) : super(key: key);

  @override
  State<MaintenanceRequestView> createState() => _MaintenanceRequestViewState();
}

class _MaintenanceRequestViewState extends State<MaintenanceRequestView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    bool _arLocal = EasyLocalization.of(context)?.locale.languageCode == "ar";
    bool _enLocal = EasyLocalization.of(context)?.locale.languageCode == "en";
    final size = MediaQuery.of(context).size;

    return ViewModelBuilder<MaintenanceRequetViewModel>.reactive(
      viewModelBuilder: () => MaintenanceRequetViewModel(),
      builder: (context, model, _) => Scaffold(
        backgroundColor: AppColors.mainLightGreyColor,
        key: _scaffoldKey,
        drawer: AppDrawer(
          fromOrder: false,
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
                  navigationService.navigateTo(Routes.notificationsView);
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
          title: tr('maintenance_request'),
        ),
        body: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.all(20),
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            header: WaterDropHeader(),
            controller: model.requestListRefreshController,
            onRefresh: model.load,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.1,
                    // mainAxisExtent: 0.4,

                    crossAxisSpacing: size.height / 35),
                itemCount: model.requestsList.length,
                itemBuilder: (BuildContext ctx, index) {
                  //return Text('');
                  return model.requestsList.length == 0
                      ? Container()
                      : RequestListItem(request: model.requestsList[index]);
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
