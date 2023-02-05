// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../UI/views/installation/orders_details/installation_details_view.dart';
import '../UI/views/installation/report_problem/report_problem_view.dart';
import '../UI/views/maintenance_request/maintenance_request_view.dart';
import '../UI/views/maintenance_request/request_details/request_details_view.dart';
import '../UI/views/measurement/add_measurement_info/add_measurement_info_view.dart';
import '../UI/views/shared/log_in/log_in_view.dart';
import '../UI/views/shared/notifications/notifications_view.dart';
import '../UI/views/shared/orders_main_view/orders_view.dart';
import '../UI/views/shared/profile_view/profile_view.dart';
import '../UI/views/shared/splash_screen/splash_screen_view.dart';
import '../core/data/models/apis/maintenance_request.dart';
import '../core/data/models/apis/order_model.dart';

class Routes {
  static const String splashScreenView = '/';
  static const String logInView = '/log-in-view';
  static const String ordersView = '/orders-view';
  static const String addMeasurementInfoView = '/add-measurement-info-view';
  static const String notificationsView = '/notifications-view';
  static const String installationDetailsView = '/installation-details-view';
  static const String reportProblemView = '/report-problem-view';
  static const String profileView = '/profile-view';
  static const String maintenanceRequestView = '/maintenance-request-view';
  static const String requestDetailsView = '/request-details-view';
  static const all = <String>{
    splashScreenView,
    logInView,
    ordersView,
    addMeasurementInfoView,
    notificationsView,
    installationDetailsView,
    reportProblemView,
    profileView,
    maintenanceRequestView,
    requestDetailsView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashScreenView, page: SplashScreenView),
    RouteDef(Routes.logInView, page: LogInView),
    RouteDef(Routes.ordersView, page: OrdersView),
    RouteDef(Routes.addMeasurementInfoView, page: AddMeasurementInfoView),
    RouteDef(Routes.notificationsView, page: NotificationsView),
    RouteDef(Routes.installationDetailsView, page: InstallationDetailsView),
    RouteDef(Routes.reportProblemView, page: ReportProblemView),
    RouteDef(Routes.profileView, page: ProfileView),
    RouteDef(Routes.maintenanceRequestView, page: MaintenanceRequestView),
    RouteDef(Routes.requestDetailsView, page: RequestDetailsView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    SplashScreenView: (data) {
      var args = data.getArgs<SplashScreenViewArguments>(
        orElse: () => SplashScreenViewArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => SplashScreenView(key: args.key),
        settings: data,
      );
    },
    LogInView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const LogInView(),
        settings: data,
      );
    },
    OrdersView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const OrdersView(),
        settings: data,
      );
    },
    AddMeasurementInfoView: (data) {
      var args = data.getArgs<AddMeasurementInfoViewArguments>(nullOk: false);
      return CupertinoPageRoute<dynamic>(
        builder: (context) => AddMeasurementInfoView(
          key: args.key,
          id: args.id,
        ),
        settings: data,
      );
    },
    NotificationsView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const NotificationsView(),
        settings: data,
      );
    },
    InstallationDetailsView: (data) {
      var args = data.getArgs<InstallationDetailsViewArguments>(nullOk: false);
      return CupertinoPageRoute<dynamic>(
        builder: (context) => InstallationDetailsView(
          key: args.key,
          order: args.order,
        ),
        settings: data,
      );
    },
    ReportProblemView: (data) {
      var args = data.getArgs<ReportProblemViewArguments>(nullOk: false);
      return CupertinoPageRoute<dynamic>(
        builder: (context) => ReportProblemView(
          key: args.key,
          order: args.order,
        ),
        settings: data,
      );
    },
    ProfileView: (data) {
      var args = data.getArgs<ProfileViewArguments>(
        orElse: () => ProfileViewArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => ProfileView(key: args.key),
        settings: data,
      );
    },
    MaintenanceRequestView: (data) {
      var args = data.getArgs<MaintenanceRequestViewArguments>(
        orElse: () => MaintenanceRequestViewArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => MaintenanceRequestView(key: args.key),
        settings: data,
      );
    },
    RequestDetailsView: (data) {
      var args = data.getArgs<RequestDetailsViewArguments>(nullOk: false);
      return CupertinoPageRoute<dynamic>(
        builder: (context) => RequestDetailsView(
          key: args.key,
          request: args.request,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// SplashScreenView arguments holder class
class SplashScreenViewArguments {
  final Key? key;
  SplashScreenViewArguments({this.key});
}

/// AddMeasurementInfoView arguments holder class
class AddMeasurementInfoViewArguments {
  final Key? key;
  final String id;
  AddMeasurementInfoViewArguments({this.key, required this.id});
}

/// InstallationDetailsView arguments holder class
class InstallationDetailsViewArguments {
  final Key? key;
  final OrderModel order;
  InstallationDetailsViewArguments({this.key, required this.order});
}

/// ReportProblemView arguments holder class
class ReportProblemViewArguments {
  final Key? key;
  final OrderModel order;
  ReportProblemViewArguments({this.key, required this.order});
}

/// ProfileView arguments holder class
class ProfileViewArguments {
  final Key? key;
  ProfileViewArguments({this.key});
}

/// MaintenanceRequestView arguments holder class
class MaintenanceRequestViewArguments {
  final Key? key;
  MaintenanceRequestViewArguments({this.key});
}

/// RequestDetailsView arguments holder class
class RequestDetailsViewArguments {
  final Key? key;
  final MaintenanceRequest request;
  RequestDetailsViewArguments({this.key, required this.request});
}
