// import 'package:dio/dio.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// final dio = Dio();

// Future<void> handleBackgroundMessage(RemoteMessage message) async {}

// const _androidChannel = AndroidNotificationChannel(
//     "high_importance_channel", "High Importance Notification",
//     description: "Used for importance notification",
//     importance: Importance.defaultImportance);

// final _localNotification = FlutterLocalNotificationsPlugin();

// Future<void> handleMessage(RemoteMessage? message) async {
//   print("Message : ${message!.data["sender"]}");
//   navigatorKey.currentState?.pushNamed(ChatScreen.routeName,
//       arguments: ChatParams(
//         sender: UserModel.fromJson(message.data["sender"]),
//         receiver: UserModel.fromJson(message.data["receiver"]),
//       ));
// }

// // Future initLocalNotification() async {
// //   const android = AndroidInitializationSettings("@drawable/launch_background");
// //   const setting = InitializationSettings(android: android);

// //   await _localNotification.initialize(setting,
// //       onDidReceiveNotificationResponse: (payload) {
// //     final message = RemoteMessage.fromMap(jsonDecode(payload as String));
// //     handleMessage(message);
// //   });
// // }

// Future initPushnotification() async {
//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );

//   FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
//   FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//   FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
//   // FirebaseMessaging.onMessage.listen((event) {
//   //   final notification = event.notification;
//   //   if (notification == null) return;
//   //   _localNotification.show(
//   //       notification.hashCode,
//   //       notification.title,
//   //       notification.body,
//   //       NotificationDetails(
//   //           android: AndroidNotificationDetails(
//   //         _androidChannel.id,
//   //         _androidChannel.name,
//   //         channelDescription: _androidChannel.description,
//   //       )),
//   //       payload: jsonEncode(event.toMap()));
//   // });
// }

// class NotificationService extends ChangeNotifier {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

//   Future<void> initNotification() async {
//     _firebaseMessaging.requestPermission();
//     initPushnotification();
//     // initLocalNotification();
//   }

//   Future<void> sendNotif(
//       String message, UserModel sender, UserModel receiver, String id) async {
//     Map<String, dynamic> headers = {
//       'Authorization':
//           'key=AAAAcbITNZo:APA91bFC31HTKBUweqUTGru8kyVRnytZw4OjqSkxXkO25fai6avWg9UqHf3ejBWgbOBUPIT2VBbuetLKtMrt_AbaxfLJ8naxH70F1DTCgv9JsKpYN7KgOqOmaNW8ZK4qijuPYHL4PwMo',
//       'Content-Type': 'application/json',
//     };

//     try {
//       Response response = await dio.post("https://fcm.googleapis.com/fcm/send",
//           data: {
//             "to": "/topics/$id",
//             "notification": {"title": "${sender.name}", "body": message},
//             "data": {"sender": sender.toJson(), "receiver": receiver.toJson()}
//           },
//           options: Options(headers: headers));
//     } on DioException catch (e) {
//       print(e.toString());
//     }
//   }
// }