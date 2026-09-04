import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:krishi_mart/app/my_app.dart';
import 'package:krishi_mart/di/get_di.dart';
import 'package:krishi_mart/helpers/notification/notification_service.dart';
import 'package:krishi_mart/utils/utility.dart';

bool _firebaseReady = false;

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await init();
      await _initializeFirebaseMessaging();
      await _initializeNotifications();
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

      FlutterError.onError = (final FlutterErrorDetails errorDetails) {
        FlutterError.presentError(errorDetails);
        if (kReleaseMode && _firebaseReady) {
          FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
        }
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        if (kReleaseMode && _firebaseReady) {
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        }

        return true;
      };
      runApp(const MyApp());

      if (Platform.isAndroid) {
        final int version = await Utility.getAndroidOSVersion();

        if (version >= 35) {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        }
      }

      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      );
    },
    (error, stack) {
      if (kReleaseMode) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      }
    },
  );
}

Future<void> _initializeFirebaseMessaging() async {
  try {
    await Firebase.initializeApp();
    _firebaseReady = true;

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
  }
}

Future<void> _initializeNotifications() async {
  try {
    await NotificationService().setupInteractedMessage();
  } catch (e, stackTrace) {
    debugPrint('Notification service initialization failed: $e');
    if (_firebaseReady) {
      await FirebaseCrashlytics.instance.recordError(
        e,
        stackTrace,
        reason: 'Notification service initialization failed',
      );
    }
  }
}
