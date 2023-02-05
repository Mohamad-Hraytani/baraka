import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:albarakakitchen/UI/shared/utils.dart';
import 'package:albarakakitchen/app/locator.dart';
import 'package:albarakakitchen/app/router.router.dart';
import 'package:albarakakitchen/core/data/models/apis/maintenance_request.dart';
import 'package:albarakakitchen/core/data/models/apis/order_model.dart';
import 'package:albarakakitchen/core/data/repository/shared_prefrence_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';

class NotificationService {
  NotificationService() {
    lisitenToForGroundMessages();
    requistFcmToken();
    onMessageOpen();

    initializelocal();
  }
  String? token;
  static StreamController<dynamic> streamController =
      StreamController.broadcast();
  static final stream = streamController.stream;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  void requisetPermissionsForIos() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
  }

  Future<String?> requistFcmToken() async {
    token = await messaging.getToken();
    log(token ?? '');
    return token;
  }

  initializelocal() async {
    flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('notification'),
      // iOS: initializationSettingsIOS,
      // macOS: initializationSettingsMacOS,
      // linux: initializationSettingsLinux,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        log('notification payload: $payload');
      }
      // selectedNotificationPayload = payload;
      // selectNotificationSubject.add(payload);
    });
  }

  void onMessageOpen() {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      ///On click message and open app ( Not terminated )
      ///
      final data = message.data;

      if (data["notification_type"] == "OrderAssignedToMeasuringTechnician") {
        navigationService.navigateTo(Routes.addMeasurementInfoView,
            arguments: AddMeasurementInfoViewArguments(
                id: OrderModel.fromJson(jsonDecode(data['order'])).id!));
      } else if (data["notification_type"] ==
          "MaintenanceRequestToTechnician") {
        navigationService.navigateTo(Routes.requestDetailsView,
            arguments: RequestDetailsViewArguments(
                request:
                    MaintenanceRequest.fromJson(jsonDecode(data['request']))));
      } else {
        navigationService.navigateTo(Routes.installationDetailsView,
            arguments: InstallationDetailsViewArguments(
                order: OrderModel.fromJson(jsonDecode(data['order']))));
      }
      addEventToBroadCast(message);
    }, onError: (v) {
      log(v.toString(), name: "Error onMessageOpenedApp notifications");
    });
  }

  void lisitenToForGroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails('your channel id', 'your channel name',
              importance: Importance.max,
              priority: Priority.high,
              enableLights: true,
              playSound: true,
              styleInformation: BigTextStyleInformation(''),
              showWhen: true);
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.show(
        0,

        message.notification!.title,
        message.notification!.body,
        platformChannelSpecifics,
        payload: json.encode(message.data),
        // payload: event.notification.,
      );
      addEventToBroadCast(message);
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    streamController.add(message);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    prefs.setBool(SharedPreferencesRepository.SHOULD_RELOAD, true);
    final x = prefs.getBool(SharedPreferencesRepository.SHOULD_RELOAD);
    log(x.toString());
    // await prefs.reload();

    print("Handling a background message: ${message.messageId}");
  }

  void addEventToBroadCast(RemoteMessage event) {
    log(event.data.toString());

    streamController.add(event);
  }

  void config() async {
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('notification');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: localNotificationOnClick,

      // onSelectNotification:
    );
  }

  Future<dynamic> localNotificationOnClick(String? message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    // await Firebase.initializeApp();
    // log('Handling a background message ${message.messageType}');
    // final notifcationModel = NotificationModel.fromJson(message.data);
    // log(NotificationModel.fromJson(message.data).toString());
    // streamController.add(notifcationModel);
    log(message ?? '');

    return message;
  }
}
