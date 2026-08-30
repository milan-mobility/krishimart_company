import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:krishi_mart/data/model/notification_model.dart';
import 'package:krishi_mart/data/pref_helper/shared_pref_helper.dart';
import 'package:krishi_mart/helpers/app_colors.dart';

class NotificationService with WidgetsBindingObserver {
  static PushNotificationModel? _pendingInitialNotification;
  static bool _isInitialNavigationReady = false;
  static bool _isDeliveringInitialNotification = false;
  static bool _isAppLifecycleObserverRegistered = false;

  static const MethodChannel _appLifecycleChannel = MethodChannel(
    'krishi_mart/app_lifecycle',
  );

  bool _wasInBackground = false;

  final SharedPreferenceHelper sharedPref = Get.find<SharedPreferenceHelper>();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> setupInteractedMessage() async {
    _registerAppLifecycleObserver();

    // Get token independently.
    await getFCMToken();

    try {
      await _requestNotificationPermission();
    } catch (e, stackTrace) {
      debugPrint('Notification permission error => $e');
      FirebaseCrashlytics.instance.recordError(
        e,
        stackTrace,
        reason: 'Notification permission setup failed',
      );
    }

    try {
      await _initializeLocalNotifications();
    } catch (e, stackTrace) {
      debugPrint('Local notification initialization error => $e');
      FirebaseCrashlytics.instance.recordError(
        e,
        stackTrace,
        reason: 'Local notification initialization failed',
      );
    }

    _registerForegroundListener();

    _registerNotificationOpenedListener();

    await _handleLocalNotificationLaunch();

    // Android data-only pushes are shown through flutter_local_notifications.
    // Its launch details confirm an actual notification tap; processing an FCM
    // initial message here can reuse a stale payload when the user opens the
    // app normally. iOS uses the FCM initial-message flow.
    if (!Platform.isAndroid) {
      await _handleTerminatedNotification();
    }
  }

  void _registerAppLifecycleObserver() {
    if (_isAppLifecycleObserverRegistered) {
      return;
    }

    _isAppLifecycleObserverRegistered = true;
    WidgetsBinding.instance.addObserver(this);
    _appLifecycleChannel.setMethodCallHandler((final MethodCall call) async {
      if (call.method != 'openedFromLauncher' &&
          call.method != 'launchSourceChanged') {
        return;
      }

      final bool openedFromLauncher =
          call.method == 'openedFromLauncher' ||
          (call.arguments is Map &&
              (call.arguments as Map<Object?, Object?>)['openedFromLauncher'] ==
                  true);
      if (openedFromLauncher) {
        _clearPendingNotificationNavigation();
      }
    });

    unawaited(_syncInitialLaunchSource());
  }

  Future<void> _syncInitialLaunchSource() async {
    try {
      final bool? openedFromLauncher = await _appLifecycleChannel
          .invokeMethod<bool>('wasOpenedFromLauncher');
      if (openedFromLauncher == true) {
        _clearPendingNotificationNavigation();
      }
    } on MissingPluginException {
      // iOS does not provide this Android-specific launch-source channel.
    } catch (e) {
      debugPrint('App lifecycle channel error => $e');
    }
  }

  void _clearPendingNotificationNavigation() {
    // A launcher-icon open must not reuse a previous notification route.
    _pendingInitialNotification = null;
    _isDeliveringInitialNotification = false;
  }

  @override
  void didChangeAppLifecycleState(final AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden) {
      _wasInBackground = true;
      return;
    }

    if (state == AppLifecycleState.resumed && _wasInBackground) {
      _wasInBackground = false;
      unawaited(_refreshAfterBackground());
    }
  }

  Future<void> _refreshAfterBackground() async {
    if (!sharedPref.isLoggedIn) {
      return;
    }

    try {
      await Future.wait(<Future<void>>[
        // Get.find<HomeController>().getHomeData(refreshNotifications: true),
        // if (Get.isRegistered<AppointmentController>())
        //   Get.find<AppointmentController>().getAppointments(),
        // if (Get.isRegistered<AppointmentDetailController>())
        //   Get.find<AppointmentDetailController>().getAppointmentDetail(),
      ]);
    } catch (e, stackTrace) {
      debugPrint('Background resume refresh error => $e');
      FirebaseCrashlytics.instance.recordError(
        e,
        stackTrace,
        reason: 'Background resume refresh failed',
      );
    }
  }

  Future<void> _requestNotificationPermission() async {
    final NotificationSettings settings = await FirebaseMessaging.instance
        .requestPermission(alert: true, badge: true, sound: true);

    debugPrint('Notification Permission => ${settings.authorizationStatus}');
  }

  Future<void> _initializeLocalNotifications() async {
    final AndroidNotificationChannel channel = androidNotificationChannel();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('ic_notification');

    const DarwinInitializationSettings iOSSettings =
        DarwinInitializationSettings(
          requestSoundPermission: true,
          requestBadgePermission: true,
          requestAlertPermission: true,
        );

    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iOSSettings);

    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (final NotificationResponse response) {
        final String? payload = response.payload;

        if (payload == null || payload.isEmpty) {
          return;
        }

        try {
          final Map<String, dynamic> data = Map<String, dynamic>.from(
            jsonDecode(payload),
          );

          debugPrint('LOCAL NOTIFICATION CLICK => $data');

          unawaited(
            redirectFromNotification(PushNotificationModel.fromJson(data)),
          );
        } catch (e) {
          debugPrint('Local notification payload parsing error => $e');
        }
      },
    );
  }

  void _registerForegroundListener() {
    FirebaseMessaging.onMessage.listen((final RemoteMessage message) async {
      try {
        debugPrint('================ FCM FOREGROUND ================');

        debugPrint('Message ID => ${message.messageId}');

        debugPrint('FCM DATA => ${message.data}');

        final Map<String, dynamic> data = Map<String, dynamic>.from(
          message.data,
        );
        final RemoteNotification? remoteNotification = message.notification;

        // Firebase Console messages generally use the `notification` payload
        // and do not include custom data. Convert that payload into the same
        // model used by data messages so foreground notifications still show.
        if (remoteNotification != null) {
          data.putIfAbsent('title', () => remoteNotification.title ?? '');
          data.putIfAbsent('body', () => remoteNotification.body ?? '');
        }

        if (data.isEmpty) {
          debugPrint('FCM message has no notification or data payload');
          return;
        }

        final PushNotificationModel notification =
            PushNotificationModel.fromJson(data);

        if (sharedPref.isLoggedIn) {
          // Get.find<CommonController>().refreshNotifications(showLoader: false);
        }

        //Move
        refreshApis(notification);

        debugPrint('TITLE => ${notification.title}');

        debugPrint('================================================');

        if (Platform.isAndroid) {
          await _showAndroidNotification(
            message: message,
            notification: notification,
          );
        }

        /*
           * For iOS:
           *
           * Since Laravel sends data-only payload,
           * iOS will NOT automatically display
           * message.notification title/body.
           *
           * If you also want foreground local notification
           * on iOS, you can show the local notification here.
           */
      } catch (e, stackTrace) {
        debugPrint('Foreground FCM error => $e');

        debugPrint('StackTrace => $stackTrace');
      }
    });
  }

  Future<void> _showAndroidNotification({
    required final RemoteMessage message,
    required final PushNotificationModel notification,
  }) async {
    final AndroidNotificationChannel channel = androidNotificationChannel();

    final String title = notification.title ?? '';

    final String body = notification.message ?? '';

    if (title.isEmpty && body.isEmpty) {
      debugPrint('Notification title and body both empty');
      return;
    }

    await flutterLocalNotificationsPlugin.show(
      id:
          message.messageId?.hashCode ??
          DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title: title,
      body: body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          color: AppColors.themeColor,
          icon: 'ic_notification',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          enableVibration: true,
        ),
      ),
      payload: jsonEncode(notification.toJson()),
    );
  }

  void _registerNotificationOpenedListener() {
    FirebaseMessaging.onMessageOpenedApp.listen((final RemoteMessage message) {
      try {
        debugPrint('FCM OPENED FROM BACKGROUND');

        debugPrint('FCM DATA => ${message.data}');

        if (message.data.isEmpty) {
          return;
        }

        unawaited(
          redirectFromNotification(
            PushNotificationModel.fromJson(
              Map<String, dynamic>.from(message.data),
            ),
          ),
        );
      } catch (e) {
        debugPrint('onMessageOpenedApp error => $e');
      }
    });
  }

  Future<void> _handleTerminatedNotification() async {
    try {
      final RemoteMessage? message = await FirebaseMessaging.instance
          .getInitialMessage();

      if (message == null) {
        return;
      }

      debugPrint('FCM OPENED FROM TERMINATED');

      debugPrint('FCM DATA => ${message.data}');

      if (message.data.isEmpty) {
        return;
      }

      _pendingInitialNotification = PushNotificationModel.fromJson(
        Map<String, dynamic>.from(message.data),
      );
      _deliverPendingInitialNotification();
    } catch (e) {
      debugPrint('getInitialMessage error => $e');
    }
  }

  /// A data-only FCM message shown by the background isolate is a local
  /// notification. Tapping it after a terminated launch is not returned by
  /// Firebase's getInitialMessage(), so read the local plugin's launch data too.
  Future<void> _handleLocalNotificationLaunch() async {
    try {
      final NotificationAppLaunchDetails? launchDetails =
          await flutterLocalNotificationsPlugin
              .getNotificationAppLaunchDetails();
      final String? payload = launchDetails?.notificationResponse?.payload;

      if (launchDetails?.didNotificationLaunchApp != true ||
          payload == null ||
          payload.isEmpty) {
        return;
      }

      // Android keeps these launch details in the plugin after a Flutter hot
      // restart. Consume each payload once so a previous notification cannot
      // push Appointment Detail again after the app returns to Home.
      // if (sharedPref.lastHandledLocalNotificationLaunch == payload) {
      //   return;
      // }
      // await sharedPref.saveLastHandledLocalNotificationLaunch(payload);

      _pendingInitialNotification = PushNotificationModel.fromJson(
        Map<String, dynamic>.from(jsonDecode(payload)),
      );
      _deliverPendingInitialNotification();
    } catch (e, stackTrace) {
      debugPrint('Local notification launch parsing error => $e');
      FirebaseCrashlytics.instance.recordError(
        e,
        stackTrace,
        reason: 'Local notification launch parsing failed',
      );
    }
  }

  /// Call this after the splash screen redirects to the authenticated app.
  /// It is deliberately safe if the FCM initial message arrives later.
  void markInitialNavigationReady() {
    _isInitialNavigationReady = true;
    _deliverPendingInitialNotification();
  }

  void _deliverPendingInitialNotification() {
    final PushNotificationModel? notification = _pendingInitialNotification;
    if (!_isInitialNavigationReady ||
        _isDeliveringInitialNotification ||
        notification == null) {
      return;
    }

    _isDeliveringInitialNotification = true;
    _pendingInitialNotification = null;

    // Let Get.offAllNamed(home) from splash install its route before pushing
    // the notification destination above it.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(
        redirectFromNotification(notification).whenComplete(() {
          _isDeliveringInitialNotification = false;
        }),
      );
    });
  }

  Future<void> getFCMToken() async {
    try {
      await FirebaseMessaging.instance.setAutoInitEnabled(true);

      final String? token = await FirebaseMessaging.instance.getToken();

      debugPrint('======================================');
      debugPrint('FCM TOKEN => $token');
      debugPrint('======================================');

      if (token != null && token.isNotEmpty) {
        await sharedPref.saveFcmToken(token);
      } else {
        FirebaseCrashlytics.instance.log('FCM token returned NULL or empty');
      }
    } catch (e, stackTrace) {
      debugPrint('FCM TOKEN ERROR => $e');
      debugPrint('FCM TOKEN STACK => $stackTrace');

      FirebaseCrashlytics.instance.recordError(
        e,
        stackTrace,
        reason: 'FCM token generation failed',
        fatal: false,
      );
    }

    FirebaseMessaging.instance.onTokenRefresh.listen(
      (final String newToken) async {
        debugPrint('FCM TOKEN REFRESH => $newToken');

        if (newToken.isNotEmpty) {
          await sharedPref.saveFcmToken(newToken);
        }
      },
      onError: (Object error, StackTrace stackTrace) {
        debugPrint('FCM TOKEN REFRESH ERROR => $error');

        FirebaseCrashlytics.instance.recordError(
          error,
          stackTrace,
          reason: 'FCM token refresh failed',
          fatal: false,
        );
      },
    );
  }

  Future<void> enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  AndroidNotificationChannel androidNotificationChannel() =>
      const AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'This channel is used for important notifications.',
        importance: Importance.max,
      );

  Future<void> redirectFromNotification(
    final PushNotificationModel notification,
  ) async {
    debugPrint('REDIRECT PAYLOAD => ${notification.toJson()}');

    // The push payload contains `notify_id`; mark that exact notification as
    // read and refresh shared notification state before navigating.
    await _refreshNotificationData(notification);

    /*switch (notification.type) {
      case 'appointment':
        final String appointmentId =
            notification.appointmentId?.toString() ?? '';

        debugPrint('Redirect appointment => $appointmentId');

        Get.toNamed(
          RouteHelper.appointmentDetail,
          arguments: {
            'appointment_id': appointmentId,
            'appointmentType': AppointmentType.upcoming,
          },
        );
        break;

      case 'profile':
        Get.toNamed(RouteHelper.doctorProfile);
        break;

      default:
        debugPrint('Unknown notification type => ${notification.type}');
    }*/
  }

  Future<void> _refreshNotificationData(
    final PushNotificationModel notification,
  ) async {
    //   try {
    //     final CommonController commonController = Get.find<CommonController>();
    //
    //     final int? notificationId = notification.notificationId;
    //     if (notificationId != null) {
    //       await commonController.readNotification(notificationId);
    //     } else {
    //       debugPrint(
    //         'Notification tap could not be marked read. Send notify_id in FCM data.',
    //       );
    //     }
    //
    //     // readNotification refreshes on success; refresh again so the global
    //     // list and unread badge remain accurate for every notification type.
    //     if (sharedPref.isLoggedIn) {
    //       await commonController.refreshNotifications(showLoader: false);
    //     }
    //
    //     await Future.wait(<Future<void>>[refreshApis(notification)]);
    //   } catch (e, stackTrace) {
    //     debugPrint('Notification refresh error => $e');
    //     FirebaseCrashlytics.instance.recordError(
    //       e,
    //       stackTrace,
    //       reason: 'Notification tap refresh failed',
    //     );
    //   }
    // }
  }

  Future<void> refreshApis(final PushNotificationModel notification) async {
    // if (notification.type == 'appointment') {
    //   if (Get.isRegistered<HomeController>()) {
    //     await Get.find<HomeController>().getHomeData(refreshNotifications: true);
    //   }
    //   if (Get.isRegistered<AppointmentController>()) {
    //     await Get.find<AppointmentController>().getAppointments();
    //   }
    //
    //   if (Get.isRegistered<AppointmentDetailController>()) {
    //     await Get.find<AppointmentDetailController>().getAppointmentDetail();
    //   }
    // } else if (notification.type == 'profile') {
    //   await Get.find<CommonController>().getUserDetail();
    // }
  }

  /// Data-only FCM messages are not rendered by Android while the app is in the
  /// background or terminated. Display a local notification from the background
  /// isolate instead.
  static Future<void> _showBackgroundAndroidNotification({
    required final RemoteMessage message,
    required final PushNotificationModel notification,
  }) async {
    try {
      final FlutterLocalNotificationsPlugin localNotifications =
          FlutterLocalNotificationsPlugin();
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'This channel is used for important notifications.',
        importance: Importance.max,
      );

      await localNotifications.initialize(
        settings: InitializationSettings(
          android: AndroidInitializationSettings('ic_notification'),
        ),
      );
      await localNotifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(channel);

      await localNotifications.show(
        id:
            message.messageId?.hashCode ??
            DateTime.now().millisecondsSinceEpoch.remainder(100000),
        title: notification.title?.isNotEmpty == true
            ? notification.title
            : 'Appointment update',
        body: notification.message ?? '',
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription:
                'This channel is used for important notifications.',
            icon: 'ic_notification',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            enableVibration: true,
          ),
        ),
        payload: jsonEncode(notification.toJson()),
      );
    } catch (e, stackTrace) {
      debugPrint('Background local notification error => $e');
      FirebaseCrashlytics.instance.recordError(
        e,
        stackTrace,
        reason: 'Background local notification display failed',
      );
    }
  }
}

/// Firebase invokes this top-level callback in a background isolate.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(
  final RemoteMessage message,
) async {
  await Firebase.initializeApp();
  DartPluginRegistrant.ensureInitialized();

  debugPrint('================ FCM BACKGROUND ================');
  debugPrint('Message ID => ${message.messageId}');
  debugPrint('FCM BACKGROUND DATA => ${message.data}');

  if (message.data.isEmpty) {
    debugPrint('Background message.data is empty');
    return;
  }

  final PushNotificationModel notification = PushNotificationModel.fromJson(
    Map<String, dynamic>.from(message.data),
  );

  if (Platform.isAndroid) {
    await NotificationService._showBackgroundAndroidNotification(
      message: message,
      notification: notification,
    );
  }
}
