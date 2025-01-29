import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:foody_app/main.dart' show objectBox;

import '../models/user.dart';

Future<void> _backgroundHandler(RemoteMessage message) async {
  print("NOTIFICA RICEVUTA IN BACKGROUND");
}

FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

AndroidNotificationChannel _channel = const AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'This channel is used for important notifications.',
  importance: Importance.high,
);

Future<void> _setupFlutterNotifications() async {
  _flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await _flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(_channel);

  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

bool _hasChatOpen(RemoteMessage message) {
  final userBox = objectBox.store.box<User>();
  final user = userBox.getAll();

  return user.isNotEmpty &&
      message.data.containsKey("roomId") &&
      user.first.currentFirebaseRoomId == message.data["roomId"];
}

Future<void> _showLocalNotification(RemoteMessage message) async {
  if (_hasChatOpen(message)) return;

  final notification = message.notification;

  if (notification?.android != null) {
    _flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification?.title,
      notification?.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          icon: '@mipmap/ic_notification',
          color: const Color(0xff03413e),
        ),
      ),
    );
  }
}

Future<void> initFirebaseFCM() async {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    _showLocalNotification(message);
  });

  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);

  await _setupFlutterNotifications();
}
