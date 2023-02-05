import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:albarakakitchen/core/utils/network_util.dart';

import 'UI/shared/custom_widgets/custom_image_picker.dart';
import 'app/app.dart';
import 'app/locator.dart';
import 'core/data/repository/shared_prefrence_repository.dart';
import 'core/services/custom_dialpg_service.dart';
import 'core/services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(
      NotificationService.firebaseMessagingBackgroundHandler);

  await EasyLocalization.ensureInitialized();
  await setupLocator();
  locator<SharedPreferencesRepository>().saveAppEnvironMent(env: 0);

  NetworkUtil.baseUrl = 'api-acceptance.barkakitchens.com';
  setUpServiceDialog();
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('ar', 'SA'), Locale('en', 'US')],
        startLocale:
            locator<SharedPreferencesRepository>().getAppLanguage() == "ar"
                ? Locale('ar', 'SA')
                : Locale('en', 'US'),
        path:
            'assets/translations', // <-- change the path of the translation files
        fallbackLocale: Locale('en', 'US'),
        child: App()),
  );
}
