import 'package:albarakakitchen/UI/views/installation/orders_details/installation_details_view.dart';
import 'package:albarakakitchen/UI/views/installation/report_problem/report_problem_view.dart';
import 'package:albarakakitchen/UI/views/maintenance_request/maintenance_request_view.dart';
import 'package:albarakakitchen/UI/views/maintenance_request/request_details/request_details_view.dart';

import 'package:albarakakitchen/UI/views/measurement/add_measurement_info/add_measurement_info_view.dart';
import 'package:albarakakitchen/UI/views/shared/log_in/log_in_view.dart';
import 'package:albarakakitchen/UI/views/shared/notifications/notifications_view.dart';
import 'package:albarakakitchen/UI/views/shared/orders_main_view/orders_view.dart';
import 'package:albarakakitchen/UI/views/shared/profile_view/profile_view.dart';
import 'package:albarakakitchen/UI/views/shared/splash_screen/splash_screen_view.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [
    CupertinoRoute(
      page: SplashScreenView,
      initial: true,
    ),
    CupertinoRoute(page: LogInView),
    CupertinoRoute(page: OrdersView),
    CupertinoRoute(page: AddMeasurementInfoView),
    CupertinoRoute(page: NotificationsView),
    CupertinoRoute(page: InstallationDetailsView),
    CupertinoRoute(page: ReportProblemView),
    CupertinoRoute(page: ProfileView),
    CupertinoRoute(page: MaintenanceRequestView),

    CupertinoRoute(page: RequestDetailsView),
  ],
)
class AppRouter {}
