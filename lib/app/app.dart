import 'dart:developer';

import 'package:albarakakitchen/UI/shared/colors.dart';
import 'package:albarakakitchen/core/data/repository/shared_prefrence_repository.dart';
import 'package:albarakakitchen/core/services/notification_service.dart';
import 'package:albarakakitchen/core/utils/general_utils.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app_config.dart' as config;
import '../core/services/connectivity_service.dart';
import 'app_view_model.dart';
import 'router.router.dart';

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.reload();
      final x2 = prefs.getBool(SharedPreferencesRepository.SHOULD_RELOAD);
      log(x2.toString());

      if (x2 ?? false) {
        prefs.setBool(SharedPreferencesRepository.SHOULD_RELOAD, false);
        NotificationService.streamController.add('measurement_finished');
      }

      // FirebaseMessaging.instance.getInitialMessage().then((value) {
      //   log(value?.toString() ?? "");
      // });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    if (!getIsPhone()) {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    } else {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitUp]);
      // [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    }

    return ViewModelBuilder<AppViewModel>.reactive(
      viewModelBuilder: () => AppViewModel(),
      onModelReady: (model) {},
      builder: (context, model, child) {
        return StreamProvider<ConnectivityStatus>(
            catchError: (context, error) => ConnectivityStatus.Offline,
            initialData: ConnectivityStatus.Online,
            create: (context) =>
                ConnectivityService().connectionStatusController.stream,
            child: MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,

              onGenerateRoute: StackedRouter().onGenerateRoute,
              navigatorKey: StackedService.navigatorKey,
              title: 'Albaraka Kitchen',
              builder: (context, child) {
                child = ExtendedNavigator<StackedRouter>(
                  name: 'app_main_router',
                  observers: [
                    BotToastNavigatorObserver(),
                  ],
                  navigatorKey: StackedService.navigatorKey,
                  router: StackedRouter(),
                );
                child = botToastBuilder(context, child);
                return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                    child: Stack(
                      children: [child],
                    ));
              },

              theme: ThemeData(
                fontFamily: 'cairo',
                primaryColor: AppColors.mainLightGreyColor,
                brightness: Brightness.light,
                accentColor: AppColors.mainLightGreyColor,
                focusColor: config.Colors().accentColor(1),
                hintColor: config.Colors().secondColor(1),
              ),
              debugShowCheckedModeBanner: false,
              // ),
            ));
      },
    );
  }
}
