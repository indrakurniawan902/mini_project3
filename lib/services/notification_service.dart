import 'dart:convert';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static ValueNotifier<String> payload = ValueNotifier("");

  void setPayload(String newPayload) {
    payload.value = newPayload;
  }

  static AndroidNotificationDetails androidNotificationDetails =
      const AndroidNotificationDetails(
    "Local Notif",
    "Example Local Notif",
    channelDescription: "Percobaan Local Notif",
    importance: Importance.max,
    priority: Priority.high,
    icon: "@mipmap/ic_launcher",
    playSound: true,
    enableVibration: true,
  );

  static DarwinNotificationDetails iosNotificationDetails =
      const DarwinNotificationDetails(
    threadIdentifier: "Local Notif",
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  static NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
    iOS: iosNotificationDetails,
  );

  Future<void> initLocalNotifications() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    const initializationIos = DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationIos,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        debugPrint("Notification Ditekan ${details.payload}");
        setPayload(details.payload ?? "");
      },
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }
}

class FcmService {
  Future<void> initFCM() async {
    final firebaseMessaging = FirebaseMessaging.instance;
    await firebaseMessaging.requestPermission();
    final fcmToken = await firebaseMessaging.getToken();
    debugPrint("Token : $fcmToken");

    firebaseMessaging.getInitialMessage().then((value) {
      LocalNotificationService.payload.value = jsonEncode({
        "title": value?.notification?.title,
        "body": value?.notification?.body,
        "data": value?.data,
      });
    });
    FirebaseMessaging.onMessageOpenedApp.listen(
      (value) {
        LocalNotificationService.payload.value = jsonEncode({
          "title": value.notification?.title,
          "body": value.notification?.body,
          "data": value.data,
        });
      },
    );
    FirebaseMessaging.onMessage.listen(
      (message) async {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        if (notification != null && android != null && !kIsWeb) {
          await LocalNotificationService.flutterLocalNotificationsPlugin.show(
              Random().nextInt(99),
              notification.title,
              notification.body,
              payload: jsonEncode({
                "title": notification.title,
                "body": notification.body,
                "data": message.data,
              }),
              LocalNotificationService.notificationDetails);
        }
      },
    );
  }

  static Map<String, dynamic> tryDecode(data) {
    try {
      return jsonDecode(data);
    } catch (e) {
      return {};
    }
  }
}
