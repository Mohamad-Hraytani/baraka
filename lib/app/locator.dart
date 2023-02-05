//import 'package:data_connection_checker/data_connection_checker.dart';

import 'package:albarakakitchen/core/data/repository/account_repository.dart';
import 'package:albarakakitchen/core/data/repository/auth_repository.dart';
import 'package:albarakakitchen/core/data/repository/notification_repository.dart';
import 'package:albarakakitchen/core/data/repository/orders_repository.dart';
import 'package:albarakakitchen/core/data/repository/shared_prefrence_repository.dart';
import 'package:albarakakitchen/core/services/device_info_service.dart';
import 'package:albarakakitchen/core/services/notification_service.dart';
import 'package:albarakakitchen/core/services/order_service.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  final deviceInfoInstance = await DeviceInfoService.getInstance();

  //final deviceInfoInstance = await DeviceInfoService.getInstance();

  locator.registerSingleton<NotificationService>(NotificationService());

  locator.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  locator.registerLazySingleton<DeviceInfoService>(() => deviceInfoInstance);

  locator.registerLazySingleton<PackageInfo>(() => packageInfo);
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton<OrderService>(() => OrderService());
  locator.registerLazySingleton<AccountRepository>(() => AccountRepository());
  locator.registerLazySingleton<DialogService>(() => DialogService());
  locator.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepository());
  locator.registerLazySingleton<NotificationRepository>(
      () => NotificationRepository());

  //locator.registerLazySingleton<DeviceInfoService>(() => deviceInfoInstance);

  // locator.registerLazySingleton(() => DataConnectionChecker());
  locator.registerLazySingleton<SharedPreferencesRepository>(
      () => SharedPreferencesRepository());
  locator.registerLazySingleton<OrdersRepository>(() => OrdersRepository());

  //! Factories -----------------------------------------------------
  // locator.registerFactory(() => AuthenticationRepository());
}
